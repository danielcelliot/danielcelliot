package tt.caribay.webstore.shop.shipment;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class ShipmentRepository {
    
    private final PgPool client;

    public Uni<Object> findAllShipmentOptions() {
        var sql = """
            WITH shipment_methods AS (
                SELECT
                    sm.shipment_method_id, sm.shipment_method_name,
                    spo.shipment_provider_options_id, spo.shipment_provider_id
                FROM
                    shipment_provider_options spo
                    inner join shipment_method sm using (shipment_method_id)
            )
            SELECT json_agg(e) FROM
            (
                SELECT
                    sp.shipment_provider_id, sp.shipment_provider_name,
                    json_agg(json_build_object(
                        'shipment_method_id', sm.shipment_method_id,
                        'shipment_method_name', sm.shipment_method_name,
                        'shipment_provider_options_id', sm.shipment_provider_options_id
                    )) AS shipment_methods
            FROM
                shipment_provider sp
                inner join shipment_methods sm using (shipment_provider_id)
            GROUP BY
                sp.shipment_provider_id, sp.shipment_provider_name
            ) e
        """;

        return client.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
}
