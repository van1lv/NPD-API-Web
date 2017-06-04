package dbServer;

import java.security.Principal;
import java.util.List;

/**
 * User bean.
 *
 * @author Deisss (MIT License)
 */
public class User implements Principal {
	private String id, username, login, email, password;
	private List<String> role;

	public void setId(String id) 
	{
		this.id = id;
		}
	public String getId() 
	{
		return this.id;
		}
	public String getUserName() 
	{
		return this.username;
		}
	public void setUserName(String userName) 
	{
		this.username = userName;
		}
	
	public String getLogin() 
	{
		return login;
		}
	public void setLogin(String login) 
	{
		this.login = login;
		}
	public String getEmail() 
	{
		return email;
		}
	public void setEmail(String email) 
	{
		this.email = email;
		}
	public String getPassword() 
	{
		return password;
		}
	public void setPassword(String password) 
	{
		this.password = password;
		}
	public List<String> getRole() 
	{
		return role;
	}
	public void setRole(List<String> role) 
	{
		this.role = role;
		}
	
	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return username;
	}

	
}