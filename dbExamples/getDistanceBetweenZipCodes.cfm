<!---
Exact Postal Match
+
Near Matches within 25 miles sorted by distance

This example goes off of the zip code to calculate the distance. You may want to use the other MSSQL UDF included to calculate the disance on your query.
--->
<cfset form.postalCode = 80111>

<cfquery datasource="myDatasource" name="variables.qInfo">
SELECT
	StoreName,
	Address,
	City,
	State,
	PostZip,
	dbo.getDistanceBetween('#form.postalCode#',PostZip) AS Distance
FROM
	myTable
WHERE
	isActive = 1
		AND
	PostZIP IN
		(
		SELECT ZipCode
		FROM ZipCodes
		WHERE
			zipcode <= '#form.postalCode + 50#'
				AND
			zipcode >= '#form.postalCode - 50#'
				AND
			dbo.getDistanceBetweenZipCodes('#form.postalCode#',zipcode) < 25
		)
ORDER BY
	Distance
</cfquery>

<cfdump var="#variables.qInfo#">