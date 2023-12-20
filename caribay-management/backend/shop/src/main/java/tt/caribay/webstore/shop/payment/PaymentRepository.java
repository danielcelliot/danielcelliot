package tt.caribay.webstore.shop.payment;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class PaymentRepository {
    
    private final PgPool pgClient;

    public Uni<Object> findAllPaymentOptions()  {
        var sql = """
            WITH payment_methods AS (
                SELECT
                    ppo.payment_provider_id,
                    pm.payment_method_id, pm.payment_method_name,
                    json_agg(json_build_object(
                        'currency_id', c.currency_id,
                        'denomination', c.denomination,
                        'payment_provider_options_id', ppo.payment_provider_options_id
                    )) AS options
                FROM
                    payment_provider_options ppo
                    inner join payment_method pm using (payment_method_id)
                    inner join payment_provider pp using (payment_provider_id)
                    inner join (
                        SELECT currency_id, denomination
                        FROM currency
                    ) c using (currency_id)
                GROUP BY ppo.payment_provider_id,
                    pm.payment_method_id, pm.payment_method_name
            )
            SELECT json_agg(e) FROM
            (
                SELECT
                    pm.payment_provider_id,
                    pp.payment_provider_name,
                    json_agg(json_build_object(
                            'payment_method_id', pm.payment_method_id,
                            'payment_method_name', pm.payment_method_name,
                            'options', pm.options
                    )) AS payment_methods
                FROM
                    payment_provider pp
                    inner join payment_methods pm using (payment_provider_id)
                GROUP BY
                    pm.payment_provider_id,	pp.payment_provider_name
            ) e
        """;

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
}
