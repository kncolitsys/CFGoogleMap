CREATE FUNCTION [dbo].[getDistanceBetweenZipCodes]
(
      @zip1 char(5),
      @zip2 char(5)
)
RETURNS NUMERIC( 10, 5 )
AS
BEGIN
      DECLARE @x decimal(20,10)
      DECLARE @pi decimal(21,20)
      DECLARE @lat1 decimal(5,2)
      DECLARE @long1 decimal(5,2)
      DECLARE @lat2 decimal(5,2)
      DECLARE @long2 decimal(5,2)

      SET @long1 = (select LONGITUDE FROM dbo.ZIPCODES where ZIPCODE = @zip1)
      SET @lat1 = (select LATITUDE FROM dbo.ZIPCODES where ZIPCODE = @zip1)
      SET @long2 = (select LONGITUDE FROM dbo.ZIPCODES where ZIPCODE = @zip2)
      SET @lat2 = (select LATITUDE FROM dbo.ZIPCODES where ZIPCODE = @zip2)
      SET @pi = 3.14159265358979323846
      SET @x = sin( @lat1 * @pi/180 ) * sin( @lat2 * @pi/180  ) + cos(@lat1 *@pi/180 ) * cos( @lat2 * @pi/180 ) * cos( abs( (@long2 * @pi/180) - (@long1 *@pi/180) ) )
      SET @x = atan( ( sqrt( 1- power( @x, 2 ) ) ) / @x )
      RETURN abs(( 1.852 * 60.0 * ((@x/@pi)*180) ) / 1.609344)
END