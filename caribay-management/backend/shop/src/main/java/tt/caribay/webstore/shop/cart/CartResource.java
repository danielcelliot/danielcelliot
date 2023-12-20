package tt.caribay.webstore.shop.cart;

import javax.validation.constraints.NotNull;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;

@Path("/cart")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class CartResource {
    
    private final CartRepository repo;
    private final CartService service;

    @GET
    public Uni<String> get() {
        return repo
                .findAll()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(String::new);
    }

    @GET
    @Path("/{cartId}")
    public Uni<String> getById(@NotNull Integer cartId) {
        return repo
                .findById(cartId)
                .onItem().ifNotNull().transform(r -> r.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    @Path("/{cartId}")
    public Uni<Integer> post(@NotNull Integer cartId, CartDto dto) {
        return service.addItemToCart(cartId, dto);
    }

    @PUT
    @Path("/{cartId}")
    public Uni<Response> put(@NotNull Integer cartId, CartDto dto) {
        return repo
                .updateItemInCart(
                    cartId, dto.getProductId(), dto.getMerchantId(), dto.getQuantity(), true
                )
                .onItem().transform(i -> i > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{cartId}/{productId}")
    public Uni<Response> delete(@NotNull Integer cartId, @NotNull Integer productId) {
        return repo
                .deleteItemFromCart(cartId, productId)
                .onItem().transform(i -> i > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
}
