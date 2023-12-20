package tt.caribay.webstore.common.exception;

import java.util.ResourceBundle;
import java.util.UUID;

import javax.ws.rs.NotAllowedException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import lombok.extern.slf4j.Slf4j;

import tt.caribay.webstore.common.exception.ErrorResponse.ErrorMessage;

@Provider
@Slf4j
public class NotAllowedExceptionMapper implements ExceptionMapper<NotAllowedException> {
    
    @Override
    public Response toResponse(NotAllowedException exception) {

        var errorId = UUID.randomUUID().toString();
        log.error("errorId[{}]", errorId, exception);

        var errorMessage = ResourceBundle
                .getBundle("ValidationMessages")
                .getString("NoMethod.error");
        var errorResponse =
            new ErrorResponse(errorId, new ErrorMessage(errorMessage));

        return Response
                .status(Response.Status.METHOD_NOT_ALLOWED)
                .entity(errorResponse)
                .build();
    }
}
