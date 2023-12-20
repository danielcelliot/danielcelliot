package tt.caribay.webstore.shop.customer;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import io.quarkus.test.junit.QuarkusTest;
import io.quarkus.test.junit.mockito.InjectMock;
import io.restassured.response.Response;

import tt.caribay.webstore.shop.service.CustomerService;

import static io.restassured.RestAssured.given;

@QuarkusTest
class ThrowableMapperTest {
    
    @InjectMock
    CustomerService customerService;

    @Test
    void throwUnexpectedRuntimeExceptionInCustomerService() {
        Mockito.when(customerService.getCustomers())
                .thenThrow(new RuntimeException("Completely unexpected"));
        Response errorResponse =
            given()
            .when()
                .get("/customers")
            .then()
                .statusCode(500)
                .extract().response();
        
        errorResponse.prettyPrint();
    }
}
