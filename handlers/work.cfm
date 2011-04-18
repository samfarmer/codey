<cfoutput>
<head>
	<script type="text/javascript" src="jquery.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('##runButton').live('click', function(){
			$.getJSON( 'codey.cfc?method=saveFile&'+$('##code').serialize(), function( data ) {
				if ( data.STATUS == "good" ) {
					$('##bottom').html( data.FILEHTML );
					$('##messageArea').html('');
				} else {
					$('##messageArea').html( data.MESSAGE );
					$('##bottom').html( data.FILEHTML );
				}
			});
		});
		$('##clearButton').live('click', function(){
			$('##code').val('');
			$('##bottom').html('');
		});
	});
	</script>
	<style type="text/css">
	body { font-family: Monaco; font-size: 0.9em; margin: 0 0 0 0; }
	div { margin: 0.2em 0.2em 0.2em 0.2em; }
	##banner { font-size: 0.6em; background-color: ##cfcfc9; margin: 0 0 0 0; padding: 0.2em 0.2em 0.2em 0.2em; }
	textarea { height: 8em; border: thin solid silver; width: 100%; color: Blue; font-size: 0.9em; }
	##bottom { border-top: thin solid silver; }
	</style>
</head>
<body>
	<div id="banner">
		<input type="button" value="Clear" id="clearButton"> Code with either tags or script.  For script surround variables in ## signs to output.
	</div>
	<div id="top">
		<textarea name="code" id="code"></textarea><br>
		<input type="button" value="Run" id="runButton">
		<span id="messageArea"></span>
	</div>
	<div id="bottom">results appear here</div>
</body>
</cfoutput>