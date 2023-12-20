package tt.caribay.webstore.shop.product;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class SubcategoryDto {
    
    private Integer subcategoryId;

    @NotBlank
    private String subcategoryName;

    @NotBlank
    private String subcategoryDescription;

    @NotNull
    private Integer categoryId;
}
