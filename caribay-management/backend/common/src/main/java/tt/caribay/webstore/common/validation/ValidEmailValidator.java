package tt.caribay.webstore.common.validation;

import javax.inject.Inject;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import tt.caribay.webstore.common.service.GenericService;

public class ValidEmailValidator implements ConstraintValidator<ValidEmail, String> {
    
    @Inject
    GenericService service;

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        return service.isEmailValid(value);
    }
}
