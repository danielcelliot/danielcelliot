package tt.caribay.webstore.shop.stock;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class ModelDto {
    
    private Integer modelId;

    @NotBlank
    private String modelName;

    @NotNull
    private Integer brandId;
}
