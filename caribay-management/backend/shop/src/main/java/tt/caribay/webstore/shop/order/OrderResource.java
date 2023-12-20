package tt.caribay.webstore.shop.order;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.ws.rs.BadRequestException;
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
import tt.caribay.webstore.common.exception.ErrorResponse;
import tt.caribay.webstore.common.exception.ErrorResponse.ErrorMessage;

@Path("/orders")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class OrderResource {

    private final OrderService service;
    private final OrderRepository repository;

    @GET
    public Uni<String> get() {
        return repository.findAllOrders()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/{orderId}")
    public Uni<String> getById(@NotNull Integer orderId) {
        return repository.findOrderById(orderId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    public Uni<Response> post(@Valid OrderDto dto) {
        var result = repository
                .saveOrder(dto)
                .onItem().ifNull().failWith(new BadRequestException(
                    Response.status(Response.Status.BAD_REQUEST)
                            .entity(
                                new ErrorResponse(
                                    new ErrorMessage(
                                        "Error occurred: Bad Request"
                                    )
                                )
                            )
                            .build()
                ));

        return result
                .onItem().ifNotNull().transform(id -> Response
                    // .created(URI.create("/orders/" + id))
                    .ok()
                    .build()
                );
    }

    @PUT
    @Path("/{orderId}")
    public Uni<Response> put(@NotNull Integer orderId, @Valid OrderDto dto) {
        Integer[] orderIds = {orderId, dto.getOrderId()};
        service.checkIfIdsMatch(orderIds);

        return repository
                .updateOrder(dto)
                .onItem().transform(v -> Response.status(Response.Status.NO_CONTENT).build());
    }

    @PUT
    @Path("/cancel/{orderId}")
    public Uni<Response> cancel(@NotNull Integer orderId) {
        return repository.cancelOrder(orderId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{orderId}")
    public Uni<Response> delete(@NotNull Integer orderId) {
        return repository.deleteOrder(orderId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
}
