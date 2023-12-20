package tt.caribay.webstore.shop.product;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.core.json.JsonArray;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class ProductRepository {

    private final PgPool pgClient;

    public Uni<Object> findAllProducts() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM product) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findAllCategories() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM category) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findAllSubcategories() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM subcategory) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findProductById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM product WHERE product_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Number> findProductPricing(Integer productId, Integer merchantId) {
        var sql = "select price from product_prices where product_id = $1 and merchant_id = $2";

        return pgClient.preparedQuery(sql).execute(Tuple.of(productId, merchantId))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getNumeric("price"));
    }

    public Uni<Object> findCategoryById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM category WHERE category_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findSubcategoryById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM subcategory WHERE subcategory_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Integer> saveProduct(ProductDto.Create dto) {
        var sql =
            "INSERT INTO product (product_id, product_name, attributes, options, subcategory_id) VALUES ($1, $2, $3::JSONB, $4::JSONB, $5) RETURNING product_id";
        
        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getStockId(),
                        dto.getProductName(),
                        new JsonArray(dto.getAttributes()),
                        new JsonArray(dto.getOptions()),
                        dto.getSubcategoryId()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("product_id")
                    : null
                );
    }

    public Uni<Integer> saveCategory(CategoryDto dto) {
        var sql =
            "INSERT INTO category (category_name, category_description) VALUES ($1, $2) RETURNING category_id";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getCategoryName(),
                        dto.getCategoryDescription()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("category_id")
                    : null
                );
    }

    public Uni<Integer> saveSubcategory(SubcategoryDto dto) {
        var sql =
            "INSERT INTO subcategory (subcategory_name, subcategory_description, category_id) VALUES ($1, $2, $3) RETURNING subcategory_id";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSubcategoryName(),
                        dto.getSubcategoryDescription(),
                        dto.getCategoryId()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("subcategory_id")
                    : null
                );
    }

    public Uni<Integer> updateProduct(ProductDto.Update dto) {
        var sql =
            "UPDATE product SET product_name=$1, attributes=$2::JSONB, options=$3::JSONB, subcategory_id=$4, last_updated_on=current_timestamp WHERE product_id=$5";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getProductName(),
                        new JsonArray(dto.getAttributes()),
                        new JsonArray(dto.getOptions()),
                        dto.getSubcategoryId(),
                        dto.getProductId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> updateCategory(CategoryDto dto) {
        var sql =
            "UPDATE category SET category_name=$1, category_description=$2, last_updated_on=current_timestamp WHERE category_id=$3";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getCategoryName(),
                        dto.getCategoryDescription(),
                        dto.getCategoryId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> updateSubcategory(SubcategoryDto dto) {
        var sql =
            "UPDATE subcategory SET subcategory_name=$1, subcategory_description=$2, category_id=$3, last_updated_on=current_timestamp WHERE subcategory_id=$4";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSubcategoryName(),
                        dto.getSubcategoryDescription(),
                        dto.getCategoryId(),
                        dto.getSubcategoryId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteProduct(Integer id) {
        var sql = "DELETE FROM product WHERE product_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteCategory(Integer id) {
        var sql = "DELETE FROM category WHERE category_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }
    
    public Uni<Integer> deleteSubcategory(Integer id) {
        var sql = "DELETE FROM subcategory WHERE subcategory_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deactivateProduct(Integer id) {
        var sql = "UPDATE product SET is_active=false, last_updated_on=current_timestamp WHERE product_id=$1";

        return pgClient
                .preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }
    
    public Uni<Boolean> doesProductExist(String name) {
        var sql = "SELECT EXISTS (SELECT product_name FROM product WHERE product_name = $1)";

        return pgClient.preparedQuery(sql).execute(Tuple.of(name))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }

    public Uni<Boolean> doesMerchantHaveStock(Integer pid, Integer mid) {
        var sql = """
            SELECT EXISTS
            (
                SELECT product_id, merchant_id
                FROM product_quantities
                WHERE product_id = $1
                    AND merchant_id = $2
                    AND quantity > 0
            )
        """;

        return pgClient.preparedQuery(sql).execute(Tuple.of(pid, mid))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getBoolean("exists"));
    }
}
