package tt.caribay.webstore.shop.stock;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class BrandDto {
    
    private Integer brandId;

    @NotBlank
    private String brandName;
}
