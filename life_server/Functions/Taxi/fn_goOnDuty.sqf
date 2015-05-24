_driver = _this select 0;
if (isNil "TaxiDriversOnDuty") then { TaxiDriversOnDuty = []; };
if (isNil "TaxiCalls") then { TaxiCalls = []; };
if !(_driver in TaxiDriversOnDuty) then {TaxiDriversOnDuty = TaxiDriversOnDuty + [_driver];};
[[1,TaxiCalls],"life_fnc_taxi_respond",_driver,false] spawn life_fnc_mp;