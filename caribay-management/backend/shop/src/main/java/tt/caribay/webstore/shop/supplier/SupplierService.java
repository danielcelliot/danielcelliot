package tt.caribay.webstore.shop.supplier;

import javax.enterprise.context.ApplicationScoped;

import tt.caribay.webstore.common.validation.MatchIds;

@ApplicationScoped
public class SupplierService {
    
    public void checkIfIdsMatch(@MatchIds Integer[] supplierId) {}    
}
