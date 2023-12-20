package tt.caribay.webstore.common.exception;

import java.util.stream.Collectors;

import javax.validation.ConstraintViolationException;
import javax.validation.Path;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.hibernate.validator.internal.engine.path.PathImpl;

import tt.caribay.webstore.common.exception.ErrorResponse.ErrorMessage;

@Provider
public class ConstraintViolationExceptionMapper
        implements ExceptionMapper<ConstraintViolationException> {

    @Override
    public Response toResponse(ConstraintViolationException exception) {
        var errorMessages = exception.getConstraintViolations()
                .stream()
                .map(constraintViolation -> new ErrorMessage(
                    getFieldFromPath(constraintViolation.getPropertyPath()),
                    constraintViolation.getMessage()))
                .collect(Collectors.toList());

        return Response
                .status(Response.Status.BAD_REQUEST)
                .entity(new ErrorResponse(errorMessages))
                .build();
    }

    private String getFieldFromPath(Path fieldPath) {
        var pathImpl = (PathImpl) fieldPath;
        return pathImpl.getLeafNode().toString();
    }
}
