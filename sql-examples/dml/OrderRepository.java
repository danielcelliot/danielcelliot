package tt.caribay.webstore.shop.order;

import java.util.ArrayList;
import java.util.List;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.Row;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class OrderRepository {

    private final PgPool pgClient;

    public Uni<Object> findAllOrders() {
        var sql = """
            WITH order_products AS (
                SELECT
                    cop.customer_order_id, cop.product_id,
                    p.product_name, cop.quantity
                FROM customer_order_products cop
                    INNER JOIN product p USING (product_id)
            )
            SELECT json_agg(e) FROM
            (
                SELECT
                    co.customer_order_id AS "orderId",
                    c.customer_id AS "customerId", concat(c.first_name, ' ', c.last_name) AS "customerName",
                    jsonb_build_object
                    (
                        'shippingAddressId', sa.address_id,
                        'shippingAddressFull', concat(sa.address_line_primary, ' ', sa.address_line_optional, ' ', sa.city),
                        'billingAddressId', ba.address_id,
                        'billingAddressFull', concat(ba.address_line_primary, ' ', ba.address_line_optional, ' ', ba.city),
                        'shippingProviderId', sp.shipment_provider_id,
                        'shippingProviderName', sp.shipment_provider_name,
                        'shippingMethodId', sm.shipment_method_id,
                        'shippingMethodName', sm.shipment_method_name,
                        'shippingProviderOptionsId', co.shipment_provider_options_id
                    ) AS "shippingInfo",
                    jsonb_build_object
                    (
                        'paymentProviderId', pp.payment_provider_id,
                        'paymentProviderName', pp.payment_provider_name,
                        'paymentMethodId', pm.payment_method_id,
                        'paymentMethodName', pm.payment_method_name,
                        'paymentProviderOptionsId', co.payment_provider_options_id
                    ) AS "paymentInfo",
                    jsonb_agg
                    (
                        jsonb_build_object
                        (
                            'productId', op.product_id,
                            'productName', op.product_name,
                            'quantity', op.quantity
                        )
                    ) AS "products",
                    sc.status_code_name AS "statusCodeName",
                    co.created_on AS "created",
                    co.last_updated_on AS "lastModified"
                FROM customer_order co
                    INNER JOIN customer c USING (customer_id)
                    INNER JOIN address sa ON sa.address_id = co.shipping_address_id
                    INNER JOIN address ba ON ba.address_id = co.billing_address_id
                    INNER JOIN shipment_provider_options spo USING (shipment_provider_options_id)
                    INNER JOIN shipment_provider sp USING (shipment_provider_id)
                    INNER JOIN shipment_method sm USING (shipment_method_id)
                    INNER JOIN payment_provider_options ppo USING (payment_provider_options_id)
                    INNER JOIN payment_provider pp USING (payment_provider_id)
                    INNER JOIN payment_method pm USING (payment_method_id)
                    INNER JOIN order_products op USING (customer_order_id)
                    INNER JOIN status_code sc USING (status_code_id)
                GROUP BY
                    "orderId", "customerId", "customerName", sa.address_id, ba.address_id,
                    sp.shipment_provider_id, sp.shipment_provider_name, sm.shipment_method_id, sm.shipment_method_name, co.shipment_provider_options_id,
                    pp.payment_provider_id, pp.payment_provider_name, pm.payment_method_id, pm.payment_method_name, co.payment_provider_options_id,
                    "statusCodeName"
            ) e
        """;

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findOrderById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM customer_order WHERE customer_order_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Void> saveOrder(OrderDto dto) {
        var sql1 = 
            "INSERT INTO customer_order (customer_id, shipping_address_id, billing_address_id, shipment_provider_options_id, payment_provider_options_id) VALUES ($1, $2, $3, $4, $5) RETURNING customer_order_id";

        var sql2 = 
            "INSERT INTO customer_order_products (customer_order_id, product_id, merchant_id, quantity) VALUES ($1, $2, $3, $4) RETURNING customer_order_products_id";

        return pgClient.withTransaction(conn -> conn
                .preparedQuery(sql1).execute(
                    Tuple.of(
                        dto.getCustomerId(),
                        dto.getShippingAddressId(),
                        dto.getBillingAddressId(),
                        dto.getShipmentProviderOptionsId(),
                        dto.getPaymentProviderOptionsId()
                    )
                )
                .onItem().transformToUni(id -> conn
                        .preparedQuery(sql2).executeBatch(
                            createBatchList(
                                id.iterator().next().getLong("customer_order_id"),
                                dto.getProducts()
                            )
                        )
                )
                // TODO: Fix return type (leads to incorrectly reporting 400 Bad request on success) (10/10/2022)
                .onItem().ignore().andContinueWithNull()
        );
    }

    public Uni<Void> updateOrder(OrderDto dto) {
        var sql1 =
            "UPDATE customer_order SET shipping_address_id=$1, billing_address_id=$2, shipment_provider_options_id=$3, payment_provider_options_id=$4, last_updated_on=current_timestamp WHERE customer_order_id=$5";
            
        var sql2 = 
            "UPDATE customer_order_products SET quantity=$1 WHERE customer_order_id=$2 AND product_id=$3 AND merchant_id=$4";

        return pgClient.withTransaction(conn -> {
            var batchUpdates = new ArrayList<Uni<RowSet<Row>>>();

            batchUpdates.add(conn.preparedQuery(sql1)
                    .execute(Tuple.of(
                        dto.getShippingAddressId(),
                        dto.getBillingAddressId(),
                        dto.getShipmentProviderOptionsId(),
                        dto.getPaymentProviderOptionsId(),
                        dto.getOrderId()
                    ))
            );
            dto.getProducts().forEach(product -> {
                batchUpdates.add(conn.preparedQuery(sql2)
                        .execute(Tuple.of(
                            product.getQuantity(),
                            dto.getOrderId(),
                            product.getProductId(),
                            product.getMerchantId()
                        ))
                );
            });

            // TODO: Find a way to return a value on success
            return Uni.combine().all().unis(batchUpdates).discardItems();
        });
    }

    public Uni<Integer> deleteOrder(Integer id) {
        var sql = "DELETE FROM customer_order WHERE customer_order_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> cancelOrder(Integer id) {
        var sql = "UPDATE customer_order SET status_code_id=102, last_updated_on=current_timestamp WHERE customer_order_id=$1";

        return pgClient
                .preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    private List<Tuple> createBatchList(Long orderId, List<Product> products) {
        var batchList = new ArrayList<Tuple>();

        for (int i = 0; i < products.size(); i++) {
            batchList.add(Tuple.of(
                orderId,
                products.get(i).getProductId(),
                products.get(i).getMerchantId(),
                products.get(i).getQuantity()
            ));
        }

        return batchList;
    }
}
