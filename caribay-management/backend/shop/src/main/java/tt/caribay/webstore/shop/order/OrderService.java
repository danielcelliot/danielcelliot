package tt.caribay.webstore.shop.order;

import javax.enterprise.context.ApplicationScoped;

import tt.caribay.webstore.common.validation.MatchIds;

@ApplicationScoped
public class OrderService {
    
    public void checkIfIdsMatch(@MatchIds Integer[] orderId) {}
}
