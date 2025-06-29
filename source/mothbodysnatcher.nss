//Snatches bodies to prevent exploit of my perecption triggers.
//Reads both Tag and Resref to be sure they can't carry an "inactive" body.
//This script could be used around some of your exotic mining places Julian :-P.
/*
void main()
{
object oPC = GetEnteringObject();
string sTag;
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "PlayerCorpse")== OBJECT_INVALID)
   return;
object oItem;
sTag = GetTag (oItem);
oItem = GetItemPossessedBy(oPC, "PlayerCorpse");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
SendMessageToPC(oPC, "A body has vanished from your backpack!");
if (sTag == "PlayerCorpse")
    {
     DestroyObject(oItem);
    }
SendMessageToPC(oPC, "A body has vanished from your backpack!");
}
