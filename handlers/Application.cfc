<cfcomponent>
<cfsetting showdebugoutput="false">
<cffunction name="onRequestStart">
	<cfscript>
	if ( len( cgi.HTTPS ) ) {
		request.ideUrl = "https://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT_SECURE;
	} else {
		request.ideUrl = "http://" & cgi.HTTP_HOST & ":" & cgi.SERVER_PORT;
	}
	request.ideUrl &= getDirectoryFromPath( cgi.script_name );
	</cfscript>	
</cffunction> 
</cfcomponent>