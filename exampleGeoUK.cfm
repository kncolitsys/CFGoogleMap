<cfimport taglib="tags" prefix="gm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
	<style type="text/css">
	body, td {
		font-family: Arial;
		font-size: 12px;
		}
	th {
		font-family: Arial;
		font-size: 14px;
		font-weight: bold;
		background-color:#dcdcdc;
		}
	.small{font-size:10px;}
	h1 {font-size:22px;color:#ffffff;background-color:#000000; padding: 3 3 3 10;}
	h2 {font-size:18px;}
	a {color:#0000ff;text-decoration:none;}
	a:hover {text-decoration:underline;color:#ff0000}
	</style>
</head>
<body onunload="GUnload()">
	<h1>Example Geo - Example usage of the geocode function in the geo.cfc</h1>
	<p><a href="documentation.htm">Documentation</a> | <a href="source.cfm?source=Geo">View Source</a></p>
	<div style="width:700px;height:300px">
		
		<cfset variables.obj.geo = createObject("component","geo")>
		
		<cfset variables.sArgs.fullAddress = "15, Penryhn Avenue, Derby DE23 6LB, UK">
		<cfset variables.sArgs.googleMapKey = Application.GoogleMapKey>
		
		<cfset variables.sAddress = variables.obj.geo.Geocode(argumentCollection=variables.sArgs)>
		
		<cfdump var="#variables.sArgs#" label="Arguments">
		<br/><br/>
		<cfdump var="#variables.sAddress#" label="Results">
		
	</div>
	<gm:googlemapshow>
</body>
</html>

