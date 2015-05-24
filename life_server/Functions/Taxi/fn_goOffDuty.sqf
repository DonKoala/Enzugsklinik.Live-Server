_driver = _this select 0;
if (isNil "TaxiDriversOnDuty") then { TaxiDriversOnDuty = []; };
if (isNil "TaxiCalls") then { TaxiCalls = []; };
if (_driver in TaxiDriversOnDuty) then {TaxiDriversOnDuty = TaxiDriversOnDuty - [_driver];};