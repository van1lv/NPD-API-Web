package msgModel;

import javax.xml.bind.annotation.*;

import org.json.JSONException;
import org.json.JSONObject;

@XmlRootElement
public class MaxScore {
	@XmlElement(name="level")
	private String level;
	@XmlElement(name="maxScore")
	private String maxScore;
	@XmlElement(name="patient")
	private String patient;

	public MaxScore(){}
	

	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	
	public String getMax() {
		return maxScore;
	}
	public void setMax(String max) {
		this.maxScore = max;
	}
	public String getPatient() {
		return patient;
	}
	public void setPatient(String patient) {
		this.patient = patient;
	}

	@Override
	public String toString()
	{
		try {
            // takes advantage of toString() implementation to format {"a":"b"}
            return new JSONObject().put("level", level).put("maxScore", maxScore).put("patient", patient).toString();
        } catch (JSONException e) {
            return null;
        }
	}
	
	
}
