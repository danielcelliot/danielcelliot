package tt.caribay.webstore.shop.address;

import javax.validation.constraints.NotNull;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;

@Path("/addresses")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class AddressResource {
    
    private final AddressRepository repo;

    @GET
    @Path("/customers/{customerId}")
    public Uni<String> getCustomerAddresses(@NotNull Integer customerId) {
        return repo.findAddressesById(customerId)
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }
}
