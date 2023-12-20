package tt.caribay.webstore.shop.cart;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class CartDto {
    
    @NotNull private Integer productId;
    @NotNull private Integer merchantId;
    @NotNull private Integer quantity;
}
