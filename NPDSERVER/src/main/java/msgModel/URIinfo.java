package msgModel;

import org.json.JSONException;
import org.json.JSONObject;

public class URIinfo {
	private String service;
	private String uri;
	
	
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	
	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("service", service).put("uri", uri).toString();
        } catch (JSONException e) {
            return null;
        }
	}

}
