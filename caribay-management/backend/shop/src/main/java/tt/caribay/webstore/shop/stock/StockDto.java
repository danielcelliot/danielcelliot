package tt.caribay.webstore.shop.stock;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class StockDto {
    
    // @NotNull
    private Integer stockId;

    @NotBlank
    private String sku;

    @NotNull
    private Integer modelId;
}
