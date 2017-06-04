package msgModel;

import org.json.JSONException;
import org.json.JSONObject;

public class PatientRecientScore {
	
	//private String pid;
	
	private String time;

	private String score;

	private String percent;


	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}
	
	
	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("time", time).put("score", score).put("percent",percent).toString();
        } catch (JSONException e) {
            return null;
        }
	}
	
	

	
}
