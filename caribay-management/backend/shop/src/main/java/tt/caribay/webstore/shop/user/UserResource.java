package tt.caribay.webstore.shop.user;

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

@Path("/users")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class UserResource {

    private final UserService service;
    private final UserRepository repository;

    @GET
    public Uni<String> get() {
        return repository.findAll()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }

    @GET
    @Path("/{userId}")
    public Uni<String> getById(@NotNull Integer userId) {
        return repository.findById(userId)
                .onItem().ifNotNull().transform(result -> result.toString())
                .onItem().ifNull().failWith(NotFoundException::new);
    }

    @POST
    public Uni<Response> post(@Valid UserDto.Create dto) {
        var newEntity = repository
                .doesEmailExist(dto.getEmailAddress())
                .onItem().transform(bool -> bool
                        ? null
                        : service.createUser(dto)
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
                .onItem().transformToUni(repository::save)
                .onItem().transform(id -> Response
                        .created(URI.create("/users/" + id))
                        .build()
                );
    }

    @POST
    @Path("/login")
    public Uni<Response> login(@Valid UserDto.Login dto) {
        var email = dto.getEmailAddress();
        var password = dto.getPassword();

        return repository.getHash(email)
                .onItem().ifNotNull().transform(bytes -> new String(bytes, StandardCharsets.UTF_8))
                .onItem().ifNotNull().transform(hash -> service.verifyHash(password, hash))
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
    @Path("/{userId}")
    public Uni<Response> put(@NotNull Integer userId, @Valid UserDto.Update dto) {
        Integer[] userIds = {userId, dto.getUserId()};
        service.checkIfIdsMatch(userIds);

        return repository.update(dto)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/deactivate/{userId}")
    public Uni<Response> deactivate(@NotNull Integer userId) {

        return repository.deactivate(userId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @DELETE
    @Path("/{userId}")
    public Uni<Response> delete(@NotNull Integer userId) {
        return repository.delete(userId)
                .onItem().transform(c -> c > 0
                    ? Response.Status.NO_CONTENT
                    : Response.Status.NOT_FOUND
                )
                .onItem().transform(s -> Response.status(s).build());
    }

    @PUT
    @Path("/password/{userId}")
    public Uni<Response> updatePassword(@NotBlank String password) {
        // TODO: implement functionality to update customer password
        return Uni.createFrom().item(Response.status(Response.Status.SERVICE_UNAVAILABLE).build());
    }
}
