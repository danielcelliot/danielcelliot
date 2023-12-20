package tt.caribay.webstore.shop.catalog;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;

import io.smallrye.common.constraint.NotNull;
import io.vertx.core.json.JsonObject;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CatalogDto {

    @JsonProperty("id")
    @NotNull
    private Integer key;

    @JsonProperty("path")
    private String path;

    @JsonProperty("fields")
    @NotNull
    private Map<String, Object> fields;

    public String getFields() {
        return new JsonObject(fields).toString();
    }

    public Map<String, Object> getMap() {
        return fields;
    }

    public void addField(String key, Object value) {
        fields.put(key, value);
    }
}
