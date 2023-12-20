package tt.caribay.webstore.common.validation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Constraint(validatedBy = ValidEmailValidator.class)
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface ValidEmail {
    
    public String message() default "Please enter a valid email address. (e.g. yourname@example.com)";

    public Class<?>[] groups() default {};
	
	public Class<? extends Payload>[] payload() default {};
}
