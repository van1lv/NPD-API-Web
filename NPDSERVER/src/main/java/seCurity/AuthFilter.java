package seCurity;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.Provider;
import dbServer.DbConn;
import dbServer.User;
import javax.ws.rs.container.PreMatching;

@Provider
@PreMatching
public class AuthFilter implements ContainerRequestFilter 
{
	@Override
	public void filter(ContainerRequestContext containerRequest) 
	{
		String method = containerRequest.getMethod();
		String path = containerRequest.getUriInfo().getPath(true);
		String auth = containerRequest.getHeaderString("authorization");
		if(auth == null){
			throw new WebApplicationException(Status.UNAUTHORIZED);
		}
		String[] lap = BasicAuth.decode(auth);
		if(lap == null || lap.length != 2){
			throw new WebApplicationException(Status.UNAUTHORIZED);
		}
		try {
			System.out.println("Auth ing");
			DbConn con = new DbConn();
			Connection conn;
			conn = con.getConnection();
			PreparedStatement statement =conn.prepareStatement("SELECT username,password,role FROM npd.user");
			ResultSet result = statement.executeQuery();
			String scheme = containerRequest.getUriInfo().getRequestUri().getScheme();
			User user = new User();
			while (result.next())
			{
				String userdbName = null;
				String userdbPsw = null;
				String userdbRole = null;
				userdbName = result.getString("username");
				userdbPsw = result.getString("password");
				userdbRole = result.getString("role");
				if (lap[0].equals(userdbName) && lap[1].equals(userdbPsw))
				{
					List<String> role = new ArrayList<String>();
					role.add(userdbRole);
					user.setRole(role);
					user.setUserName(userdbName);
					containerRequest.setSecurityContext(new MySecurityContext(user, scheme));
					statement.close();
					conn.close();
					return;
				}
			}
			List<String> role = new ArrayList<String>();
			role.add("unregistered");
			user.setRole(role);
			containerRequest.setSecurityContext(new MySecurityContext(user, scheme));
			conn.close();
			statement.close();
			return;
		}
		catch(Exception e)
		{
			System.out.println(e);
			System.out.println("error");
		}
		return;
	}
}

