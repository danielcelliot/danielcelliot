package tt.caribay.webstore.shop.supplier;

import java.net.URI;

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

@Path("/suppliers")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class SupplierResource {
    
    private final SupplierRepository repository;
    private final SupplierService service;

    @GET
    public Uni<String> getSuppliers() {
        return repository
                .findAllSuppliers()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }
    
    @GET
    @Path("/{supplierId}")
    public Uni<String> getSupplierById(@NotNull Integer supplierId) {
        return repository
                .findSupplierById(supplierId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }
    
    @POST
    public Uni<Response> postStock(@Valid SupplierDto dto) {
        var result = repository
                .saveSupplier(dto)
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
                    .created(URI.create("/supplier/" + id))
                    .build()
                );
    }

    @PUT
    @Path("/{supplierId}")
    public Uni<Response> putSupplier(@NotNull Integer supplierId, @Valid SupplierDto dto) {
        Integer[] stockIds = {supplierId, dto.getSupplierId()};
        service.checkIfIdsMatch(stockIds);

        return repository
                .updateSupplier(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{supplierId}")
    public Uni<Response> deleteSupplier(@NotNull Integer supplierId) {
        return repository
                .deleteSupplier(supplierId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
}
