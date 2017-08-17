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
	<script language="javascript" type="text/javascript">
	function saveChange(pointName,lat,lon)
		{
		document.myForm.pointName.value = pointName;
		document.myForm.latitude.value = lat;
		document.myForm.longitude.value = lon;
		}
	</script>
</head>
<body onunload="GUnload()">
	<h1>Example 7 - Draggable Points</h1>
	<p><a href="documentation.htm">Documentation</a> | <a href="source.cfm?source=7">View Source</a></p>
	<div style="width:700px;height:300px">
		<div style="width:500px;float:left;">
		<gm:googlemap width="500" height="300" key="#Application.GoogleMapKey#" maptype="map" dragend="saveChange(pointname,lat,lon);">
			<gm:googlemappoint title="Home" address="3075 E Merrill Ave Gilbert AZ 85234" lon="-111.72488451004028" lat="33.37397536669671" MainPoint="true" draggable="true">
			<gm:googlemappoint title="Bashas" address="4321 E. Baseline Rd Gilbert AZ 85234" lon="-111.74065589904785" lat="33.37874175794131" draggable="true">
		</gm:googlemap>
		</div>
		<div style="width:150px;float:right;">
			<form name="myForm">
				<table>
					<tr>
						<td nowrap="true">Point Name</td>
						<td><input type="text" name="pointName" value=""></td>
					</tr>
					<tr>
						<td>Latitude</td>
						<td><input type="text" name="latitude" value=""></td>
					</tr>
					<tr>
						<td>Longitude</td>
						<td><input type="text" name="longitude" value=""></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<gm:googlemapshow>
</body>
</html>