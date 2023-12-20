package tt.caribay.webstore.shop.customer;

import javax.enterprise.context.ApplicationScoped;

import com.password4j.Password;

import tt.caribay.webstore.common.validation.MatchIds;
import tt.caribay.webstore.shop.customer.CustomerDto.Create;

@ApplicationScoped
public class CustomerService {

    public Create createCustomer(CustomerDto.Create customerDto) {

        var plaintextPassword = customerDto.getPassword();
        var hashedPassword = hashPassword(plaintextPassword);
        customerDto.setPassword(hashedPassword);
        
        return customerDto;
    }

    public boolean verifyHash(String password, String hashFromDB) {
        return Password.check(password, hashFromDB).withArgon2();
    }
    
    private String hashPassword(String plaintext) {
        var hash = Password.hash(plaintext).addRandomSalt(32).withArgon2();
        return hash.getResult();
    }

    public void checkIfIdsMatch(@MatchIds Integer[] customerId) {}
}
