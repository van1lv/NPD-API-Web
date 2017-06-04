package msgModel;



import javax.xml.bind.annotation.*;

import org.json.JSONException;
import org.json.JSONObject;

@XmlRootElement
public class SearchByDoctor {
	@XmlElement(name="name")
	private String name;
	@XmlElement(name="pid")
	private String pid;
	@XmlElement(name="email")
	private String email;

	public SearchByDoctor(){}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("pid", pid).put("email", email).put("name", name).toString();
        } catch (JSONException e) {
            return null;
        }
	}
	
	
}
