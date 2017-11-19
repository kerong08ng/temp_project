data = LOAD '$filePath' USING org.apache.pig.piggybank.storage.CSVExcelStorage() as (
Year: int,  
Quarter: int, 
Month: int,
DayOfMonth: int,
DayOfWeek: int,
FlightDate: chararray,
UniqueCarrier: chararray, 
AirlineID: chararray, /*airline ID assigned by US DOT*/
Carrier: chararray, /*code assigned by IATA to identify carrier*/
TailNum: chararray,          /* unique ID to an aircraft */
FlightNum: chararray,     /* unique ID to a flight*/
OriginAirportID: int,  /*Unique ID to an airport*/
OriginAirportSeqID: int, 
OriginCityMarketID: int,
Origin: chararray,
OriginCityName: chararray,
OriginStateABR: chararray,
OriginStateFips: int,
OriginStateName: chararray,
OriginWorldAreaCode: int,
DestAirportID: int,
DestAirportSeqID: int,
DestCityMarketID: int,
Dest: chararray,
DestCityName: chararray,
DestStateABR: chararray,
DestStateFips: int,
DestStateName: chararray,
DestWorldAreaCode: int,
CRSDeptTime: int,
DepTime: int,
DepDelay: int,
DepDelayMinutes: int,
DepDel15: int,
DepartureDelayGroups: int,
DepTimeBlk: chararray,
TaxiOut: int,
WheelsOff: int,
WheelsOn: int,
TexiIn: int,
CRSarrTime: int,
ArrTime: int,
ArrDelay: int,
ArrDelayMinutes: int,
ArrDel15: int,
ArrivalDelayGroups: int,
ArrTimeBlk: chararray,
Cancelled: int,
CancellationCode: chararray,
Diverted: int,
CRSElapsedTime: double,
ActualElapsedTime: double,
AirTime: double,
Flights: int,
Distance: int, 
DistanceGroup: int,
CarrierDelay: int,
WeatherDelay: int,
NASDelay: int,
SecurityDelay: int,
LateAircraftDelay: int
);

p_data = FOREACH data GENERATE $groupBy,
								 $independentVariable as x, 
								 $dependentVariable as y,
						         $independentVariable * $independentVariable as x_2,
						         $dependentVariable * $dependentVariable as y_2,
						         $dependentVariable * $independentVariable as x_y;


p_data_group = GROUP p_data BY $groupBy;



aggregated_data        = FOREACH p_data_group GENERATE group,
                                         COUNT(p_data) as n,
                                         SUM( p_data.x) as sum_x,
                                         SUM( p_data.y) as sum_y,
                                         SUM( p_data.x_2) as sum_x_2,
                                         SUM( p_data.y_2) as sum_y_2,
                                         SUM( p_data.x_y) as sum_x_y;



pearson_corr        = FOREACH aggregated_data GENERATE group,
							 ((n * sum_x_y - sum_x * sum_y)/ 
							 SQRT((n * sum_x_2 - sum_x*sum_x)
							     *(n * sum_y_2 - sum_y*sum_y))) as r;
DUMP pearson_corr;