package tt.caribay.webstore.shop.stock;

import javax.enterprise.context.ApplicationScoped;

import tt.caribay.webstore.common.validation.MatchIds;

@ApplicationScoped
public class StockService {
    
    public void checkIfIdsMatch(@MatchIds Integer[] stockId) {}
}
