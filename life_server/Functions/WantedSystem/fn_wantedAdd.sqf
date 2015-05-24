/*
	File: fn_wantedAdd.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Adds or appends a unit to the wanted list.
*/
private["_uid","_type","_index","_data","_crimes","_val","_customBounty","_name"];
_uid = [_this,0,"",[""]] call BIS_fnc_param;
_name = [_this,1,"",[""]] call BIS_fnc_param;
_type = [_this,2,"",[""]] call BIS_fnc_param;
_customBounty = [_this,3,-1,[0]] call BIS_fnc_param;
if(_uid == "" OR _type == "" OR _name == "") exitWith {}; //Bad data passed.

//What is the crime?
switch(_type) do
{
	case "1": {_type = ["Versuchter Autodiebstahl",5000]};
	case "2": {_type = ["Autodiebstahl",20000]};
	case "3": {_type = ["Überfall",50000]};
	case "4": {_type = ["Banküberfall",100000]}; 
	case "5": {_type = ["Drogenhandel/Konsum",100000]};
	case "6": {_type = ["Illegale Kleidung",50000]};
	case "7": {_type = ["Illegales Fahrzeug",150000]};
	case "8": {_type = ["Illegales Kart",70000]};
	case "9": {_type = ["Beleidigung",25000]};
	case "10": {_type = ["Körperverletzung",90000]};
	case "11": {_type = ["Mord",100000]};
	case "12": {_type = ["Versuchter Mord",150000]};
	case "13": {_type = ["Geiselnahme",100000]};
	case "14": {_type = ["St. Verfolgen",30000]};
	case "15": {_type = ["N. Befolgen P. Anweisung",15000]};
	case "16": {_type = ["Fahrerflucht",20000]};
	case "17": {_type = ["Beihilfe zur Flucht",7500]};
	case "18": {_type = ["Diebstahl eines Pol. Fahrzeuges",30000]};
	case "19": {_type = ["Bet. Pol. Sperrzone",5000]};
	
	case "20": {_type = ["Mit Licht an Parken",2500]};
    case "21": {_type = ["Mit Motor an Parken",5000]};
    case "22": {_type = ["Fahren ohne Licht",10000]};
    case "23": {_type = ["Fahren auf der Fal. Straßenseite",10000]};
    case "24": {_type = ["Gefährden von Zivs/Cops",18000]};
    case "25": {_type = ["Dauerhaftes Hupen",3000]};
    case "26": {_type = ["Fahren mit fahruntauglichem Fahrzeug",10000]};
    case "27": {_type = ["Illegales Straßenrennen",25000]};
    case "28": {_type = ["Alkohol am Steuer",10000]};
    case "29": {_type = ["Kein Verbandskasten/Toolkit", 3000]};
    case "30": {_type = ["Fliegen unterhalb von 150m",20000]};
    case "31": {_type = ["Landen in städten",30000]};
    case "32": {_type = ["Landen auf Straßen",20000]};
    case "33": {_type = ["Fliegen ohne Kollisionslicht",10000]};
    case "34": {_type = ["Kein Waffenschein",70000]};
    case "35": {_type = ["Keine Überlänge Genehmigung",5000]};
	
	
    case "36": {_type = ["Illegale Waffe",150000]};
    case "37": {_type = ["Belaestigung eines Polizisten",14000]};
    case "38": {_type = ["Betreten einer pol. Sperrzone",50000]};
    case "39": {_type = ["Toeten eines Polizisten",1234567]};
    case "40": {_type = ["Beschuss auf Polizei/Beamte/Eigentum",1234567]};
    case "41": {_type = ["Zerstoerung von Polizeieigentum",15000]};
    case "42": {_type = ["Drogendelikte",1234567]};
    case "43": {_type = ["Waffenbesitz ohne Lizenz",70000]};
    case "44": {_type = ["Mit gez. Waffe durch Stadt",50000]};
    case "45": {_type = ["Besitz einer illegalen Waffe",150000]};
    case "46": {_type = ["Abfeuern einer Waffe innerhalb einer Stadt",50000]};
    case "47": {_type = ["Geiselnahme",1234567]};
    case "48": {_type = ["Raubeuberfall",60000]};
    case "49": {_type = ["Bankraub",1234567]};
    case "50": {_type = ["Mord",1234567]};
    case "51": {_type = ["Aufstand",75000]};
    case "52": {_type = ["Angriff durch Rebellen",75000]};
    case "53": {_type = ["Angriff/Belagerung von Staedten/Checkpoints",1234567]};
    case "54": {_type = ["Landung in einer Flugverbotszone",75000]};
    case "55": {_type = ["Fliegen/Schweben unterhalb 150m ueber Stadt",20000]};
    case "56": {_type = ["Ausbruch aus dem Gefaengnis",1234567]};
    case "57": {_type = ["Fliegen ohne Fluglizenz",50000]};
    case "58": {_type = ["Dauerhaftes hupen",7500]};
    case "59": {_type = ["Handel mit exotischen Guetern",50000]};
	case "60": {_type = ["Umfahren eines Außenpostens",25000]};
	case "61": {_type = ["Kraftwerk manipulation",25000]};
	
	case "120S": {_type = ["Überhöhte Geschwindigkeit",5000]};
	case "120H": {_type = ["Zu Schnelles Fahren",8000]};
	case "120WL": {_type = ["Fahren ohne Führerschein",8000]};
	case "120FS": {_type = ["Gefährliche Fahrweise",8000]};
	default {_type = [];};
};

if(count _type == 0) exitWith {}; //Not our information being passed...
//Is there a custom bounty being sent? Set that as the pricing.
if(_customBounty != -1) then {_type set[1,_customBounty];};
//Search the wanted list to make sure they are not on it.
_index = [_uid,life_wanted_list] call TON_fnc_index;

if(_index != -1) then
{
	_data = life_wanted_list select _index;
	_crimes = _data select 2;
	_crimes pushBack (_type select 0);
	_val = _data select 3;
	life_wanted_list set[_index,[_name,_uid,_crimes,(_type select 1) + _val]];
}
	else
{
	life_wanted_list pushBack [_name,_uid,[(_type select 0)],(_type select 1)];
	diag_log format["WANTED_LIST = %1", life_wanted_list];

	_gesuchter = [life_wanted_list] call DB_fnc_mresArray;
	_query = format["UPDATE wanted set list = '%1'", _gesuchter];


	waitUntil {sleep (random 0.3); !DB_Async_Active};
	_queryResult = [_query,1] call DB_fnc_asyncCall;
};