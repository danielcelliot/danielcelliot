package tt.caribay.webstore.shop.order;

import java.util.List;

import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class OrderDto {
    
    private Integer orderId;

    private Integer customerId;

    @NotNull
    private Integer shippingAddressId;

    @NotNull
    private Integer billingAddressId;

    @NotNull
    private Integer shipmentProviderOptionsId;

    @NotNull
    private Integer paymentProviderOptionsId;

    @NotNull
    private List<Product> products;
}
