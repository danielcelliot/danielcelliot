package tt.caribay.webstore.shop.address;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class AddressRepository {

    private final PgPool pgClient;
    
    public Uni<Object> findAddressesById(Integer id) {
        var sql = """
            SELECT json_agg(e) FROM
            (
                SELECT
                    a.address_id,
                    concat(a.address_line_primary, ' ', a.address_line_optional, ', ', a.city) as address_full
                FROM customer_addresses ca
	                INNER JOIN customer c using (customer_id)
	                INNER JOIN address a using (address_id)
                WHERE ca.customer_id = $1
            ) e
        """;

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
}
