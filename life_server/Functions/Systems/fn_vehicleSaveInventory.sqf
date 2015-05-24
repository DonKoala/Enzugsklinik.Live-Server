/*
File: fn_vehicleStore.sqf
Author: Bryan "Tonic" Boardwine
Description:
Stores the vehicle in the 'Garage'
*/
private["_vehicle","_impound","_vInfo","_vInfo","_plate","_uid","_query","_sql","_unit", "_trunk"];
_vehicle = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_impound = [_this,1,false,[true]] call BIS_fnc_param;
_unit = [_this,2,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _vehicle OR isNull _unit) exitWith {life_impound_inuse = false; (owner _unit) publicVariableClient "life_impound_inuse";life_garage_store = false;(owner _unit) publicVariableClient "life_garage_store";}; //Bad data passed.
_vInfo = _vehicle getVariable["dbInfo",[]];
if(count _vInfo > 0) then
{
_plate = _vInfo select 1;
_uid = _vInfo select 0;
};
//Load trunk ##55
_trunk = _vehicle getVariable["Trunk",[]];
//Format trunk to correct array ##55
_trunk = format["""%1""", str _trunk];
if(_impound) then
{
if(count _vInfo == 0) then
{
//deleteVehicle _vehicle;
}
else
{
_query = format["UPDATE vehicles SET inventory='%3' WHERE pid='%1' AND plate='%2'",_uid,_plate,_trunk];
_sql = "Arma2Net.Unmanaged" callExtension format ["Arma2NETMySQLCommand ['%2', '%1']", _query,(call LIFE_SCHEMA_NAME)];
//deleteVehicle _vehicle;
};
}
else
{
if(count _vInfo == 0) exitWith
{
[[1,"This vehicle isn't a persistent vehicle."],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
};
/*if(_uid != getPlayerUID _unit) exitWith
{
[[1,"Das Fahrzeug gehört dir nicht und kann deshalb nicht eingelagert werden."],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
life_garage_store = false;
(owner _unit) publicVariableClient "life_garage_store";
};*/
_query = format["UPDATE vehicles SET inventory='%3' WHERE pid='%1' AND plate='%2'",_uid,_plate,_trunk];
_sql = "Arma2Net.Unmanaged" callExtension format ["Arma2NETMySQLCommand ['%2', '%1']", _query,(call LIFE_SCHEMA_NAME)];
//[[1,"Das Fahrzeug wurde in deiner Garage eingelagert."],"life_fnc_broadcast",(owner _unit),false] spawn life_fnc_MP;
};