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
	<cfif ThisTag.ExecutionMode IS "start">
		<!--- correct tag usage checks --->
		<cfif NOT ListFindNoCase(GetBaseTagList(),"cf_googlemap")>
			<cfabort showerror="Implementation error: CF_GoogleMapLine must be nested inside a CF_GoogleMap tag pair.">
		</cfif>
		<cfparam name="Attributes.Color"	default="##ff0000">
		<cfparam name="Attributes.Size"		default="4">
		<cfparam name="Attributes.Opacity"	default="0.5">
	<cfelse>
		<cfif NOT IsDefined("Variables.ThisTag.Lines.Locations") OR ArrayLen(Variables.ThisTag.Lines.Locations) LT 2>
			<cfabort showerror="Implementation error: CF_GoogleMapLine must contain at least 2 CF_GoogleMapPoint tags.">
		</cfif>
		<cfset Attributes.Locations = Variables.ThisTag.Lines.Locations>
		<cfassociate basetag="cf_googlemap" datacollection="lines">
	</cfif>
</cfsilent>