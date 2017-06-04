
package msgModel;

import org.json.JSONException;
import org.json.JSONObject;

public class NewDoctor 
{

	private String allow;
	
	public String getAllow() 
	{
		return allow;
	}
	
	public void setAllow(String allow) 
	{
		this.allow = allow;
	}
	
	@Override
	public String toString()
	{
		try {
           
            return new JSONObject().put("Allow", allow).toString();
        } 
		catch (JSONException e) 
		{
            return null;
        }
	}
}
