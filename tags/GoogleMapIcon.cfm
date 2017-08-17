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
	Please note that you need to declare your icons before you start using the icon name later in a point
	--->
	<cfif ThisTag.ExecutionMode IS "start">
		<!--- correct tag usage checks --->
		<cfif NOT ListFindNoCase(GetBaseTagList(),"cf_googlemap")>
			<cfabort showerror="Implementation error: CF_GoogleMapPoint must be nested inside a CF_GoogleMap tag pair.">
		</cfif>
		<cfif NOT IsDefined("Attributes.IconURL")>
			<cfabort showerror="Implementation error: CF_GoogleIcon requires that you pass a the full URL of the icon via the IconURL attribute.">
		</cfif>
		<cfif NOT IsDefined("Attributes.IconName")>
			<cfabort showerror="Implementation error: CF_GoogleIcon requires that you pass a name for the icon to be used later when calling it via the IconName attribute.">
		</cfif>
		<cfif NOT IsDefined("Attributes.Width")>
			<cfabort showerror="Implementation error: CF_GoogleIcon requires that you pass a name for the icon to be used later when calling it via the points.">
		</cfif>
		<cfif NOT IsDefined("Attributes.Height")>
			<cfabort showerror="Implementation error: CF_GoogleIcon requires that you pass a name for the icon to be used later when calling it via the points.">
		</cfif>
		<cfif NOT IsDefined("Attributes.IconAnchor")>
			<cfset Attributes.IconAnchor = "#Round(Attributes.Width/2)#,#Round(Attributes.Height/2)#">
		</cfif>
		<cfif NOT IsDefined("Attributes.infoWindowAnchor")>
			<cfset Attributes.infoWindowAnchor = "#(Attributes.Width/2)#,2">
		</cfif>
		<cfassociate basetag="cf_googlemap" datacollection="icons">
	</cfif>
</cfsilent>