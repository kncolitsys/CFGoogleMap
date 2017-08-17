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
<cfif ThisTag.ExecutionMode IS "end">
	<cfsilent>
		<!--- Param the attributes -------------------------------------------->
			<!--- Google Maps License Key: Get key at http://www.google.com/apis/maps/signup.html --->
			<cfparam name="Attributes.Key" default="">
			<!--- Map Width [JLB]--->
			<cfparam name="Attributes.Width" default="600">
			<!--- Map Height [JLB]--->
			<cfparam name="Attributes.Height" default="450">
			<!--- Use default CSS for info box [JLB] --->
			<cfparam name="Attributes.DefaultCSS" default="true" type="boolean">
			<!--- Map Control Type [JLB]--->
			<cfparam name="Attributes.ControlType" default="large">
			<!--- Default Map Type [JLB] --->
			<cfparam name="Attributes.MapType" default="map">
			<!--- Fit points to Map --->
			<cfparam name="Attributes.fitPointsToMap" default="false">
			<!--- Map not compatible error message [JLB]--->
			<cfparam name="Attributes.BrowserNotCompatible" default="We're sorry but your browser is not compatible with Google Maps">
			<!--- Default Zoom Level [JLB] --->
			<cfparam name="Attributes.Level" default="12">
			<cfparam name="Attributes.CenterLon" default="">
			<cfparam name="Attributes.CenterLat" default="">
			<!--- Style information for the div container --->
			<cfparam name="Attributes.Style" default="">
			<cfparam name="Attributes.OverviewMap" default="false">
			<!--- Overview Map --->
			<cfparam name="OverviewMap" default="false">
			<cfparam name="OvervieMapWidth" default="200">
			<cfparam name="OvervieMapHeight" default="200">
			<!--- Traffic --->
			<cfparam name="Attributes.showTraffic" default="false" type="boolean">
			<!--- Local Search --->
			<cfparam name="Attributes.showLocalSearch" default="false" type="boolean">
			<!--- Language --->
			<cfparam name="attributes.language" default="en" type="string">
			<!--- Map Zoom Scrolling --->
			<cfparam name="attributes.enableZoomScroll" default="true" type="boolean">
			<!--- Google Earth --->
			<cfparam name="attributes.enableGE" default="false" type="boolean">
		<!--- Validate the attributes ----------------------------------------->
			<!--- Make sure that there is a license [JLB]--->	
			<cfif NOT Len(Attributes.Key)>
				<cfthrow type="CF_GoogleMap" detail="You do not have a key defined. You can sign up for a key at http://www.google.com/apis/maps/signup.html">
			</cfif>
			<!--- Make sure that the Control Type is valid [JLB]--->
			<cfif NOT ListFindNoCase("Large,Small",Attributes.ControlType)>
				<cfthrow type="CF_GoogleMap" detail="You must pass in Large or Small for the ControlType attribute value">
			</cfif>
			<!--- Make sure that the Map Type is valid [JLB] --->
			<cfif NOT ListFindNoCase("MAP,HYBRID,SATELLITE",Attributes.MapType)>
				<cfthrow type="CF_GoogleMap" detail="You must pass in MAP, HYBRID or SATELLITE for the MapType attribute value">
			</cfif>
			<!--- Make sure that  it has an end tag [JLB] --->
			<cfif NOT ThisTag.HasEndTag>
				<cfabort showerror="Implementation error: CF_GoogleMap must have an end tag.">
			</cfif>
			
		<!--- Insert some content into the head of the document --------------->
		<cfif NOT StructKeyExists(Request,"CF_GoogleMapInited")>
			<cfoutput>
				<!--- Generate the content [JLB]--->
				<cfsavecontent variable="Variables.HeadContent">
					<cfif IsDefined("Variables.ThisTag.Lines")><style type="text/css">v\:* {behavior:url(##default##VML);}</style></cfif>
					<cfif Attributes.DefaultCSS IS true><style type="text/css">.GM_InfoWindow {font-family:Verdana,Arial;font-size:12px;color:##000000;}</style></cfif>
					<script type="text/javascript">
					function GM_createMarker(point,pointname,propHTML,iconname,pointdraggable)
						{
						var marker = new GMarker(point,{icon:iconname,draggable:pointdraggable});
						var html = propHTML;
						/* Show this marker's index in the info window when it is clicked */
						GEvent.addListener(marker, "click", function() { marker.openInfoWindowHtml(propHTML); });
						<cfif IsDefined("attributes.dragStart") OR IsDefined("attributes.dragEnd")>GEvent.addListener(marker, "dragstart", function(){map.closeInfoWindow();gll=marker.getPoint();lon=gll.lng();lat=gll.lat();<cfif IsDefined("attributes.DragStart")>#attributes.dragStart#</cfif>;});</cfif>
						<cfif IsDefined("attributes.dragEnd")>GEvent.addListener(marker, "dragend", function(){gll = marker.getPoint();lon = gll.lng();lat = gll.lat();#attributes.dragEnd#;});</cfif>
						return marker;
						}
					function GM_viewProperty(x,y,markerName)
						{
						/* close the info window if it is open */
						map.closeInfoWindow()
						<!--- // Show map blowup
							var mypoint = new GPoint(x,y)
							map.showMapBlowup(mypoint) [JLB] --->
						/* Standard Zoom and Center */
							var mypoint		= new GLatLng(y,x);
							var mymarker	= eval(markerName);
							var myhtml		= eval(markerName + '_HTML');
							map.setCenter(mypoint,12);
							mymarker.openInfoWindowHtml(myhtml);
						<!--- // Anchor the window to the top of the map 
						window.location = '##CF_GoogleMap'; [JLB] --->
						}
					function GM_clearMap()
						{
						map.clearOverlays();
						}
					</script>
					<script src="http://maps.google.com/maps?file=api&v=2&key=#Attributes.Key#&hl=#attributes.language#" type="text/javascript"></script>
					<cfif Attributes.showLocalSearch IS true>
						<script src="http://www.google.com/uds/api?file=uds.js&v=1.0&key=#Attributes.Key#&hl=#attributes.language#" type="text/javascript"></script>
						<script src="http://www.google.com/uds/solutions/localsearch/gmlocalsearch.js" type="text/javascript"></script>
						<style type="text/css">
						@import url("http://www.google.com/uds/css/gsearch.css");
						@import url("http://www.google.com/uds/solutions/localsearch/gmlocalsearch.css");
						</style>
					</cfif>
				</cfsavecontent>
				<cfset variables.HeadContent =  Replace(variables.headContent,"				","","ALL")>
				<!--- Place the content in the head [JLB]--->
				<cfhtmlhead text="#Variables.HeadContent#">
			</cfoutput>
			<cfset Request.CF_GoogleMapInited = true>
		</cfif>
		<cfset Variables.InstanceMapName = "CF_GoogleMap" & RandRange(0,9999)>
	</cfsilent>
	<cfset ThisTag.GeneratedContent = "">
	<cfsetting enablecfoutputonly="yes">
	<!--- Make sure that there are some points to map ------------------------->
	<cfif NOT StructKeyExists(Variables.ThisTag,"Locations")>
		<cfset Variables.ThisTag.Locations = ArrayNew(1)>
	</cfif>
	
	<!--- Find the main point [JLB] --->
	<cfset variables.hasmainpoint = false>
	<cfset variables.setDefaultMainPoint = false>
	<cfif ArrayLen(Variables.ThisTag.Locations) IS 1>
		<cfset variables.sMainPoint = Duplicate(Variables.ThisTag.Locations[1])>
		<cfset variables.setDefaultMainPoint = true>
		<cfif IsDefined("variables.sMainPoint.MainPoint")>
			<cfif variables.sMainPoint.MainPoint IS false>
				<cfset variables.setDefaultMainPoint = false>
				<cfset structDelete(variables,"sMainPoint")>
			</cfif>
		</cfif>
		<cfif variables.setDefaultMainPoint IS true>
			<cfset variables.hasmainpoint = true>
			<cfif NOT Len(Attributes.CenterLon) AND NOT Len(Attributes.CenterLat)>
				<cfset Attributes.CenterLon = Variables.sMainPoint.Lon>
				<cfset Attributes.CenterLat = Variables.sMainPoint.Lat>
			</cfif>
		</cfif>
	<cfelse>
		<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Locations)#" index="i">
			<cfset variables.sTempPonts = StructNew()>
			<cfset variables.sTempPonts = Duplicate(Variables.ThisTag.Locations[i])>
			<cfif variables.sTempPonts.MainPoint IS true>
				<cfset variables.sMainPoint = Duplicate(Variables.ThisTag.Locations[i])>
				<cfset variables.hasmainpoint = true>
				<cfif NOT Len(Attributes.CenterLon) AND NOT Len(Attributes.CenterLat)>
					<cfset Attributes.CenterLon = Variables.sMainPoint.Lon>
					<cfset Attributes.CenterLat = Variables.sMainPoint.Lat>
				</cfif>
				<cfbreak>
			</cfif>
		</cfloop>
	</cfif>
	
	
	<!--- Center Point Defaults ----------------------------------------------->
	<cfif (NOT Len(Attributes.CenterLon)) AND (NOT Len(Attributes.CenterLat)) AND (ArrayLen(Variables.ThisTag.Locations) GT 0)>
		<!--- Find the center point [JLB] --->
		<cfif ArrayLen(Variables.ThisTag.Locations) IS 1>
			<!--- There is only 1 point so center on it [JLB] --->
			<cfset Attributes.CenterLon = Variables.ThisTag.Locations[1].Lon>
			<cfset Attributes.CenterLat = Variables.ThisTag.Locations[1].Lat>
		<cfelse>
			<!--- There are multiple points, check for the center attribute [JLB] --->
			<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Locations)#" index="i">
				<cfset Variables.TempStruct = Variables.ThisTag.Locations[i]>
				<cfif IsDefined("Variables.TempStruct.Center")>
					<cfset Attributes.CenterLon = Variables.ThisTag.Locations[i].Lon>
					<cfset Attributes.CenterLat = Variables.ThisTag.Locations[i].Lat>
					<cfbreak>
				</cfif>
			</cfloop>
			<!---
			There were no center points passed in. Try and calculate the center
			point of all of the points passed in.
			
			**************** 
			this does not seem to work worth beans....
			**************** 
			--->
			<cfif NOT Len(Attributes.CenterLon) AND NOT Len(Attributes.CenterLat)>
				<cfset Variables.aLon = ArrayNew(1)>
				<cfset Variables.aLat = ArrayNew(1)>
				<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Locations)#" index="i">
					<cfset Variables.aLonList = ArrayAppend(Variables.aLon,Variables.ThisTag.Locations[i].Lon)>
					<cfset Variables.aLatList = ArrayAppend(Variables.aLat,Variables.ThisTag.Locations[i].Lat)>
				</cfloop>
				<cfset Attributes.CenterLon = ArrayAvg(Variables.aLon)>
				<cfset Attributes.CenterLat = ArrayAvg(Variables.aLat)>
			</cfif>
		</cfif>
	</cfif>
	
	<!--- No center points at all. Center the map in the middle of the US [JLB] --->
	<cfif (NOT Len(Attributes.CenterLon)) AND (NOT Len(Attributes.CenterLat))>
		<cfset Attributes.CenterLon = "-98.7451171875">
		<cfset Attributes.CenterLat = "40.1452892956766">
	</cfif>
	
	<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Locations)#" index="i">
		<!--- Replace the [directions] in the content with actual directions functionality [JLB] --->
		<cfset variables.searchstring = "[directions]">
		<cfset variables.nDirectionsPos = FindNoCase(variables.searchstring,Variables.ThisTag.Locations[i].Content,1)>
		<cfif variables.nDirectionsPos GT 0>
			<cfsavecontent variable="variables.diectioncontent"><cfoutput><br /><form action="http://maps.google.com/maps" target="_blank" method="get">Your Address:<br /><input type="text" SIZE="40" MAXLENGTH="255" name="saddr" id="saddr" value="" /><br><INPUT ID="SUBMIT" TYPE="SUBMIT" VALUE="Get directions to here." class="form-button" style="width:175px"><input type="hidden" name="daddr" value="<cfif Variables.ThisTag.Locations[i].UseAddress IS "yes">#Variables.ThisTag.Locations[i].Address#(#Variables.ThisTag.Locations[i].Title#)<cfelse>#Variables.ThisTag.Locations[i].Lat#,#Variables.ThisTag.Locations[i].Lon#(#Variables.ThisTag.Locations[i].Title#)</cfif>" /><input type="hidden" name="hl" value="en" /></form></cfoutput></cfsavecontent>
			<cfset Variables.ThisTag.Locations[i].Content = ReplaceNoCase(Variables.ThisTag.Locations[i].content,variables.searchstring,variables.diectioncontent,"ALL")>
		</cfif>
		<!--- Replace [directions-to] if there is a main point [JLB] --->
		<cfif variables.hasmainpoint is true>
			<!--- Replace the [directions-to] in the content with actual directions functionality [JLB] --->
			<cfset variables.searchstring = "[directions-to]">
			<cfset variables.nDirectionsPos = FindNoCase(variables.searchstring,Variables.ThisTag.Locations[i].Content,1)>
			<cfif variables.nDirectionsPos GT 0>
				<cfsavecontent variable="variables.diectiontocontent"><cfoutput><a target="_blank" href="http://maps.google.com/maps?saddr=#Variables.sMainPoint.Address#&daddr=<cfif Variables.ThisTag.Locations[i].UseAddress IS "yes">#Variables.ThisTag.Locations[i].Address#(#Variables.ThisTag.Locations[i].Title#)<cfelse>#Variables.ThisTag.Locations[i].Lat#,#Variables.ThisTag.Locations[i].Lon#(#Variables.ThisTag.Locations[i].Title#)</cfif>&h1=en">To Here</a></cfoutput></cfsavecontent>
				<cfset variables.content = ReplaceNoCase(Variables.ThisTag.Locations[i].content,variables.searchstring,variables.diectiontocontent,"ALL")>
			</cfif>
			<cfif IsDefined("Variables.Content")>
				<cfset Variables.ThisTag.Locations[i].Content = Variables.Content>
			</cfif>
		</cfif>
		<cfif variables.hasmainpoint is true>
			<!--- Replace the [directions-from] in the content with actual directions functionality [JLB] --->
			<cfset variables.searchstring = "[directions-from]">
			<cfset variables.nDirectionsPos = FindNoCase(variables.searchstring,Variables.ThisTag.Locations[i].Content,1)>
			<cfif variables.nDirectionsPos GT 0>
				<cfsavecontent variable="variables.diectiontocontent"><cfoutput><a target="_blank" href="http://maps.google.com/maps?daddr=#Variables.sMainPoint.Address#&saddr=<cfif Variables.ThisTag.Locations[i].UseAddress IS "yes">#Variables.ThisTag.Locations[i].Address#(#Variables.ThisTag.Locations[i].Title#)<cfelse>#Variables.ThisTag.Locations[i].Lat#,#Variables.ThisTag.Locations[i].Lon#(#Variables.ThisTag.Locations[i].Title#)</cfif>&h1=en">From Here</a></cfoutput></cfsavecontent>
				<cfset variables.content = ReplaceNoCase(Variables.ThisTag.Locations[i].content,variables.searchstring,variables.diectiontocontent,"ALL")>
			</cfif>
			<cfif IsDefined("Variables.Content")>
				<cfset Variables.ThisTag.Locations[i].Content = Variables.Content>
			</cfif>
		</cfif>
		<!--- Remove all charage returns [JLB] --->
		<cfset Variables.ThisTag.Locations[i].Content = StripCR(Variables.ThisTag.Locations[i].Content)>
		<!--- Remove all tabs and charage returns [JLB] --->
		<cfset Variables.ThisTag.Locations[i].Content = Replace(Variables.ThisTag.Locations[i].Content,CHR(9),"","ALL")>
		<cfset Variables.ThisTag.Locations[i].Content = Replace(Variables.ThisTag.Locations[i].Content,CHR(10),"","ALL")>
		<cfset Variables.ThisTag.Locations[i].Content = Replace(Variables.ThisTag.Locations[i].Content,CHR(13),"","ALL")>
		<cfset Variables.ThisTag.Locations[i].Content = '<div class="GM_InfoWndow">' & Variables.ThisTag.Locations[i].Content & "</div>">
	</cfloop>
	
	<!--- Output the map DIV container ---------------------------------------->
<cfoutput>
<script type="text/javascript">
/* Check to see if the browser is compatible */
if(GBrowserIsCompatible())
	{
	document.write("<a name=CF_GoogleMap></a><div id=#Variables.InstanceMapName# style='width:#Attributes.Width#px;height:#Attributes.Height#px;#attributes.style#'></div>");
	}
else
	{
	document.write("#Attributes.BrowserNotCompatible#");
	}
</script></cfoutput>
	
	<!--- Output map points --------------------------------------------------->
	<cfsavecontent variable="Request.JSData">
		<cfoutput>
			<script type="text/javascript">
			//<![CDATA[
			function GM_Load()
				{
				
				map = new GMap2(document.getElementById("#Variables.InstanceMapName#"));
				<!--- var markers = new Array(#ArrayLen(Variables.ThisTag.Locations)#); ---> 
				
				/* Map Controls */
				<cfif Attributes.ControlType IS "large">
					map.addControl(new GLargeMapControl());
				<cfelse>
					map.addControl(new GSmallMapControl());
				</cfif>
				map.addControl(new GMapTypeControl());
				<cfif attributes.enableGE IS true>
					map.addMapType(G_SATELLITE_3D_MAP);
				</cfif>
				<!--- /* Set the default map type */
				map.setMapType(G_#UCASE(Attributes.MapType)#_TYPE); --->
				/* Center the map for initial load */
				var center = new GLatLng(#Attributes.CenterLat#,#Attributes.CenterLon#);
				map.setCenter(center,#Attributes.Level#);
				<cfif Attributes.OverviewMap IS true>
					map.addControl(new GOverviewMapControl(new GSize(#Attributes.OverviewMapWidth#,#Attributes.OverviewMapHeight#)));
				</cfif>
				<cfif IsDefined("Variables.ThisTag.Icons")>
					<cfset "Variables.#Variables.InstanceMapName#.aIcons" = ArrayNew(1)>
					<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Icons)#" index="i">
						var gmIcon_#Variables.ThisTag.Icons[i].IconName#				= new GIcon();
						gmIcon_#Variables.ThisTag.Icons[i].IconName#.image				= "#Variables.ThisTag.Icons[i].iconurl#";
						gmIcon_#Variables.ThisTag.Icons[i].IconName#.iconSize			= new GSize(#Variables.ThisTag.Icons[i].Width#,#Variables.ThisTag.Icons[i].Height#);
						gmIcon_#Variables.ThisTag.Icons[i].IconName#.iconAnchor 		= new GPoint(#Variables.ThisTag.Icons[i].IconAnchor#);
						gmIcon_#Variables.ThisTag.Icons[i].IconName#.infoWindowAnchor	= new GPoint(#Variables.ThisTag.Icons[i].infoWindowAnchor#);
					</cfloop>
				</cfif>
				<!--- Traffic --->
				<cfif attributes.showTraffic IS true>
					var trafficInfo = new GTrafficOverlay();
					map.addOverlay(trafficInfo);
				</cfif>
				<!--- Local Search --->
				<cfif Attributes.showLocalSearch IS true>
					var lsc = new google.maps.LocalSearch(); 
					map.addControl(new google.maps.LocalSearch());
				</cfif>
				<cfif attributes.enableZoomScroll IS true>
					map.enableScrollWheelZoom();
				</cfif>
				<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Locations)#" index="i">
					<cfsilent>
						<!--- Set the name for the first point. (Used only if there is only 1 location on the map) [JLB] --->
						<cfif NOT IsDefined("Variables.FirstPointName")>
							<cfset Variables.FirstPointName = Variables.ThisTag.Locations[i].PointName>
						</cfif>
						<!--- Set the default point variables --->
						<cfif NOT IsDefined("variables.ne.lat")>
							<cfset variables.ne.lat = variables.thisTag.locations[i].lat>
							<cfset variables.ne.lon = variables.thisTag.locations[i].lon>
							<cfset variables.sw.lat = variables.ne.lat>
							<cfset variables.sw.lon = variables.ne.lon>
						</cfif>
						<cfif variables.thisTag.locations[i].lat GT variables.ne.lat>
							<cfset variables.ne.lat = variables.thisTag.locations[i].lat>
						</cfif>
						<cfif variables.thisTag.locations[i].lon GT variables.ne.lon>
							<cfset variables.ne.lon = variables.thisTag.locations[i].lon>
						</cfif>
						<cfif variables.thisTag.locations[i].lat LT variables.sw.lat>
							<cfset variables.sw.lat = variables.thisTag.locations[i].lat>
						</cfif>
						<cfif variables.thisTag.locations[i].lon LT variables.sw.lon>
							<cfset variables.sw.lon = variables.thisTag.locations[i].lon>
						</cfif>
					</cfsilent>
					var point = new GLatLng(#Variables.ThisTag.Locations[i].Lat#,#Variables.ThisTag.Locations[i].Lon#);
					#Variables.ThisTag.Locations[i].PointName#_HTML = '#Variables.ThisTag.Locations[i].Content#';
					#Variables.ThisTag.Locations[i].PointName# = GM_createMarker(point,'#Variables.ThisTag.Locations[i].PointName#',#Variables.ThisTag.Locations[i].PointName#_HTML,<cfif Len(Variables.ThisTag.Locations[i].IconName)>gmIcon_#Variables.ThisTag.Locations[i].IconName#<cfelse>''</cfif>,#Variables.ThisTag.Locations[i].Draggable#);
					<cfif len(Variables.ThisTag.Locations[i].callJavaScript)>
						GEvent.addListener(#Variables.ThisTag.Locations[i].PointName#, 'click', function() 
							{
							onGmapBubbleClick('#Variables.ThisTag.Locations[i].callJavaScript#');
							});
					</cfif>
					<cfif Variables.ThisTag.Locations[i].Show IS true>
						map.addOverlay(#Variables.ThisTag.Locations[i].PointName#);
					</cfif>
				</cfloop>
				
				<cfif Attributes.fitPointsToMap IS true>
					var fitBounds = new GLatLngBounds(new GLatLng(#variables.sw.lat#,#variables.sw.lon#), new GLatLng(#variables.ne.lat#,#variables.ne.lon#));
					var zoomLevel = map.getBoundsZoomLevel(fitBounds);
					var newCenter = fitBounds.getCenter();
					map.setCenter(newCenter,zoomLevel,map.getCurrentMapType());
				</cfif>
				
				<cfif IsDefined("Variables.ThisTag.Lines")>
					<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Lines)#" index="i">
						var polyline#i# = new GPolyline([<cfloop from="1" to="#ArrayLen(Variables.ThisTag.Lines[i].Locations)#" index="ii">new GLatLng(#Variables.ThisTag.Lines[i].Locations[ii].Lat#,#Variables.ThisTag.Lines[i].Locations[ii].Lon#)<cfif ii LT ArrayLen(Variables.ThisTag.Lines[i].Locations)>,</cfif></cfloop>],'#Variables.ThisTag.Lines[i].Color#',#Variables.ThisTag.Lines[i].Size#,#Variables.ThisTag.Lines[i].Opacity#);
						map.addOverlay(polyline#i#); 
					</cfloop>
				</cfif>
				}			
			
			/* Load the map */
			window.load = GM_Load();
			<cfif variables.hasmainpoint IS true>
				window.load = GM_viewProperty(#variables.sMainPoint.Lat#,#variables.sMainPoint.Lon#,'#variables.sMainPoint.PointName#');
			</cfif>
			//]]>
			</script>
		</cfoutput>
	</cfsavecontent>
	<cfsetting enablecfoutputonly="no">
</cfif>