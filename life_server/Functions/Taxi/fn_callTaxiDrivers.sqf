// Get Parameters

_player = [_this, 0, objNull] call BIS_fnc_param;

// Exceptions

if (_player == objNull) exitWith {};
if (isNil "TaxiDriversOnDuty") then { TaxiDriversOnDuty = []; };
if (isNil "TaxiCalls") then { TaxiCalls = []; };

// Code

if (count TaxiDriversOnDuty == 0) exitWith { [[4],"life_fnc_taxi_respond",_player,false] spawn life_fnc_mp; };

TaxiCalls = TaxiCalls + [_player];

{ [[1,TaxiCalls],"life_fnc_taxi_respond",_x,false] spawn life_fnc_mp; } forEach TaxiDriversOnDuty; // call Taxidrivers

[_player] spawn {
	_player = _this select 0;
	sleep 30;
	if (_player in TaxiCalls) then {
		TaxiCalls = TaxiCalls - [_player];
		[[3],"life_fnc_taxi_respond",_player,false] spawn life_fnc_mp;
		{ [[1,TaxiCalls],"life_fnc_taxi_respond",_x,false] spawn life_fnc_mp; } forEach TaxiDriversOnDuty;
	};
};