package tt.caribay.webstore.shop.order;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class Product {
    
    @NotNull
    private Integer productId;
    
    @NotNull
    private Integer merchantId;
    
    @NotNull
    private Integer quantity;
}
