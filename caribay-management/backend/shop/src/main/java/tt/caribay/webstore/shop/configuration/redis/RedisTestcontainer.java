package tt.caribay.webstore.shop.configuration.redis;

import java.text.MessageFormat;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.event.Observes;
import javax.inject.Inject;

import org.eclipse.microprofile.config.ConfigProvider;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.utility.DockerImageName;

import io.quarkus.runtime.ShutdownEvent;
import io.quarkus.runtime.StartupEvent;
import tt.caribay.webstore.shop.catalog.CatalogService;

@ApplicationScoped
public class RedisTestcontainer {

    private final GenericContainer<?> container;
    private final DockerImageName REDIS_IMAGE = DockerImageName
            .parse("redislabs/redismod:latest");
    private final String REDIS_PORT = ConfigProvider.getConfig()
            .getValue("testcontainers.redis.port", String.class);

    @Inject CatalogService catalogService;

    @ConfigProperty(name = "caribay.webstore.shop.redis.testcontainer")
    boolean startContainer;

    public RedisTestcontainer() {
        this.container = new GenericContainer<>(REDIS_IMAGE);
        this.container.getPortBindings().add(
            MessageFormat.format("{0}:{0}", REDIS_PORT)
        );
    }

    public void onStart(@Observes StartupEvent event) {
        if (startContainer) {
            this.container.start();
        }
        // Populate Redis database
        catalogService.createCatalog().await().indefinitely();
    }

    public void onStop(@Observes ShutdownEvent event) {
        if (startContainer) {
            this.container.stop();
        }
    }
}
