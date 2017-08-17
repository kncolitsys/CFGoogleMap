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
</head>
<body onunload="GUnload()">
	<h1>Example 3 - Drawing Lines on the Map</h1>
	<p><a href="documentation.htm">Documentation</a> | <a href="source.cfm?source=3">View Source</a></p>
	<div>
		<gm:googlemap width="500" height="300" key="#Application.GoogleMapKey#" maptype="map">
			<gm:googlemapline>
				<gm:googlemappoint lon="-111.75361633300781" lat="33.39346933101665">
				<gm:googlemappoint lon="-111.7196273803711" lat="33.39375597435129">
				<gm:googlemappoint lon="-111.72185897827148" lat="33.364943593285545">
				<gm:googlemappoint lon="-111.75636291503906" lat="33.36422674571036">
				<gm:googlemappoint lon="-111.75361633300781" lat="33.39346933101665">
			</gm:googlemapline>
			<gm:googlemappoint title="Bashas" address="4321 E. Baseline Rd Gilbert AZ 85234" lon="-111.74065589904785" lat="33.37874175794131">
		</gm:googlemap>
	</div>
	<gm:googlemapshow>
</body>
</html>