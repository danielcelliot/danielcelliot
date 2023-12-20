package tt.caribay.webstore.shop.stock;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.Tuple;
import io.vertx.mutiny.sqlclient.RowSet;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class StockRepository {
    
    private final PgPool pgClient;

    // TODO: Improve Database error checking

    
    public Uni<Object> findAllStock() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM stock) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    
    public Uni<Object> findAllBrands() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM brand) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
    
    public Uni<Object> findAllModels() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM model) e";

        return pgClient.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findStockById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM stock WHERE stock_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findBrandById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM brand WHERE brand_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Object> findModelById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM model WHERE model_id = $1) e";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }

    public Uni<Integer> saveStock(StockDto dto) {
        var sql =
            "INSERT INTO stock (sku, model_id) VALUES ($1, $2) RETURNING stock_id";
        
        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSku(),
                        dto.getModelId()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("stock_id")
                    : null
                );
    }

    public Uni<Integer> saveBrand(BrandDto dto) {
        var sql =
            "INSERT INTO brand (brand_name) VALUES ($1) RETURNING brand_id";
        
        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getBrandName()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("brand_id")
                    : null
                );
    }

    public Uni<Integer> saveModel(ModelDto dto) {
        var sql =
            "INSERT INTO model (model_name, brand_id) VALUES ($1, $2) RETURNING model_id";
        
        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getModelName(),
                        dto.getBrandId()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("model_id")
                    : null
                );
    }
    
    public Uni<Integer> updateStock(StockDto dto) {
        var sql =
            "UPDATE stock SET sku=$1, model_id=$2, last_updated_on=current_timestamp WHERE stock_id=$3";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSku(),
                        dto.getModelId(),
                        dto.getStockId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }
    
    public Uni<Integer> updateBrand(BrandDto dto) {
        var sql =
            "UPDATE brand SET brand_name=$1, last_updated_on=current_timestamp WHERE brand_id=$2";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getBrandName(),
                        dto.getBrandId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }
    
    public Uni<Integer> updateModel(ModelDto dto) {
        var sql =
            "UPDATE model SET model_name=$1, brand_id=$2, last_updated_on=current_timestamp WHERE model_id=$3";

        return pgClient
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getModelName(),
                        dto.getBrandId(),
                        dto.getModelId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteStock(Integer id) {
        var sql = "DELETE FROM stock WHERE stock_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteBrand(Integer id) {
        var sql = "DELETE FROM brand WHERE brand_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }
    
    public Uni<Integer> deleteModel(Integer id) {
        var sql = "DELETE FROM model WHERE model_id = $1";

        return pgClient.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }
}
