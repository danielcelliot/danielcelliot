package tt.caribay.webstore.common.service;

import javax.enterprise.context.ApplicationScoped;

import com.sanctionco.jmail.JMail;

@ApplicationScoped
public class GenericService {

    // Used by @ValidEmail Validator
    public boolean isEmailValid(String email) {
        return JMail.isValid(email);
    }
    
    // Used by @MatchIds Validator
    public boolean doIdsMatch(Integer[] ids) {
        return (ids[0].intValue() == ids[1].intValue()) ? true : false;
    }
}
