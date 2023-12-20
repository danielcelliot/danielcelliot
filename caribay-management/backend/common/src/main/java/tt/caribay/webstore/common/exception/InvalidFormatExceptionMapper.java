package tt.caribay.webstore.common.exception;

import java.util.ResourceBundle;
import java.util.UUID;

import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;

import lombok.extern.slf4j.Slf4j;

import tt.caribay.webstore.common.exception.ErrorResponse.ErrorMessage;

@Provider
@Slf4j
public class InvalidFormatExceptionMapper implements ExceptionMapper<InvalidFormatException> {

    @Override
    public Response toResponse(InvalidFormatException exception) {

        var errorId = UUID.randomUUID().toString();
        log.error("errorId[{}]", errorId, exception);

        var errorMessage = ResourceBundle
                .getBundle("ValidationMessages")
                .getString("Format.error");
        var errorResponse =
            new ErrorResponse(errorId, new ErrorMessage(errorMessage));

        return Response
                .status(Response.Status.BAD_REQUEST)
                .entity(errorResponse)
                .build();
    }
}
