package seCurity;

import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.server.filter.RolesAllowedDynamicFeature;

public class JerseyServer extends ResourceConfig 
{


	public JerseyServer() 
	{
		register(RolesAllowedDynamicFeature.class);
	}
}


