<!---
	Name         : geo.cfc
	Version      : 0.9 
	Created      : Auguest 1, 2005
	Last Updated : December 1, 2005
	History      : 
	Purpose		 : functions for GEO coding and calculations for US addresses based on miles
--->
<cfcomponent displayname="Geo" hint="functions for GEO coding and calculations for US addresses based on miles">
	
	<cffunction name="distance" returntype="string" output="no" access="public" description="Calculates the distance between 2 lat/long points">
		<!--- Arguments [JLB]--->
		<cfargument name="lat1" type="string" required="yes" hint="">
		<cfargument name="lon1" type="string" required="yes" hint="">
		<cfargument name="lat2" type="string" required="yes" hint="">
		<cfargument name="lon2" type="string" required="yes" hint="">
		<!--- Declare local variables [JLB]--->
		<cfset var Instance = StructNew()>
		<!--- Logic [JLB]--->
		<cfset Instance.theta		= Arguments.lon1 - Arguments.lon2>
		<cfset Instance.dist		= sin(deg2rad(Arguments.lat1)) * sin(deg2rad(Arguments.lat2)) + cos(deg2rad(Arguments.lat1)) * cos(deg2rad(Arguments.lat2)) * cos(deg2rad(Instance.theta))>
		<cfset Instance.dist		= acos(Instance.dist)>
		<cfset Instance.dist		= rad2deg(Instance.dist)>
		<cfset Instance.distance	= Instance.dist * 60 * 1.1515>
		<!--- Return [JLB]--->
		<cfreturn Instance.distance/>
	</cffunction>
	
	<cffunction name="GeoBox" returntype="struct" output="no" access="public" description="Calculates a geographic box based off of center point and a radius distance">
		<!--- Arguments [JLB]--->
		<cfargument name="lat"    type="string" required="yes" hint="">
		<cfargument name="lon"    type="string" required="yes" hint="">
		<cfargument name="radius" type="string" required="yes" hint="">
		<!--- Declare local variables [JLB]--->
		<cfset var Instance = StructNew()>
		<!--- Logic [JLB]--->
		<cfset Instance.sBox		= StructNew()>
		<cfset Instance.sBox.LatMin = Arguments.Lat - (0.014474 * radius)>
		<cfset Instance.sBox.LatMax = Arguments.Lat + (0.014474 * radius)>
		<cfset Instance.sBox.LonMin = Arguments.Lon - (0.014474 * radius)>
		<cfset Instance.sBox.LonMax = Arguments.Lon + (0.014474 * radius)>
		<!--- Return [JLB]--->
		<cfreturn Instance.sBox/>
	</cffunction>
	
	<cffunction name="InRadius" returntype="query" output="no" access="public" description="Looks at a query to determine if the record is within the radius">
		<!--- Arguments [JLB]--->
		<cfargument name="lat"    type="string" required="yes" hint="">
		<cfargument name="lon"    type="string" required="yes" hint="">
		<cfargument name="radius" type="string" required="yes" hint="">
		<cfargument name="qData"  type="query"  required="yes" hint="">
		<!--- Declare local variables [JLB]--->
		<cfset var Instance = StructNew()>
		<!--- Logic [JLB]--->
			<cfset Instance.aDistance = ArrayNew(1)>
			<cfset Instance.aInRadius = ArrayNew(1)>
			<cfloop query="Arguments.qData">
				<cfset Instance.Distance = Distance(Arguments.qData.Lat,Arguments.qData.Lon,Arguments.Lat,Arguments.Lon)>
				<cfif Instance.Distance LTE Arguments.Radius>
					<cfset Instance.InRadius = 1>
				<cfelse>
					<cfset Instance.InRadius = 0>
				</cfif>
				<cfset Instance.aDistance = ArrayAppend(Instance.aDistance,Instance.Distance)>
				<cfset Instance.aInRadius = ArrayAppend(Instance.aInRadius,Instance.Radius)>
			</cfloop>
			<cfset Arguments.qData = QueryAddColumn(Arguments.qData,"GEO_Distance",Instance.aDistance)>
			<cfset Arguments.qData = QueryAddColumn(Arguments.qData,"GEO_InRadius",Instance.aInRadius)>
		<!--- Return [JLB]--->
		<cfreturn/>
	</cffunction>
	
	<cffunction name="deg2rad" access="private" output="no" returntype="any" hint="This function converts decimal degrees to radians">
		<!--- Arguments [JLB]--->
		<cfargument name="deg" type="string" required="yes" hint="">
		<!--- Declare Local Variables [JLB]--->
		<cfset var myReturn = 0>
		<!--- Logic [JLB]--->
		<cfset myReturn = Arguments.Deg * pi() / 180>
		<!--- Return [JLB]--->
		<cfreturn myReturn/>
	</cffunction>
	
	<cffunction name="rad2deg" access="private" output="no" returntype="any" hint="This function converts radians to decimal degrees">
		<!--- Arguments [JLB]--->
		<cfargument name="rad" type="string" required="yes" hint="">
		<!--- Declare Local Variables [JLB]--->
		<cfset var myReturn = 0>
		<!--- Logic [JLB]--->
		<cfset myReturn = Arguments.Rad * 180 / pi()>
		<!--- Return [JLB]--->
		<cfreturn myReturn/>
	</cffunction>

	<cffunction name="GeocodeUS" access="public" description="Geocodes an address" output="no" returntype="struct">
		<!---
		PLEASE NOTE:
		In order to use this service for commercial use you should sign up an account at http://geocoder.us/
		Once you have an username and password you just need to enter them in below.
		--->
		<!--- Arguments --->
		<cfargument name="Address"		required="yes" type="string">
		<cfargument name="proxyServer"	required="no"  type="string">
		<cfargument name="proxyPort"	required="no"  type="numeric">
		<!--- Declare local variables --->
		<cfset Instance = StructNew()>
		<!--- Set the username and password for the service --->
		<cfset Instance.Username = "">
		<cfset Instance.Password = "">
		<!--- Logic --->
			<cfif IsDefined("Arguments.ProxyServer")>
				<cfinvoke 
					webservice = "http://#Instance.Username#:#Instance.Password#@geocoder.us/dist/eg/clients/GeoCoder.wsdl" 
					method="geocode_address"
					proxyServer = "#Arguments.proxyServer#"
					proxyPort = "#Arguments.proxyPort#"
					returnVariable = "Instance.GeoCode_Results">
			<cfelse>
				<!--- Make sure that the GeoCoder Web Service Object is created --->
				<cfif NOT IsDefined("Variables.GeoCoder")>
					<cfset Variables.GeoCoder = createObject("webservice","http://#Instance.Username#:#Instance.Password#@geocoder.us/dist/eg/clients/GeoCoder.wsdl")> 		
				</cfif>
				<!--- Geocode the address --->
				<cfset Instance.GeoCode_Results	= Variables.GeoCoder.geocode_address(Arguments.Address)> 
			</cfif>
			<!--- Set the variables to a structure --->
			<cfscript>
			Instance.sReturn					= StructNew();
			Instance.sReturn.Longitude			= Instance.GeoCode_Results[1].get_Long();
			Instance.sReturn.Latitude			= Instance.GeoCode_Results[1].getLat();
			</cfscript>
		<!--- Return --->
		<cfreturn Instance.sReturn/>
	</cffunction>

	<cffunction name="Geocode" access="public" returntype="struct" hint="sends data to google, and returns lat/long" output="false">
		<!---
		Thanks to Jeff Gladnick for providing the base code for the following function (http://www.jeffgladnick.com)
		--->
		<!--- Arguments --->
		<cfargument name="fullAddress"	type="string"	required="false" default=""  hint="full address string bypassing the arguments">
		<cfargument name="address1"	    type="string"	required="false" default=""  hint="street address line 1">
		<cfargument name="address2"	    type="string"	required="false" default=""  hint="street address line 2">
		<cfargument name="city"			type="string"	required="false" default=""  hint="city">
		<cfargument name="state"		type="string"	required="false" default=""  hint="state">
		<cfargument name="postalCode"	type="string"	required="false" default=""  hint="postal code">
		<cfargument name="countryCode"	type="string"	required="false" default=""  hint="the country code that we use to look up the states for">
		<cfargument name="googleMapKey" type="string"	required="false" default=""  hint="your google map key for your site">
		<cfargument name="attempt"		type="numeric"	required="false" default="1" hint="number of times we've tried to find a code">
		<!--- Declare local variables --->
		<cfset var instance = structNew()>
		<cfset var cfhttp	= structNew()>
		<!--- Logic --->
			<!--- Create address string based on what attempt this is --->
			<cfif len(arguments.fullAddress)>
				<cfset instance.addressString = arguments.fulladdress>
			<cfelse>
				<cfif arguments.attempt IS 1>
				    <cfset instance.addressString = "#arguments.address1# #arguments.address2#, #arguments.city#, #arguments.state# #arguments.postalCode# #arguments.countryCode#">
				<cfelseif arguments.attempt IS 2>
				    <cfset instance.addressString = "#arguments.address1#, #arguments.City#, #arguments.State# #arguments.postalCode# #arguments.countryCode#">
				<cfelseif arguments.attempt IS 3>
				    <cfset instance.addressString = "#arguments.address1#, #arguments.City#, #arguments.State# #arguments.countryCode#">
				<cfelseif arguments.attempt IS 4>
				    <cfset instance.addressString = "#arguments.City#, #arguments.State# #arguments.countryCode#">
				<cfelseif arguments.attempt IS 5>
				    <cfset instance.addressString = "#arguments.City#, #arguments.countryCode#">
				<cfelse>
				    <cfset instance.addressString = "#arguments.countryCode#">
				</cfif>
			</cfif>
			
			<!--- replace all spaces with + sign because thats the way google geocoder likes it --->
			<cfset instance.addressString = replace(instance.addressString," ","+","all")>
	        <!--- send geocoder request to google --->
	        <cfhttp method="get" url="http://maps.google.com/maps/geo?q=#instance.addressString#&output=xml&key=#arguments.googleMapKey#" resolveurl="no" ></cfhttp>
	            
	        <cftry>
	            <!--- parse the xml file that is returned --->   
	            <cfset instance.xmlFile = xmlparse(cfhttp.filecontent)>   
	            <!--- extract the lat long coordinates out of the xml file --->
	            <cfset instance.locationList = instance.xmlFile.kml.response.placemark.point.coordinates.XmlText>
				
				<cfcatch type="any">
	                <!--- recall the geocode function with less accurate coordinates --->
					<cfset arguments.attempt = arguments.attempt + 1>
	                <cfif NOT len(arguments.fullAddress)>
						<cfset instance.sReturn  = Geocode(argumentCollection=arguments)>
					</cfif>
	            </cfcatch>
	        </cftry>
	        
	            
	        
	        <cfset instance.sReturn = structNew()>
	        <cfset instance.sReturn.hasGeocode = false>
	        <cfif isDefined("instance.locationList")>
				<cfif listLen(instance.locationList) GTE 2>
					<cfset instance.sReturn.hasGeocode	= true>
	        		<cfset instance.sReturn.Lon			= listGetAt(instance.locationList,1)>
					<cfset instance.sReturn.Lat			= listGetAt(instance.locationList,2)>
					<cfset instance.sReturn.Accuracy	= arguments.attempt>
				</cfif>
			</cfif>
		<!--- return --->
		<cfreturn instance.sReturn/>
	</cffunction>

</cfcomponent>