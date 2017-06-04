package msgModel;

import org.json.JSONException;
import org.json.JSONObject;

public class LoginMsg {

	private String allow;
	private String pid;
	private String age;
	private String email;
	private String real_name;
	
	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String real_name) {
		this.real_name = real_name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAllow() {
		return allow;
	}
	public void setAllow(String allow) {
		this.allow = allow;
	}
	
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPid() {
		return pid;
	}
	
	
	
	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("Allow", allow).put("PatientID", pid).put("Email", email).put("Age", age).put("Name",real_name).toString();
        } catch (JSONException e) {
            return null;
        }
	}

}
