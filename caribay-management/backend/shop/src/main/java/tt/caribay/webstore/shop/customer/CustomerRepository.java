package tt.caribay.webstore.shop.customer;

import java.nio.charset.StandardCharsets;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class CustomerRepository {

    private final PgPool pgClient;

    public Uni<Object> findAll() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM customer) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM customer WHERE customer_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
    
    public Uni<Integer> save(CustomerDto.Create dto) {
        var sql = 
            "INSERT INTO customer (first_name, last_name, email_address, password) VALUES ($1, $2, $3, $4) RETURNING customer_id";

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
                    ? i.next().getInteger("customer_id")
                    : null
                );
    }

    public Uni<Integer> update(CustomerDto.Update dto) {
        var sql =
            "UPDATE customer SET first_name=$1, last_name=$2, email_address=$3, last_updated_on=current_timestamp WHERE customer_id=$4";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getFirstName(),
                        dto.getLastName(),
                        dto.getEmailAddress(),
                        dto.getCustomerId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> delete(Integer id) {
        var sql = "DELETE FROM customer WHERE customer_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deactivate(Integer id) {
        var sql = "UPDATE customer SET is_active=false, last_updated_on=current_timestamp WHERE customer_id=$1";

        return pgClient
                .preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Boolean> doesEmailExist(String email) {
        var sql = "SELECT EXISTS (SELECT email_address FROM customer WHERE email_address = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(email))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<Boolean> doesCustomerExist(Integer id) {
        var sql = "SELECT EXISTS (SELECT customer_id FROM customer WHERE customer_id = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<byte[]> getHash(String email) {
        var sql = "SELECT password FROM customer WHERE email_address = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(email))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getBuffer("password").getBytes()
                    : null
                );
    }
}
