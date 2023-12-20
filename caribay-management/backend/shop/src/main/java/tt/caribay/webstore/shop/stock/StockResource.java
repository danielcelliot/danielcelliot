package tt.caribay.webstore.shop.stock;

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

@Path("/stock")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class StockResource {

    private final StockRepository repository;
    private final StockService service;

    @GET
    public Uni<String> getStock() {
        return repository
                .findAllStock()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/brand")
    public Uni<String> getBrand() {
        return repository
                .findAllBrands()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/model")
    public Uni<String> getModel() {
        return repository
                .findAllModels()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/{stockId}")
    public Uni<String> getByStockId(@NotNull Integer stockId) {
        return repository
                .findStockById(stockId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @GET
    @Path("/brand/{brandId}")
    public Uni<String> getByBrandId(@NotNull Integer brandId) {
        return repository
                .findBrandById(brandId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @GET
    @Path("/model/{modelId}")
    public Uni<String> getByModelId(@NotNull Integer modelId) {
        return repository
                .findModelById(modelId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    public Uni<Response> postStock(@Valid StockDto dto) {
        var result = repository
                .saveStock(dto)
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
                    .created(URI.create("/stock/" + id))
                    .build()
                );
    }

    @POST
    @Path("/brand")
    public Uni<Response> postBrand(@Valid BrandDto dto) {
        var result = repository
                .saveBrand(dto)
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
                    .created(URI.create("/brand/" + id))
                    .build()
                );
    }

    @POST
    @Path("/model")
    public Uni<Response> postModel(@Valid ModelDto dto) {
        var result = repository
                .saveModel(dto)
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
                    .created(URI.create("/model/" + id))
                    .build()
                );
    }

    @PUT
    @Path("/{stockId}")
    public Uni<Response> putStock(@NotNull Integer stockId, @Valid StockDto dto) {
        Integer[] stockIds = {stockId, dto.getStockId()};
        service.checkIfIdsMatch(stockIds);

        return repository
                .updateStock(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/brand/{brandId}")
    public Uni<Response> putBrand(@NotNull Integer brandId, @Valid BrandDto dto) {
        Integer[] brandIds = {brandId, dto.getBrandId()};
        service.checkIfIdsMatch(brandIds);

        return repository
                .updateBrand(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/model/{modelId}")
    public Uni<Response> putModel(@NotNull Integer modelId, @Valid ModelDto dto) {
        Integer[] modelIds = {modelId, dto.getModelId()};
        service.checkIfIdsMatch(modelIds);

        return repository
                .updateModel(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
    
    @DELETE
    @Path("/{stockId}")
    public Uni<Response> deleteStock(@NotNull Integer stockId) {
        return repository
                .deleteStock(stockId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/brand/{brandId}")
    public Uni<Response> deleteBrand(@NotNull Integer brandId) {
        return repository
                .deleteBrand(brandId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/model/{modelId}")
    public Uni<Response> deleteModel(@NotNull Integer modelId) {
        return repository
                .deleteModel(modelId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
}
