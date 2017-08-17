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
	<h1>Example 5 - Directions</h1>
	<p><a href="documentation.htm">Documentation</a> | <a href="source.cfm?source=5">View Source</a></p>
	<div style="width:500px;">
		<p>
			If you pass an address into a gm:googlemappoint and no custom content then it will automatically
			use the address to create a form to be used for the directions. If you want to use custom content
			and have the address form all you need to do is have [directions] in your custom content and it will 
			replace the [directions] with the directions form.
		</p>
		<gm:googlemap width="500" height="300" key="#Application.GoogleMapKey#" maptype="map">
			<gm:googlemappoint title="Bashas" address="4321 E. Baseline Rd Gilbert AZ 85234" lon="-111.74065589904785" lat="33.37874175794131">
					This is my custom content for the<br/>
					popup. You can place almost anything<br/>
					in here except a single quote. You need<br/>
					to make sure that anything you put in <br/>
					here is XHTML compliant.<br/>
					[directions]
			</gm:googlemappoint>
		</gm:googlemap>
	</div>
	<gm:googlemapshow>
</body>
</html>