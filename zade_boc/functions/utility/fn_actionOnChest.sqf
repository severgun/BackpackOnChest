params ["_player"];

private _backpack = backpack _player;
private _backpackitems = (itemCargo (backpackContainer _player) + weaponCargo (backpackContainer _player));
private _backpackmags = [_player] call zade_boc_fnc_backpackMagazines;

//remove all mags out of items to prevent adding mags two times
{
     for "_i" from 1 to (_x select 2) do {
          _backpackitems deleteAt (_backpackitems find (_x select 0));
     };
} forEach _backpackmags;

//handle attachments
{
     //remove weapon and add base wepaon
     _backpackitems deleteAt (_backpackitems find (_x select 0));
     _backpackitems pushBack ((_x select 0) call BIS_fnc_baseWeapon);

     //add attachments separately
     _backpackitems pushBack (_x select 1);
     _backpackitems pushBack (_x select 2);
     _backpackitems pushBack (_x select 3);
     _backpackitems pushBack (_x select 5);

     //add magazine
     private _mag = +(_x select 4);
     _mag pushBack 1;
     _backpackmags pushBack _mag;

} forEach weaponsItems (backpackContainer _player);

//add pack
[_player,_backpack] call zade_boc_fnc_addChestpack;

//add items
{
     [_player,_x] call zade_boc_fnc_addItemToChestpack;
} forEach _backpackitems;

//add magazines
{
     for "_i" from 1 to (_x select 2) do {
          [_player,(_x select 0),(_x select 1)] call zade_boc_fnc_addMagToChestpack;
     };
} forEach _backpackmags;

removeBackpackGlobal _player;
