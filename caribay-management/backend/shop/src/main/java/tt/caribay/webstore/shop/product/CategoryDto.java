package tt.caribay.webstore.shop.product;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class CategoryDto {
    
    private Integer categoryId;

    @NotBlank
    private String categoryName;

    @NotBlank
    private String categoryDescription;
}
