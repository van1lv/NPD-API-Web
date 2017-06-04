package dbServer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import msgModel.LoginMsg;
import msgModel.NewDoctor;
import msgModel.NewPatient;
import msgModel.SearchByDoctor;
import msgModel.URIinfo;
import seCurity.BasicAuth;


@Path("npddoctors")
@PermitAll
public class Doctors {

	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response sayHello() 
	{

		ArrayList<URIinfo> array = new ArrayList<URIinfo>();

		URIinfo newdoctor = new URIinfo();
		newdoctor.setService("newdoctor");
		newdoctor.setUri("newdoctor/{name}/{age}/{email}");

		URIinfo searchid = new URIinfo();
		searchid.setService("searchid");
		searchid.setUri("searchids/{email}");

		URIinfo login = new URIinfo();
		login.setService("login");
		login.setUri("login");

		array.add(login);
		array.add(newdoctor);
		array.add(searchid);
		return Response.status(200).entity(array.toString()).build();

	}

	@Path("login")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response login()
	{
		LoginMsg login = new LoginMsg();
		login.setAllow("yes");
		return Response.status(200).entity(login).build();
	}

	@Path("newdoctor/{name}/{age}/{email}")
	@GET
	@Produces("application/json")
	@RolesAllowed("unregistered")
	public Response newDoctor(
			@PathParam("name") String name,
			@PathParam("age") String age,

			@PathParam("email") String email,
			@HeaderParam("authorization") String auth)
	{

		DbConn con  = null;
		Connection conn = null;

		try {
			System.out.println("adfs");
			String[] lap = BasicAuth.decode(auth);
			String username = lap[0];
			String password = lap[1];
			System.out.println("lap[0]:"+username);
			System.out.println("lap[1]:"+password);
			System.out.println("1");
			con  = new DbConn();
			conn =con.getConnection();
			PreparedStatement statement;
			String sql = "INSERT INTO npd.user(username,password,role,real_name,email) VALUES ('"+username+"','"+password+"','registered','"+name+"','"+email+"')";
			System.out.println("not reach");
			statement = conn.prepareStatement(sql);
			statement.executeUpdate();
			statement.close();
			conn.close();

			NewDoctor nd = new NewDoctor();
			nd.setAllow("yes");
			return Response.status(200).entity(nd.toString()).build();
		}

		catch(Exception e)
		{
			System.out.println("error!");
			e.printStackTrace();
			NewDoctor nd = new NewDoctor();
			nd.setAllow("no");
			return Response.status(200).entity(nd.toString()).build();
		}

	}
	//----------------------------------------------------------------------------------------------
	@Path("searchids/{email}")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")

	public Response searchbyDoctor(@PathParam("email") String email)
	{

		System.out.println("Search");
		try {
			DbConn con = new DbConn();
			Connection conn;
			conn = con.getConnection();
			PreparedStatement statement;
			statement = conn.prepareStatement("SELECT real_name,pid,email FROM npd.user");
			ResultSet result = statement.executeQuery();

			SearchByDoctor msg = new SearchByDoctor();
			while (result.next())
			{

				String real_name = null;
				String returnPid = null;
				String returnEmail = null;
				real_name = result.getString("real_name");
				returnPid = result.getString("pid");
				returnEmail = result.getString("email");

				if (email.equals(returnEmail))
				{
					System.out.println("found");

					msg.setEmail(email);
					msg.setName(real_name);
					msg.setPid(returnPid);

					statement.close();
					conn.close();
					return Response.status(200).entity(msg.toString()).build();
				}
			}

			statement.close();
			conn.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchByDoctor nf = new SearchByDoctor();
		nf.setEmail("Not found");
		nf.setName("Not found");
		nf.setPid("Not found");
		System.out.println(nf.toString());
		return Response.status(200).entity(nf.toString()).build();

	}
}
