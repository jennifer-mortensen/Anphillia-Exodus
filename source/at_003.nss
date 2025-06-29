//::///////////////////////////////////////////////
//:: FileName at_003
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2003-10-05 22:56:07
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "PotionOfCLW");
	if(GetIsObjectValid(oItemToTake) != 0)
		ActionTakeItem(oItemToTake, GetPCSpeaker());
}
