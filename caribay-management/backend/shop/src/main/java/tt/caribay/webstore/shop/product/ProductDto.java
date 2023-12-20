package tt.caribay.webstore.shop.product;

import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@JsonIgnoreProperties(ignoreUnknown = true)
public abstract class ProductDto {

    @Data
    public static class Create {

        @NotNull
        private Integer stockId;

        @NotBlank
        private String productName;

        @NotNull
        private List<Map<String, Object>> attributes;

        private List<Map<String, Object>> options;

        @NotNull
        private Integer subcategoryId;
    }

    @Data
    public static class Update {

        @NotNull
        private Integer productId;

        @NotBlank
        private String productName;

        @NotNull
        private List<Map<String, Object>> attributes;

        private List<Map<String, Object>> options;

        @NotNull
        private Integer subcategoryId;
    }
}
