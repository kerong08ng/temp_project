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

REGISTER /home/thomas/workspace/learn_hadoop/project_data/src/flightNumFilter.jar;

criteria = FOREACH data GENERATE Month;
filtered = FILTER data BY FilteredFlightNumber(criteria.$0);
projectedData = FOREACH filtered GENERATE $groupBy, $independentVariable , $dependentVariable;
groupedData = GROUP projectedData by $groupBy;
correlation = FOREACH groupedData GENERATE group, SUM( projectedData.$independentVariable);
DUMP correlation;