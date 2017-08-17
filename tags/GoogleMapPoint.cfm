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
<cfsilent>
	<!--- 
	You can pass an optional attribute of center on a point to use this point as
	the center point of the map.
	--->
	<cfif Variables.ThisTag.ExecutionMode IS "start">
		<!--- Param the IconName attribute [JLB] --->
		<cfparam name="Attributes.IconName" default="">
		<!--- Param the Point Name [JLB] --->
		<cfparam name="Attributes.PointName" default="marker#ReplaceNoCase(CreateUUID(),'-','','ALL')#">
		<!--- Default to using the address for the driving directions [JLB] --->
		<cfparam name="Attributes.UseAddress" default="yes">
		<!--- Default to non draggable points --->
		<cfparam name="Attributes.Draggable" default="false">
		<!--- Default to show points --->
		<cfparam name="Attributes.Show" default="true">
		<!--- Default main point to false --->
		<cfparam name="Attributes.mainPoint" default="false">
		<!--- string of input parameters to send to the onGmapBubbleClick() javascript function.  Ie   "'bill', 'smith', 45, 2006" | Added by JCG 12/20/2006 to handle javascript events on marker click  --->
		<cfparam name="Attributes.callJavaScript" default="">

		<!--- correct tag usage checks --->
		<cfif NOT ListFindNoCase(GetBaseTagList(),"cf_googlemap")>
			<cfabort showerror="Implementation error: CF_GoogleMapPoint must be nested inside a CF_GoogleMap tag pair.">
		</cfif>
		<cfif NOT IsDefined("Attributes.Lat")>
			<cfabort showerror="Implementation error: CF_GoogleMapPoint requires that you pass a the latitude of the location via the LAT attribute.">
		</cfif>
		<cfif NOT IsDefined("Attributes.Lon")>
			<cfabort showerror="Implementation error: CF_GoogleMapPoint requires that you pass a the longitude of the location via the LON attribute.">
		</cfif>
		<!--- Title and Address are not required if the point is inside of the cf_googlemapline tag [JLB] --->
		<cfif NOT ListFindNoCase(GetBaseTagList(),"cf_googlemapline")>
			<cfif NOT IsDefined("Attributes.Title")>
				<cfabort showerror="Implementation error: CF_GoogleMapPoint requires that you pass a the title of the location via the TITLE attribute.">
			</cfif>
			<cfif NOT IsDefined("Attributes.Address")>
				<cfabort showerror="Implementation error: CF_GoogleMapPoint requires that you pass a the address of the location via the ADDRESS attribute.">
			</cfif>
		</cfif>
		<!--- Exit out of the tag if the lat and lon are not valid numbers --->
		<cfif NOT isNumeric(Attributes.Lat) OR NOT isNumeric(Attributes.Lon)>
			<cfexit method="exitTag">
		</cfif>
		<!--- shift this tag's attributes into the parent cf_googlemap tag --->
		<cfif ListFindNoCase(GetBaseTagList(),"cf_googlemapline")>
			<cfset Variables.Collection = "lines">
			<cfassociate basetag="cf_googlemapline" datacollection="lines.locations">
		<cfelse>
			<cfset Variables.Collection = "locations">
			<cfif Variables.ThisTag.HasEndTag IS false>
				<!--- Build the content in the window via the attributes passed [JLB] --->
				<cfsavecontent variable="attributes.content"><cfoutput><div class="GM_InfoWindow"><strong>#Attributes.Title#</strong><br />#Attributes.Address#<br/>[directions]</div></cfoutput></cfsavecontent>
				<cfassociate basetag="cf_googlemap" datacollection="locations">
			</cfif>
		</cfif>
	<cfelse>
		<cfif Variables.Collection IS "locations">
			<!--- Take the generated content and use it as the contents for the info window [JLB] --->
			<cfset variables.content = variables.thistag.generatedcontent>
			<!--- Zero out the generated content for this tag [JLB] --->
			<cfset variables.thistag.generatedcontent = "">
			<!--- Return the content to the main tag [JLB] --->
			<cfset attributes.content = variables.content>
			<cfassociate basetag="cf_googlemap" datacollection="locations">
		</cfif>
	</cfif>
</cfsilent>