package tt.autoserve.bean;

public class LoginBean {
	
	private String username;
	private String password;
	private int type = 0;
	private int id;
	
	public LoginBean() {}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public int getUserType() {
		return type;
	}
	
	public void setUserType(int type) {
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
