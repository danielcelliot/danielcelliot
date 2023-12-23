package tt.caribay.webstore.shop.catalog;

import java.util.HashMap;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.Row;
import io.vertx.mutiny.sqlclient.RowSet;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class CatalogRepository {
    
    private final PgPool pgClient;

    public Multi<CatalogDto> getProductData() {
        var sql = """
            WITH model_info AS (
                SELECT
                    m.model_id, m.brand_name, m.model_name, m.category_name, m.subcategory_name,
                    json_agg(jsonb_build_object(js.key, js.values)) AS options
                FROM
                    (
                        SELECT
                            m.model_id, b.brand_name, m.model_name,
                            c.category_name, s.subcategory_name
                        FROM
                            brand b JOIN model m using (brand_id)
                            JOIN stock st using (model_id)
                            JOIN product p ON p.product_id = st.stock_id
                            JOIN subcategory s using (subcategory_id)
                            JOIN category c using (category_id)
                        GROUP BY
                            m.model_id, b.brand_name,
                            c.category_name, s.subcategory_name
                    ) AS m
                    JOIN (
                        SELECT
                            s.model_id, j.key AS key,
                            ARRAY_AGG(DISTINCT(j.value)) AS values
                        FROM
                            product p JOIN stock s ON s.stock_id = p.product_id,
                            jsonb_array_elements(p.options) AS e,
                            jsonb_each(e) AS j
                        GROUP BY
                            s.model_id, j.key
                    ) AS js using (model_id)
                GROUP BY
                    m.model_id, m.brand_name, m.model_name,
                    m.category_name, m.subcategory_name
            ),
            product_info AS (
                SELECT
                    s.model_id, s.product_name, s.attributes,
                    s.options, s.product_id,
                    json_agg(m) AS stock
                FROM
                    stock st JOIN product p ON st.stock_id = p.product_id
                    JOIN
                    (
                        SELECT
                            s.model_id, p.product_id, s.sku, p.product_name,
                            p.attributes, p.options
                        FROM
                            stock s JOIN product p ON p.product_id = s.stock_id
                    ) AS s
                    using (product_id)
                    JOIN (
                        SELECT
                            pp.product_id, m.merchant_id, m.merchant_name,
                            pp.price, pq.quantity, pq.order_limit
                        FROM
                            product_prices pp
                            JOIN product_quantities pq using (product_id, merchant_id)
                            JOIN merchant m using (merchant_id)
                    ) m using (product_id)
                GROUP BY
                    s.model_id, s.product_id, s.product_name,
                    s.attributes, s.options
            ),
            stock_sku AS (
                SELECT
                    st.sku, p.product_id
                FROM
                    stock st JOIN product p ON st.stock_id = p.product_id
            )
            SELECT
                pi.model_id,
                mi.brand_name, mi.model_name, mi.category_name, mi.subcategory_name,
                mi.options::JSONB,
                json_agg(jsonb_build_object(sk.sku, pi)) AS skus
            FROM
                stock_sku sk JOIN product_info pi using (product_id)
                JOIN model_info mi using (model_id)
            GROUP BY
                pi.model_id,
                mi.brand_name, mi.model_name, mi.category_name, mi.subcategory_name,
                mi.options::JSONB
            """;

        Uni<RowSet<Row>> rowSet = pgClient.query(sql).execute();
        Multi<CatalogDto> productData = rowSet
                .onItem().transformToMulti(Multi.createFrom()::iterable)
                .onItem().transform(this::rowToProduct);
        
        return productData;
    }
    
    private CatalogDto rowToProduct(Row row) {
        var product = CatalogDto.builder()
                .key(row.getInteger("model_id"))
                .path(".")
                .fields(new HashMap<String, Object>() {{
                    put("brand_name", row.getString("brand_name"));
                    put("model_name", row.getString("model_name"));
                    put("category_name", row.getString("category_name"));
                    put("subcategory_name", row.getString("subcategory_name"));
                    put("options", row.getJson("options"));
                    put("skus", row.getJson("skus"));
                }})
                .build();

        return product;
    }
}
