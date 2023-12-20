package tt.caribay.webstore.shop.supplier;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class SupplierDto {
    
    private Integer supplierId;

    @NotBlank
    private String supplierName;
}
