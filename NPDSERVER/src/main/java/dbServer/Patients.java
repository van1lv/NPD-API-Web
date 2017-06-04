package dbServer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import msgModel.LoginMsg;
import msgModel.MaxScore;
import msgModel.NewPatient;
import msgModel.PatientRecientScore;
import msgModel.URIinfo;
import seCurity.BasicAuth;


@Path("npdpatients")
@PermitAll
public class Patients {

	//---------------------------------------------------------------------------------------------------------------------------------------------		
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response sayHello() 
	{

		ArrayList<URIinfo> array = new ArrayList<URIinfo>();

		URIinfo login = new URIinfo();
		login.setService("login");
		login.setUri("login");
		
		URIinfo maxscore =new URIinfo();
		maxscore.setService("maxscore");
		maxscore.setUri("patients/{pid}/maxscore/{gid}");

		URIinfo perlevel =new URIinfo();
		perlevel.setService("perlevel");
		perlevel.setUri("patients/{pid}/perlevel/{level}/{gid}");

		URIinfo newrecord = new URIinfo();
		newrecord.setService("newrecord");
		newrecord.setUri("newrecord/{gid}/{score}/{level}/{pid}/{date}/{percent}");

		URIinfo newpatient = new URIinfo();
		newpatient.setService("newpatient");
		newpatient.setUri("newpatient/{name}/{age}/{email}");
			
		array.add(maxscore);
		array.add(perlevel);
		array.add(newrecord);
		array.add(newpatient);
		array.add(login);
		
		return Response.status(200).entity(array.toString()).build();

	}
//---------------------------------------------------------------------------------------------------------------------------------------------
	@Path("login")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response login(@HeaderParam("authorization") String auth)
	{
			System.out.println("search");
			String[] lap = BasicAuth.decode(auth);
			String username = lap[0];
			String password = lap[1];
			System.out.println("lap[0]:"+username);
			System.out.println("lap[1]:"+password);
			System.out.println("1");

			System.out.println("Search");
			try {
				DbConn con = new DbConn();
				Connection conn;
				conn = con.getConnection();
				PreparedStatement statement;
				statement = conn.prepareStatement("SELECT username,password,real_name,t1.pid,email,age FROM (SELECT username,password,pid,email,real_name FROM npd.user) t1 INNER JOIN (SELECT pid, age FROM npd.patient) t2 on t1.pid=t2.pid");
				ResultSet result = statement.executeQuery();
				while (result.next())
				{
					String userdbName = null;
					String userdbPsw = null;
					String userdbPid = null;
					String userdbAge = null;
					String userdbEmail = null;
					String userdbRealName = null;
					userdbName = result.getString("username");
					userdbPsw = result.getString("password");
					userdbPid = result.getString("pid");
					userdbAge = result.getString("age");
					userdbEmail = result.getString("email");
					userdbRealName = result.getString("real_name");
					
					if (lap[0].equals(userdbName) && lap[1].equals(userdbPsw))
					{
						System.out.println("found");
						statement.close();
						conn.close();
						LoginMsg login = new LoginMsg();
						login.setAllow("yes");
						login.setPid(userdbPid);
						login.setAge(userdbAge);
						login.setEmail(userdbEmail);
						login.setReal_name(userdbRealName);
						return Response.status(200).entity(login).build();
					}
				}
				statement.close();
				conn.close();

			} catch (SQLException e) {

				e.printStackTrace();
				
			} catch (Exception e) {

				e.printStackTrace();
			}
			LoginMsg login = new LoginMsg();
			login.setAllow("no");
			return Response.status(200).entity(login.toString()).build();
		}

//---------------------------------------------------------------------------------------------------------------------------------------------
	
	@Path("patients/{pid}")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response patient() 
	{

		ArrayList<URIinfo> array = new ArrayList<URIinfo>();

		URIinfo maxscore =new URIinfo();
		maxscore.setService("maxscore");
		maxscore.setUri("maxscore/{gid}");

		URIinfo perlevel =new URIinfo();
		perlevel.setService("perlevel");
		perlevel.setUri("perlevel/{level}/{gid}");

		array.add(maxscore);
		array.add(perlevel);
		
		return Response.status(200).entity(array.toString()).build();

	}
	//---------------------------------------------------------------------------------------------------------------------------------------------		
	
