_taxiDriver = _this select 0;
_target = _this select 1;

TaxiCalls = TaxiCalls - [_target];
{ [[1,TaxiCalls],"life_fnc_taxi_respond",_x,false] spawn life_fnc_mp; } forEach TaxiDriversOnDuty; // call Taxidrivers
TaxiDriversOnDuty = TaxiDriversOnDuty - [_taxiDriver];