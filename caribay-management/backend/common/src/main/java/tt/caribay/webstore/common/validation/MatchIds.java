package tt.caribay.webstore.common.validation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Constraint(validatedBy = MatchIdsValidator.class)
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER, ElementType.FIELD})
public @interface MatchIds {
    
    public String message() default "Path parameter Id does not match object Id";

    public Class<?>[] groups() default {};
	
	public Class<? extends Payload>[] payload() default {};
}