	@Path("patients/{pid}/maxscore/{gid}")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response maxScore(@PathParam("pid") String pid,@PathParam("gid") String gid ) throws Exception{

		System.out.println(pid);
		DbConn con = new DbConn();
		Connection conn =con.getConnection();
		String sql="SELECT * FROM (SELECT max(score) as max, level FROM npd.game_record where gid ="+gid+" GROUP BY level) t1 INNER JOIN (SELECT max(score) as patient, level FROM npd.game_record where gid ="+gid+" and pid = "+pid+" GROUP BY level) t2 ON t1.level = t2.level";
		PreparedStatement statement =conn.prepareStatement(sql);
		ResultSet result = statement.executeQuery();
		ArrayList<MaxScore> array = new ArrayList<MaxScore>();

		while(result.next()){
			MaxScore maxScore = new MaxScore();
			maxScore.setLevel(result.getString("level"));
			maxScore.setMax(result.getString("max"));
			maxScore.setPatient(result.getString("patient"));
			array.add(maxScore);
		}
		statement.close();
		conn.close();
		return Response.status(200).entity(array.toString()).build();


	}
//---------------------------------------------------------------------------------------------------------------------------------------------	
	@Path("patients/{pid}/perlevel/{level}/{gid}")
	@GET
	@Produces("application/json")
	@RolesAllowed("registered")
	public Response perlevelScore(@PathParam("pid") String pid, @PathParam("level") String level,@PathParam("gid") String gid) throws Exception
	{
		try {
			System.out.println("asdfasf");
			System.out.println(pid);
			DbConn con = new DbConn();
			Connection conn =con.getConnection();


			String sql ="SELECT score,percent,date FROM npd.game_record where pid="+pid+" and level="+level+" and gid = "+gid+" order by date DESC limit 10";
			PreparedStatement statement;

			statement = conn.prepareStatement(sql);

			ResultSet result = statement.executeQuery();
			ArrayList<PatientRecientScore> array = new ArrayList<PatientRecientScore>();
			System.out.println("here");

			while(result.next()){
				PatientRecientScore patientScore = new PatientRecientScore();

				patientScore.setScore(result.getString("score"));
				patientScore.setTime(result.getString("date"));
				patientScore.setPercent(result.getString("percent"));
				array.add(patientScore);
				System.out.println(patientScore.getScore());
				System.out.println(patientScore.getTime());
			}
			System.out.println("here2");
			System.out.println(array.toString());
			statement.close();
			conn.close();
			return Response.status(200).entity(array.toString()).build();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------

	@Path("newpatient/{name}/{age}/{email}")
	@GET
	@Produces("application/json")
	@RolesAllowed("unregistered")
	public Response newPatient(
			@PathParam("name") String name,
			@PathParam("age") String age,
			@PathParam("email") String email,
			@HeaderParam("authorization") String auth)
	{
		int priKey=0;
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
			System.out.println("2");
			String sql1 ="INSERT INTO npd.patient(age, pipe_level, ball_level, balloon_level, breakout_level, poker_level, color_level) VALUES("+age+",1,1,1,1,1,1)";
			PreparedStatement statement;
			statement = conn.prepareStatement(sql1,Statement.RETURN_GENERATED_KEYS);
			statement.executeUpdate();
			ResultSet result =statement.getGeneratedKeys();
			
			System.out.println("3");
			
			
			while(result.next())
			{
				priKey=result.getInt(1);

			}
			System.out.println(priKey);

			String sql2 = "INSERT INTO npd.user(username,password,role,pid,real_name,email) VALUES ('"+username+"','"+password+"','registered',"+priKey+",'"+name+"','"+email+"')";
			System.out.println("not reach");
			statement = conn.prepareStatement(sql2);
			statement.executeUpdate();
			statement.close();
			conn.close();
			//role
			String pk = String.valueOf(priKey);
			NewPatient np = new NewPatient();
			np.setAllow("yes");
			np.setPriKey(pk);
			return Response.status(200).entity(np.toString()).build();
		}
		catch(com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException e)
		{
			try {
			System.out.println("roll back");
			String sql4 ="DELETE FROM npd.patient WHERE pid ="+priKey;
			PreparedStatement statement;
			statement = conn.prepareStatement(sql4);
			statement.executeUpdate();
			NewPatient dup = new NewPatient();
			dup.setAllow("duplicate");
			 
			return Response.status(200).entity(dup.toString()).build();
			} 
			catch (SQLException e1) 
			{
			
				e1.printStackTrace();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
//---------------------------------------------------------------------------------------------------------------------------------------------	
	@Path("patients/newrecord/{gid}/{score}/{level}/{pid}/{date}/{percent}")
	@POST
	@Produces("application/json")
	@RolesAllowed("registered")
	public void updatePatient(@PathParam("gid") String gid,
									  @PathParam("score") String score,
									  @PathParam("level") String level,
									  @PathParam("pid") String pid,
									  @PathParam("date") String date,
									  @PathParam("percent") String percent)
		{
			
			try {
			DbConn con = new DbConn();
			Connection conn =con.getConnection();
			System.out.println(date);
			String sql1 ="INSERT INTO npd.game_record(gid, score, level, pid, date, percent) VALUES("+gid+","+score+","+level+","+pid+",'"+date+"',"+percent+")";
			PreparedStatement statement;
			statement = conn.prepareStatement(sql1);
			statement.executeUpdate();
			
			String game = null;
			if(gid.equals("1"))
			{
				game = "pipe_level";
			}
			else if(gid.equals("2"))
			{
				game = "ball_level";
			}
			else if(gid.equals("3"))
			{
				game = "balloon_level";
			}
			else if(gid.equals("4"))
			{
				game = "breakout_level";
			}
			else if(gid.equals("5"))
			{
				game = "poker_level";
			}
			else if(gid.equals("6"))
			{
				game = "color_level";
			}
			String sql2="SELECT "+game+" FROM npd.patient where pid="+pid;
			statement =conn.prepareStatement(sql2);
			
			ResultSet result = statement.executeQuery();
			
			String reLevel = null;
			while(result.next())
			{
				reLevel =result.getString(game);	
			}
			System.out.println("update");
			System.out.println(reLevel);
			if(!level.equals(reLevel))
			{
				System.out.println("not equal");
				System.out.println(game);
				System.out.println(level);
				System.out.println(pid);
				System.out.println("updated");
				String sql3="UPDATE npd.patient SET "+game+"="+level+" WHERE pid ="+pid;
				System.out.println(sql3);
				statement =conn.prepareStatement(sql3);
				statement.executeUpdate();
			}
			statement.close();
			conn.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
		}

//---------------------------------------------------------------------------------------------------------------------------------------------		
	
}
