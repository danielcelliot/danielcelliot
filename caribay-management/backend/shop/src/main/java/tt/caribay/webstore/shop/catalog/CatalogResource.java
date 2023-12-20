package tt.caribay.webstore.shop.catalog;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;

@Path("/catalog")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class CatalogResource {
    
    private final RedisDataService redisService;

    @GET
    public Multi<String> get() {
        // TODO: Fix JSON formatting: Remove escape quote characters (28/09/2022)
        return redisService.getAll();
    }

    @GET
    @Path("{key}")
    public Uni<String> getByKey(String key) {
        return redisService.getJson(key, ".")
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @GET
    @Path("{key}/{path}")
    public Uni<String> getByKey(String key, String path) {
        return redisService.getJson(key, ".." + path)
                .onItem().ifNull().failWith(NotFoundException::new);
    }
    
    @POST
    public Uni<String> post(CatalogDto dto) {
        return redisService.setJson(dto.getKey(), dto.getPath(), dto.getFields());
    }
    
    @DELETE
    @Path("/{key}")
    public Uni<Long> delete(String key) {
        return redisService.delKey(key);
    }

    // @GET
    // @Blocking
    // @Path("/create")
    // public Uni<Boolean> create() {
    //     return catalogService.CreateCatalog();
    // }
}
