<!--- Right now this is not a runable sample but gives you some syntax on how to use the function --->
<cfset form.addressToGeocode = "3075 E. Merrill Ave, Gilbert, AZ, 85234">

<cfset variables.obj.geo = createObject("component","geo")>
<cfset variables.address = variables.obj.geo.geocode(fullAddress=form.addressToGeocode)>

<cfif variables.address.hasGeocode>
	<cfquery datasource="myDatasource" name="variables.qInfo">
	SELECT
		myTable.StoreName,
		myTable.Address,
		myTable.City,
		myTable.State,
		myTable.PostZip,
		myTable.Lat,
		myTable.Lon,
		dbo.getDistanceBetweenLatLon(myTable.Lat,myTable.Lon,'#variables.address.lat#','#variables.address.lon#') AS Distance
	FROM
		myTable
	ORDER BY
		Distance
	</cfquery>
	
	<cfdump var="#variables.qInfo#">
</cfif>
