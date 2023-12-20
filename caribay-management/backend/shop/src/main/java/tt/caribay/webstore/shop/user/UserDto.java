package tt.caribay.webstore.shop.user;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import org.hibernate.validator.constraints.Length;

import lombok.Data;
import tt.caribay.webstore.common.validation.ValidEmail;

@JsonIgnoreProperties(ignoreUnknown = true)
public abstract class UserDto {
    
    @Data
    public static class Create {

        @NotBlank(message = "First name must not be empty")
        @Length(message = "First name cannot be more than 100 characters", max = 100)
        private String firstName;

        @NotBlank(message = "Last name must not be empty")
        @Length(message = "Last name cannot be more than 100 characters", max = 100)
        private String lastName;
        
        @ValidEmail
        @NotEmpty(message = "Email address cannot be empty")
        @Length(message = "Email address cannot be more than 100 characters", max = 100)
        private String emailAddress;
        
        @Length(message = "Password cannot be less than 8 characters", min = 8)
        @Length(message = "Password cannot be more than 100 characters", max = 100)
        private String password;
    }

    @Data
    public static class Update {
            
        @NotNull(message = "ID is required")
        private Integer userId;

        @NotBlank(message = "First name must not be empty")
        @Length(message = "First name cannot be more than 100 characters", max = 100)
        private String firstName;

        @NotBlank(message = "Last name must not be empty")
        @Length(message = "Last name cannot be more than 100 characters", max = 100)
        private String lastName;
        
        @ValidEmail
        @NotEmpty(message = "Email address cannot be empty")
        @Length(message = "Email address cannot be more than 100 characters", max = 100)
        private String emailAddress;
    }

    @Data
    public static class Login {

        @ValidEmail
        @NotEmpty(message = "Email address cannot be empty")
        @Length(message = "Email address cannot be more than 100 characters", max = 100)
        private String emailAddress;

        @Length(message = "Password cannot be less than 8 characters", min = 8)
        @Length(message = "Password cannot be more than 100 characters", max = 100)
        private String password;
    }
}
