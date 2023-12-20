package tt.caribay.webstore.shop.user;

import java.nio.charset.StandardCharsets;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class UserRepository {

    private final PgPool pgClient;

    public Uni<Object> findAll() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM users) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM users WHERE user_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
    
    public Uni<Integer> save(UserDto.Create dto) {
        var sql = 
            "INSERT INTO users (first_name, last_name, email_address, password) VALUES ($1, $2, $3, $4) RETURNING user_id";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getFirstName(),
                        dto.getLastName(),
                        dto.getEmailAddress(),
                        dto.getPassword().getBytes(StandardCharsets.UTF_8)
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("user_id")
                    : null
                );
    }

    public Uni<Integer> update(UserDto.Update dto) {
        var sql =
            "UPDATE users SET first_name=$1, last_name=$2, email_address=$3, last_updated_on=current_timestamp WHERE user_id=$4";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getFirstName(),
                        dto.getLastName(),
                        dto.getEmailAddress(),
                        dto.getUserId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> delete(Integer id) {
        var sql = "DELETE FROM users WHERE user_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deactivate(Integer id) {
        var sql = "UPDATE users SET is_active=false, last_updated_on=current_timestamp WHERE user_id=$1";

        return pgClient
                .preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Boolean> doesEmailExist(String email) {
        var sql = "SELECT EXISTS (SELECT email_address FROM users WHERE email_address = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(email))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<Boolean> doesUserExist(Integer id) {
        var sql = "SELECT EXISTS (SELECT user_id FROM users WHERE user_id = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<byte[]> getHash(String email) {
        var sql = "SELECT password FROM users WHERE email_address = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(email))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getBuffer("password").getBytes()
                    : null
                );
    }
}
