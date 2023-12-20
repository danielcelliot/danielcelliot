package tt.caribay.webstore.shop.product;

import javax.enterprise.context.ApplicationScoped;

import tt.caribay.webstore.common.validation.MatchIds;

@ApplicationScoped
public class ProductService {
    
    public void checkIfIdsMatch(@MatchIds Integer[] productId) {}
}
