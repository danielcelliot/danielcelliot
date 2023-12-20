package tt.caribay.webstore.shop.catalog;

import javax.enterprise.context.ApplicationScoped;

import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;

@ApplicationScoped
@RequiredArgsConstructor
public class CatalogService {
    
    private final CatalogRepository repository;
    private final RedisDataService redis;

    public Uni<Boolean> createCatalog() {

        Multi<CatalogDto> productData = repository.getProductData();

        return productData
                .collect().asList()
                .onItem().transformToUni(redis::batchSet);
    }
}
