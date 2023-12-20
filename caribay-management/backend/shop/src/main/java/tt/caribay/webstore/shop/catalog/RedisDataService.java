package tt.caribay.webstore.shop.catalog;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.enterprise.event.Observes;
import javax.inject.Singleton;

import com.redis.lettucemod.RedisModulesClient;
import com.redis.lettucemod.api.StatefulRedisModulesConnection;
import com.redis.lettucemod.api.async.RedisJSONAsyncCommands;
import com.redis.lettucemod.api.reactive.RedisJSONReactiveCommands;

import org.apache.commons.compress.utils.Lists;
import org.eclipse.microprofile.config.ConfigProvider;

import io.lettuce.core.LettuceFutures;
import io.lettuce.core.RedisFuture;
import io.lettuce.core.api.reactive.RedisReactiveCommands;
import io.quarkus.runtime.ShutdownEvent;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import io.smallrye.mutiny.tuples.Tuple2;

@Singleton
public class RedisDataService {
    
    private final RedisModulesClient client;
    private final StatefulRedisModulesConnection<String, String> connection;
    private final RedisReactiveCommands<String, String> commands;
    private final RedisJSONReactiveCommands<String, String> commandsReactiveJson;
    private final RedisJSONAsyncCommands<String, String> commandsAsyncJson;
    private static final String KEY_PREFIX = "product:";

    public RedisDataService() {
        this.client = RedisModulesClient.create(
            ConfigProvider.getConfig().getValue("redis.datasource.url", String.class)
        );
        this.connection = this.client.connect();
        this.commands = this.connection.reactive();
        this.commandsReactiveJson = this.connection.reactive();
        this.commandsAsyncJson = this.connection.async();
    }
    
    public Multi<String> getKeys() {
        return Multi.createFrom().publisher(
            commands.keys("*")
        );
    }

    public Multi<String> getAll() {
        Multi<String> keys = this.getKeys();
        
        Multi<String> products = keys
                .onItem().transformToMultiAndMerge(
                    key -> commandsReactiveJson.jsonGet(key, ".")
                );

        Multi<Tuple2<String, String>> tuple = Multi
                .createBy().combining()
                .streams(keys, products)
                .asTuple();

        Multi<String> catalog = tuple.onItem().transform(t -> 
            MessageFormat.format("\"{0}\": {1}", t.getItem1(), t.getItem2())
        );
        // .onItem().invoke(i -> System.out.println(i));

        return catalog;
    }
    
    public Uni<String> getJson(String key, String path) {
        return Uni.createFrom().publisher(
            commandsReactiveJson.jsonGet(KEY_PREFIX + key, path)
        )
        .onFailure().recoverWithNull();
    }
    
    public Uni<String> getKey(String key) {
        return Uni.createFrom().publisher(
            commands.get(KEY_PREFIX + key)
        );
    }

    public Uni<Long> setHash(String key, Map<String, String> map) {
        return Uni.createFrom().publisher(
            commands.hset(KEY_PREFIX + key, map)
        );
    }

    public Uni<String> setJson(Integer key, String path, String json) {
        return Uni.createFrom().publisher(
            commandsReactiveJson.jsonSet(KEY_PREFIX + key, path, json)
        );
    }

    public Uni<Long> delKey(String key) {
        return Uni.createFrom().publisher(
            commands.del(KEY_PREFIX + key)
        );
    }

    public Uni<Boolean> batchSet(List<CatalogDto> catalog) {
        // Disable auto-flushing
        commands.setAutoFlushCommands(false);

        // Perform a series of independent calls
        List<RedisFuture<?>> futures = Lists.newArrayList();
        catalog.stream().forEach(product -> {
            futures.add(commandsAsyncJson.jsonSet(
                KEY_PREFIX + product.getKey(), ".", product.getFields()
            ));
        });

        // Write all commands to the transport layer
        commands.flushCommands();

        // Wait until all futures complete
        var result = LettuceFutures.awaitAll(
            5, TimeUnit.SECONDS,
            futures.toArray(new RedisFuture[futures.size()])
        );

        // Re-enable auto-flushing
        commands.setAutoFlushCommands(true);

        return Uni.createFrom().item(result);
    }

    public void closeConnection(@Observes ShutdownEvent event) {
        connection.close();
        client.shutdownAsync();
    }
}
