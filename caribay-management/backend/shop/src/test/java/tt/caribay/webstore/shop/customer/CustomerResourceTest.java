package tt.caribay.webstore.shop.customer;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.apache.commons.lang3.RandomStringUtils;

import io.quarkus.test.common.http.TestHTTPEndpoint;
import io.quarkus.test.junit.QuarkusTest;
import io.restassured.http.ContentType;
import io.smallrye.common.annotation.Blocking;
import tt.caribay.webstore.shop.configuration.flyway.RunFlyway;
import tt.caribay.webstore.shop.model.dto.Customer;
import tt.caribay.webstore.shop.resource.CustomerResource;

import static io.restassured.RestAssured.given;

import javax.inject.Inject;

@QuarkusTest
@Blocking
@TestHTTPEndpoint(CustomerResource.class)
class CustomerResourceTest {

    @Inject
    RunFlyway flyway;

    @AfterEach
    void tearDown() {
        flyway.runMigrationWithConfig();
    }
    
    @Test
    void should_GetAllCustomers() {
        given()
        .when()
            .get()
        .then()
            .statusCode(200);
    }

    @Test
    void should_GetCustomerById() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Daniel",
                "lastName": "Elliot",
                "emailAddress": "daniel@caribay.tt",
                "password": "supersecretpassword"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer by id
        testMethod_GetRequestById(1, 200);
    }

    @Test
    void should_FailToGetCustomer_WithInvalidId() {
        testMethod_GetRequestById(987654321, 404);
    }

    @Test
    void should_CreateNewCustomer() {
        var postRequestBody = """
            {
                "firstName": "Biggie",
                "lastName": "Norris",
                "emailAddress": "biggie@norrisnuts.au",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);
    }

    @Test
    void should_FailToCreateCustomer_WithNoFirstName() {
        var postRequestBody = """
            {
                "lastName": "Norris",
                "emailAddress": "biggie@norrisnuts.au",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }
    
    @Test
    @Disabled("TODO: Check response body for errors instead")
    void postFailNoFirstNameResponse() {
        var errorResponse = 
            given()
                .contentType(ContentType.JSON)
                .body
                ("""
                    {
                        "lastName": "Norris",
                        "emailAddress": "biggie@norrisnuts.au",
                        "password": "catchmeknucklesyeah"
                    }
                """)
            .when()
                .post()
            .then()
                .statusCode(400)
            .and()
                .extract().response();
        
        errorResponse.prettyPrint();
    }

    @Test
    void should_FailToCreateCustomer_WithBlankFirstName() {
        var postRequestBody = """
            {
                "firstName": " ",
                "lastName": "Norris",
                "emailAddress": "biggie@norrisnuts.au",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }
    
    @Test
    void should_FailToCreateCustomer_WhenFirstNameExceedsLength() {
        var customer = new Customer.CreateDTO();
        customer.setFirstName(RandomStringUtils.randomAlphabetic(101));
        customer.setLastName("Smith");
        customer.setEmailAddress("smith@example.com");
        customer.setPassword("correcthorsebatterystaple");

        testMethod_PostRequest(customer, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithNoLastName() {
        var postRequestBody = """
            {
                "firstName": "Biggie",
                "emailAddress": "biggie@norrisnuts.au",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithBlankLastName() {
        var postRequestBody = """
            {
                "firstName": "Biggie",
                "lastName": " ",
                "emailAddress": "biggie@norrisnuts.au",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WhenLastNameExceedsLength() {
        var customer = new Customer.CreateDTO();
        customer.setFirstName("John");
        customer.setLastName(RandomStringUtils.randomAlphabetic(101));
        customer.setEmailAddress("smith@example.com");
        customer.setPassword("correcthorsebatterystaple");

        testMethod_PostRequest(customer, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithDuplicateEmail() {
        // Create customer 1 with unique email
        var postRequestBody = """
            {
                "firstName": "Jon",
                "lastName": "Snow",
                "emailAddress": "unique@example.com",
                "password": "winteriscoming"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);
        
        // Create customer 2 with duplicate email
        postRequestBody = """
            {
                "firstName": "Petyr",
                "lastName": "Baelish",
                "emailAddress": "unique@example.com",
                "password": "ididwarnyounottotrustme"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithNoEmail() {
        var postRequestBody = """
            {
                "firstName": "Biggie",
                "lastName": "Norris",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithInvalidEmail() {
        var postRequestBody = """
            {
                "firstName": "Biggie",
                "lastName": "Norris",
                "emailAddress": "first.last@[::12.34.56.78]",
                "password": "catchmeknucklesyeah"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WhenEmailExceedsLength() {
        var customer = new Customer.CreateDTO();
        customer.setFirstName("John");
        customer.setLastName("Smith");
        customer.setEmailAddress(RandomStringUtils.randomAlphabetic(101) + "smith@example.com");
        customer.setPassword("correcthorsebatterystaple");

        testMethod_PostRequest(customer, 400);
    }

    @Test
    void should_FailToCreateCustomer_WhenPasswordUnderMinLength() {
        var postRequestBody = """
            {
                "firstName": "Gabe",
                "lastName": "Newell",
                "emailAddress": "gaben@valvesoftware.com",
                "password": "hl3"
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_FailToCreateCustomer_WhenPasswordExceedsLength() {
        var customer = new Customer.CreateDTO();
        customer.setFirstName("Gabe");
        customer.setLastName("Newell");
        customer.setEmailAddress("gaben@valvesoftware.com");
        customer.setPassword(RandomStringUtils.randomAlphanumeric(101));
        
        testMethod_PostRequest(customer, 400);
    }

    @Test
    void should_FailToCreateCustomer_WithInvalidJson() {
        var postRequestBody = """
            {
                // {
                    //     "firstName": "Biggie",
                    //     "lastName": "Norris",
                    //     "emailAddress": "biggie@norrisnuts.au",
                    //     "password": "catchmeknucklesyeah"
                // }
            }
        """;
        testMethod_PostRequest(postRequestBody, 400);
    }

    @Test
    void should_UpdateExistingCustomer() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer
        customerDto.setLastName("Smith");
        testMethod_PutRequest(1, customerDto, 204);
    }
    
    @Test
    void should_FailToUpdateCustomer_WithMismatchedIds() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with wrong Id in request body only
        customerDto.setCustomerId(2);
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WithInvalidId() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with wrong Id
        customerDto.setCustomerId(3);
        testMethod_PutRequest(3, customerDto, 404);
    }

    @Test
    void should_FailToUpdateCustomer_WithNoLastName() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with no last name (null)
        customerDto.setLastName(null);
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WithNoFirstName() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with no first name (null)
        customerDto.setFirstName(null);
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WhenFirstNameExceedsLength() {
       // Create customer
       var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with first name that exceeds the 100 character limit
        customerDto.setFirstName(RandomStringUtils.randomAlphabetic(101));
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WhenLastNameExceedsLength() {
        // Create customer
       var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer with last name that exceeds the 100 limit
        customerDto.setLastName(RandomStringUtils.randomAlphabetic(101));
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WithNoEmail() {
        // Create customer
       var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);

        // Update customer
        customerDto.setEmailAddress(null);
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_FailToUpdateCustomer_WithInvalidEmail() {
        // Create customer
       var postRequestBody = """
            {
                "firstName": "Jane",
                "lastName": "Doe",
                "emailAddress": "jane@example.com",
                "password": "uncrackable"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Get customer
        var customerDto = 
            testMethod_getRequestByIdAndExtractBody(1, 200, Customer.UpdateDTO.class);
        
        // Update customer
        customerDto.setEmailAddress("jane.example");
        testMethod_PutRequest(1, customerDto, 400);
    }

    @Test
    void should_DeleteCustomer() {
        // Create customer
        var postRequestBody = """
            {
                "firstName": "John",
                "lastName": "Hancock",
                "emailAddress": "john@example.com",
                "password": "abc12345"
            }
        """;
        testMethod_PostRequest(postRequestBody, 201);

        // Delete customer
        given()
        .when()
            .delete("/{customerId}", 1)
        .then()
            .statusCode(204);
    }

    @Test
    void should_FailToDeleteCustomer_WithInvalidId() {
        given()
        .when()
            .delete("/{customerId}", 12345)
        .then()
            .statusCode(404);
    }

    private void testMethod_GetRequestById(int pathParamId, int expectedStatusCode) {
        given()
        .when()
            .get("/{customerId}", pathParamId)
        .then()
            .statusCode(expectedStatusCode);
    }

    private <T> T testMethod_getRequestByIdAndExtractBody(int pathParamId, int expectedStatusCode, Class<T> extractAs) {
        var extracted = 
            given()
            .when()
                .get("/{customerId}", pathParamId)
            .then()
                .statusCode(expectedStatusCode)
            .and()
                .extract().body().as(extractAs);
        
        return extracted;
    }

    private void testMethod_PostRequest(String jsonBody, int expectedStatusCode) {
        given()
            .contentType(ContentType.JSON)
            .body(jsonBody)
        .when()
            .post()
        .then()
            .statusCode(expectedStatusCode);
    }

    private void testMethod_PostRequest(Customer.CreateDTO jsonBody, int expectedStatusCode) {
        given()
            .contentType(ContentType.JSON)
            .body(jsonBody)
        .when()
            .post()
        .then()
            .statusCode(expectedStatusCode);
    }

    private void testMethod_PutRequest(int pathParamId, Customer.UpdateDTO jsonBody, int expectedStatusCode) {
        given()
            .contentType(ContentType.JSON)
            .body(jsonBody)
        .when()
            .put("/{customerId}", pathParamId)
        .then()
            .statusCode(expectedStatusCode);
    }
}
