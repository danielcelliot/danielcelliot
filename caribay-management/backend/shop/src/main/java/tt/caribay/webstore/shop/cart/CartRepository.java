package tt.caribay.webstore.shop.cart;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class CartRepository {
    
    private final PgPool pgClient;

    public Uni<Object> findAll() {
        var sql = """
            SELECT json_agg(i)
            FROM (
                SELECT c.cart_id, json_agg(e) AS products
                FROM cart c,
                    LATERAL (
                        SELECT p.product_id, p.product_name, cp.quantity, pp.price, m.merchant_id, m.merchant_name
                        FROM product p JOIN cart_products cp using (product_id)
                            JOIN product_prices pp using (product_id, merchant_id)
                            JOIN merchant m ON m.merchant_id = pp.merchant_id
                        WHERE cp.cart_id = c.cart_id
                    ) AS e
                GROUP BY c.cart_id
            ) AS i
            """;
        
        return pgClient.query(sql).execute()
            .onItem().transform(RowSet::iterator)
            .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findById(Integer id) {
        var sql = """
            SELECT json_agg(e)
            FROM (
                SELECT p.product_id, p.product_name, cp.quantity, pp.price, m.merchant_id, m.merchant_name
                FROM product p JOIN cart_products cp using (product_id)
                    JOIN product_prices pp using (product_id, merchant_id)
                    JOIN merchant m ON m.merchant_id = pp.merchant_id
                WHERE cp.cart_id = $1
            ) AS e
            """;

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
            .onItem().transform(RowSet::iterator)
            .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Boolean> doesCartExist(Integer id) {
        var sql = "SELECT EXISTS (SELECT cart_id FROM cart WHERE cart_id = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<Boolean> isItemInCart(Integer cid, Integer pid, Integer mid) {
        var sql = "SELECT EXISTS (SELECT product_id, cart_id FROM cart_products WHERE product_id = $1 AND cart_id = $2 AND merchant_id = $3)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(pid, cid, mid))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<Integer> createCart(Integer id) {
        var sql = "INSERT INTO cart (cart_id) VALUES ($1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> addItemToCart(Integer cid, Integer pid, Integer mid, Integer qty) {
        var sql = "INSERT INTO cart_products (cart_id, product_id, merchant_id, quantity) VALUES ($1, $2, $3, $4)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(cid, pid, mid, qty))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> updateItemInCart(Integer cid, Integer pid, Integer mid, Integer qty, Boolean override) {
        var sql = "UPDATE cart_products SET quantity = quantity + $1 WHERE cart_id = $2 AND product_id = $3 AND merchant_id = $4";
        var sql2 = "UPDATE cart_products SET quantity = $1 WHERE cart_id = $2 AND product_id = $3 AND merchant_id = $4";

        if (override) {
            return pgClient.preparedQuery(sql2).execute(Tuple.of(qty, cid, pid, mid))
                    .onItem().transform(RowSet::rowCount);
        }

        return pgClient.preparedQuery(sql).execute(Tuple.of(qty, cid, pid, mid))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteItemFromCart(Integer cid, Integer pid) {
        var sql = "DELETE FROM cart_products WHERE cart_id = $1 AND product_id = $2";

        return pgClient.preparedQuery(sql).execute(Tuple.of(cid, pid))
                .onItem().transform(RowSet::rowCount);
    }
}
