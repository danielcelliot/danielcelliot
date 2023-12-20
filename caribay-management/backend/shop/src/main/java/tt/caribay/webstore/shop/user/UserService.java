package tt.caribay.webstore.shop.user;

import javax.enterprise.context.ApplicationScoped;

import com.password4j.Password;

import tt.caribay.webstore.common.validation.MatchIds;
import tt.caribay.webstore.shop.user.UserDto.Create;

@ApplicationScoped
public class UserService {

    public Create createUser(UserDto.Create userDto) {

        var plaintextPassword = userDto.getPassword();
        var hashedPassword = hashPassword(plaintextPassword);
        userDto.setPassword(hashedPassword);
        
        return userDto;
    }

    public boolean verifyHash(String password, String hashFromDB) {
        return Password.check(password, hashFromDB).withArgon2();
    }
    
    private String hashPassword(String plaintext) {
        var hash = Password.hash(plaintext).addRandomSalt(32).withArgon2();
        return hash.getResult();
    }

    public void checkIfIdsMatch(@MatchIds Integer[] userId) {}
}
