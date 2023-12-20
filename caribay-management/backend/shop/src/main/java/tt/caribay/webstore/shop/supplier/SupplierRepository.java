package tt.caribay.webstore.shop.supplier;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Uni;
import io.vertx.mutiny.pgclient.PgPool;
import io.vertx.mutiny.sqlclient.RowSet;
import io.vertx.mutiny.sqlclient.Tuple;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class SupplierRepository {
    
    private final PgPool client;

    public Uni<Object> findAllSuppliers() {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM supplier) e";

        return client.query(sql).execute()
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
    
    public Uni<Object> findSupplierById(Integer id) {
        var sql = "SELECT json_agg(e) FROM (SELECT * FROM supplier WHERE supplier_id = $1) e";

        return client.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.next().getJson("json_agg"));
    }
    
    public Uni<Integer> saveSupplier(SupplierDto dto) {
        var sql =
            "INSERT INTO supplier (supplier_name) VALUES ($1) RETURNING supplier_id";
        
        return client
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSupplierName()
                    )
                )
                .onItem().transform(RowSet::iterator)
                .onItem().transform(i -> i.hasNext()
                    ? i.next().getInteger("supplier_id")
                    : null
                );
    }

    public Uni<Integer> updateSupplier(SupplierDto dto) {
        var sql =
            "UPDATE supplier SET supplier_name=$1, last_updated_on=current_timestamp WHERE supplier_id=$2";

        return client
                .preparedQuery(sql).execute(
                    Tuple.of(
                        dto.getSupplierName(),
                        dto.getSupplierId()
                    )
                )
                .onItem().transform(RowSet::rowCount);
    }

    public Uni<Integer> deleteSupplier(Integer id) {
        var sql = "DELETE FROM supplier WHERE supplier_id = $1";

        return client.preparedQuery(sql).execute(Tuple.of(id))
                .onItem().transform(RowSet::rowCount);
    }
}