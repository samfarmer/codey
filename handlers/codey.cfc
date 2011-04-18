<cfcomponent output="false">

<cffunction name="saveFile" access="remote" returnformat="JSON">
	<cfargument name="code" required="true">
	<cfscript>
	var fileName = createUUID() & ".cfm";
    var filePath = expandPath( "tempFiles/" & fileName );
	var status="good";
	var message="";
	var convertScriptToCode = false;
	if ( left( arguments.code, 1) != "<" ) {
		//save file, loop over and convert to run, save again
		convertScriptToCode = true;
	}
	fileWrite( filePath, "<cfoutput>#chr(10)##chr(13)#" & trim( arguments.code ) & "#chr(10)##chr(13)#</cfoutput>" );
	
	if ( convertScriptToCode ) {
		fileWrite( filePath, scriptToCode( filePath ) );
	}
	
	try {
    	savecontent variable="local.filehtml" {
			include "tempFiles/#fileName#";
		}
    } catch(Any e) {
    	status = "error";
    	message = "ERROR: " & e.message;
    	savecontent variable="local.filehtml" {
    		writeDump(var=e);
    	} 
    }
    
	fileDelete( filePath );
	
	return {status=status, message=message, fileHTML=local.filehtml};    
    </cfscript>
</cffunction>


<cffunction name="scriptToCode" access="private"> 
	<cfargument name="filePath" required="true">
	<cfset var coded = "">
	<cfset var line = "">
	<cfloop file="#arguments.filePath#" index="line">
		<cfif line contains "=" && ! listFindNoCase("=,<", left( line, 1 ) )>
			<cfset coded &= "<cfscript>" & line & "</cfscript>">
		<cfelse>
			<cfset coded &= line>
		</cfif>
		<cfset coded &= "#chr(10)##chr(13)#">
	</cfloop>
	<cfreturn coded> 
</cffunction>
</cfcomponent>	
