<!---
CF_GoogleMap
Date Created: 7/28/2005

--------------------------------------------------------------------------------

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. 
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS"
BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing
permissions and limitations under the License.

--->
<cfif NOT isDefined("URL.googleMapKey")>
	<cfthrow type="CF_GoogleMap - Proxy" detail="You must pass in the googleMapKey into the proxy.">
</cfif>
<cfparam name="variables.proxyServer" default="">
<cfparam name="variables.proxyPort"   default="">
<cftry>
	<cfif NOT isDefined("application.cfGoogleMap.JSCache")>
		<cfif len(variables.proxyServer)>
			<cfhttp url="http://maps.google.com/maps?file=api&v=2&key=#url.googleMapKey#" method="get" proxyserver="#variables.proxyServer#" proxyport="#variables.proxyPort#"></cfhttp>
		<cfelse>
			<cfhttp url="http://maps.google.com/maps?file=api&v=2&key=#url.googleMapKey#" method="get"></cfhttp>
		</cfif>
		<cfset application.cfGoogleMap.JSCache = cfhttp.fileContent>
	</cfif>
	<cfoutput>#application.cfGoogleMap.JSCache#</cfoutput>
	<cfcatch>alert('Could not load the Google Maps API');</cfcatch>
</cftry>