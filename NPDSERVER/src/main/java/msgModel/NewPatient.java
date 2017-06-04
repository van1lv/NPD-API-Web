package msgModel;

import org.json.JSONException;
import org.json.JSONObject;

public class NewPatient {

	private String allow;
	private String priKey;
	
	public String getPriKey() {
		return priKey;
	}
	public void setPriKey(String priKey) {
		this.priKey = priKey;
	}
	public String getAllow() {
		return allow;
	}
	public void setAllow(String allow) {
		this.allow = allow;
	}
	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("Allow", allow).put("pid", priKey).toString();
        } catch (JSONException e) {
            return null;
        }
	}
}
