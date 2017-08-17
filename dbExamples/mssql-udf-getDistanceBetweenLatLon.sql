CREATE FUNCTION [dbo].[getDistanceBetweenLatLon]
(
	@lat1 decimal(5,2),
	@long1 decimal(5,2),
	@lat2 decimal(5,2),
	@long2 decimal(5,2)
)
RETURNS NUMERIC( 10, 5 )
AS
BEGIN
      DECLARE @x decimal(20,10)
      DECLARE @pi decimal(21,20)
      SET @pi = 3.14159265358979323846
      SET @x = sin( @lat1 * @pi/180 ) * sin( @lat2 * @pi/180  ) + cos(@lat1 *@pi/180 ) * cos( @lat2 * @pi/180 ) * cos( abs( (@long2 * @pi/180) - (@long1 *@pi/180) ) )
      SET @x = atan( ( sqrt( 1- power( @x, 2 ) ) ) / @x )
      RETURN abs(( 1.852 * 60.0 * ((@x/@pi)*180) ) / 1.609344)
END