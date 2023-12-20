package tt.caribay.webstore.shop.shipment;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.smallrye.mutiny.Uni;
import lombok.RequiredArgsConstructor;

@Path("shipments")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
@RequiredArgsConstructor
public class ShipmentResource {
    
    private final ShipmentRepository repo;

    @GET
    @Path("/options")
    public Uni<String> get() {
        return repo.findAllShipmentOptions()
                .onItem().ifNotNull().transform(list -> list.toString())
                .onItem().ifNull().continueWith(new String("[]"));
    }
}
