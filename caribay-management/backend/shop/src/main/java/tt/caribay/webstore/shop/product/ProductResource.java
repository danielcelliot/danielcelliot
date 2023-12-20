package tt.caribay.webstore.shop.product;

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

@Path("/products")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class ProductResource {
    
    private final ProductService service;
    private final ProductRepository repository;
    
    @GET
    public Uni<String> getProducts() {
        return repository
                .findAllProducts()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/categories")
    public Uni<String> getCategories() {
        return repository
                .findAllCategories()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/subcategories")
    public Uni<String> getSubcategories() {
        return repository
                .findAllSubcategories()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/{productId}")
    public Uni<String> getProductById(@NotNull Integer productId) {
        return repository
                .findProductById(productId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }
    
    @GET
    @Path("/{productId}/merchants/{merchantId}")
    public Uni<Double> getPricingById(@NotNull Integer productId, @NotNull Integer merchantId) {
        return repository
                .findProductPricing(productId, merchantId)
                .onItem().ifNotNull().transform(result -> result.doubleValue())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @GET
    @Path("/categories/{categoryId}")
    public Uni<String> getCategoryById(@NotNull Integer categoryId) {
        return repository
                .findCategoryById(categoryId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @GET
    @Path("/subcategories/{subcategoryId}")
    public Uni<String> getSubcategoryById(@NotNull Integer subcategoryId) {
        return repository
                .findSubcategoryById(subcategoryId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    public Uni<Response> postProduct(@Valid ProductDto.Create dto) {
        var result = repository
                .saveProduct(dto)
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
                    .created(URI.create("/products/" + id))
                    .build()
                );
    }

    @POST
    @Path("/categories")
    public Uni<Response> postCategory(@Valid CategoryDto dto) {
        var result = repository
                .saveCategory(dto)
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
                    .created(URI.create("/categories/" + id))
                    .build()
                );
    }

    @POST
    @Path("/subcategories")
    public Uni<Response> postSubcategory(@Valid SubcategoryDto dto) {
        var result = repository
                .saveSubcategory(dto)
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
                    .created(URI.create("/subcategories/" + id))
                    .build()
                );
    }

    @PUT
    @Path("/{productId}")
    public Uni<Response> putProduct(@NotNull Integer productId, @Valid ProductDto.Update dto) {
        Integer[] productIds = {productId, dto.getProductId()};
        service.checkIfIdsMatch(productIds);

        return repository
                .updateProduct(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
    @PUT
    @Path("/categories/{categoryId}")
    public Uni<Response> putCategory(@NotNull Integer categoryId, @Valid CategoryDto dto) {
        Integer[] categoryIds = {categoryId, dto.getCategoryId()};
        service.checkIfIdsMatch(categoryIds);

        return repository
                .updateCategory(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/subcategories/{subcategoryId}")
    public Uni<Response> putSubcategory(@NotNull Integer subcategoryId, @Valid SubcategoryDto dto) {
        Integer[] subcategoryIds = {subcategoryId, dto.getSubcategoryId()};
        service.checkIfIdsMatch(subcategoryIds);

        return repository
                .updateSubcategory(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
    
    @PUT
    @Path("/deactivate/{productId}")
    public Uni<Response> deactivate(@NotNull Integer productId) {
        return repository
                .deactivateProduct(productId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{productId}")
    public Uni<Response> deleteProduct(@NotNull Integer productId) {
        return repository
                .deleteProduct(productId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/categories/{categoryId}")
    public Uni<Response> deleteCategory(@NotNull Integer categoryId) {
        return repository
                .deleteCategory(categoryId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/subcategories/{subcategoryId}")
    public Uni<Response> deleteSubcategory(@NotNull Integer subcategoryId) {
        return repository
                .deleteSubcategory(subcategoryId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }
}
