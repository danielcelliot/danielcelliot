package tt.caribay.webstore.common.validation;

import javax.inject.Inject;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import tt.caribay.webstore.common.service.GenericService;

public class MatchIdsValidator implements ConstraintValidator<MatchIds, Integer[]> {
    
    @Inject
    GenericService service;

    @Override
    public boolean isValid(Integer[] values, ConstraintValidatorContext context) {
        return service.doIdsMatch(values);
    }   
}