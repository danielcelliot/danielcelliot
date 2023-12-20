package tt.caribay.webstore.shop.customer;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
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

@Path("/customers")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class CustomerResource {

    private final CustomerService customerService;
    private final CustomerRepository customerRepository;

    @GET
    public Uni<String> get() {
        return customerRepository.findAll()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/{customerId}")
    public Uni<String> getById(@NotNull Integer customerId) {
        return customerRepository.findById(customerId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    public Uni<Response> post(@Valid CustomerDto.Create customerDto) {
        var newEntity = customerRepository
                .doesEmailExist(customerDto.getEmailAddress())
                .onItem().transform(bool -> bool
                        ? null
                        : customerService.createCustomer(customerDto)
                )
                .onItem().ifNull().failWith(new BadRequestException(
                    Response.status(Response.Status.BAD_REQUEST)
                            .entity(
                                new ErrorResponse(
                                    new ErrorMessage(
                                        "emailAddress",
                                        "Email address is already in use. Please try another"
                                    )
                                )
                            )
                            .build()
                ));

        return newEntity
                .onItem().transformToUni(customerRepository::save)
                .onItem().transform(id -> Response
                        .created(URI.create("/customers/" + id))
                        .build()
                );
    }

    @POST
    @Path("/login")
    public Uni<Response> login(@Valid CustomerDto.Login customerDto) {
        var email = customerDto.getEmailAddress();
        var password = customerDto.getPassword();

        return customerRepository.getHash(email)
                .onItem().ifNotNull().transform(bytes -> new String(bytes, StandardCharsets.UTF_8))
                .onItem().ifNotNull().transform(hash -> customerService.verifyHash(password, hash))
                .onItem().ifNotNull().transform(bool -> bool
                        ? Response.ok("Valid credentials!").build()
                        : null
                )
                .onItem().ifNull().failWith(() -> new BadRequestException(
                    Response.status(Response.Status.BAD_REQUEST)
                            .entity(
                                new ErrorResponse(
                                    new ErrorMessage(
                                        Arrays.toString(new String[] {"emailAddress", "password"}),
                                        "Email address or password is invalid"
                                    )
                                )
                            )
                            .build()
                ));
    }

    @PUT
    @Path("/{customerId}")
    public Uni<Response> put(@NotNull Integer customerId, @Valid CustomerDto.Update customerDto) {
        Integer[] customerIds = {customerId, customerDto.getCustomerId()};
        customerService.checkIfIdsMatch(customerIds);

        return customerRepository.update(customerDto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/deactivate/{customerId}")
    public Uni<Response> deactivate(@NotNull Integer customerId) {

        return customerRepository.deactivate(customerId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{customerId}")
    public Uni<Response> delete(@NotNull Integer customerId) {
        return customerRepository.delete(customerId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/password/{customerId}")
    public Uni<Response> updatePassword(@NotBlank String password) {
        // TODO: implement functionality to update customer password
        return Uni.createFrom().item(Response.status(Response.Status.SERVICE_UNAVAILABLE).build());
    }
}
