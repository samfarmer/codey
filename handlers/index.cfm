<cfheader name="Content-Type" value="text/xml">
<cfoutput>
<response showresponse="true">
	<ide url="#request.ideURL#work.cfm?ieCacheBuster=#createUUID()#">
		<view id="codeyView" title="codey" icon="" />
	</ide>
</response>	
</cfoutput>