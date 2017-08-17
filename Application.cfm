<!---

This application.cfm is here just to run the demos. It is not requied to use the cf_googleMap tag.
You just need to set your application.googlemapkey in your application.cfm and you can kill this file.

--->

<cfapplication name="cfgooglemap">
<cfsetting showdebugoutput="no">
<cfif cgi.server_name IS "www.blayter.local">
	<cfset Application.GoogleMapKey = "ABQIAAAAnCUWX4dtTXDLuTM4l7T77BQOI5mdxEjfNxsn3xADynEGWnaEIBSq6JIY-5-ZWhfQvV7v6CEi16zjLg">
<cfelseif cgi.server_name IS "www.blayter.com">
	<cfset Application.GoogleMapKey = "ABQIAAAAnCUWX4dtTXDLuTM4l7T77BS2AcXQ9ijr-Ku_5jKrie-4yno1wxQvmH93x0nWqAvErU7zrlV2AdaMag">
<cfelseif cgi.server_name IS "blayter.local">
	<cfset Application.GoogleMapKey = "ABQIAAAAnCUWX4dtTXDLuTM4l7T77BSxWWJ9GdpdrkXFfAJ2WFOF4T2YsRRblwZocCMfNNKvtnU_GcNONMlccA">
<cfelse>
	<!--- Set your Key Below --->
	<!--- <cfset Application.GoogleMapKey = ""> --->
</cfif>


<cfif NOT IsDefined("application.GoogleMapKey")>
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
	<body>
		<h1>You need a key to run the examples</h1>
		<p><a href="documentation.htm">Documentation</a></p>
		<div>
			You need a Google Map API Key in order to run the examples. You can get one <a href="http://www.google.com/apis/maps/signup.html">here</a>.
		</div>
	</body>
	</html>
	<cfabort>
</cfif>
