// Creates a Epic items on its placeable.
// 2d100(10%chance) is a trigger for one of 20 items.
// Can only be triggered once per reboot.
// If the PC is below lvl 23 nothing happends but the trigger
// will set to used and the chest won't spawn anything until next reboot.
// If you find the items too powerful just remove the placeable.
// If you wanna add items you can do it here too, you will
// see the pattern of it all as you scroll down.


// Most of the items are CEP weapons which are all +4 or +5 and a damage bouns
// that never exceeds 1d4. Since none of the item-enhancing spells
// work on CEP weapons nor any weapon assoc. feats this should keep them fairly balanced.
// Some items will grant spot/listen, such as helemts. My reason is like this; when
// you hit 24+ lvl's you ALMOST always have access to GMW(15) and other weapon buff scrolls.
// On top all that there is only a 10% chance for a 24+ PC to acctually getting one of these
// items once per reboot and visit to Condor's Scream.
// I will place ALL my items including these under Custom/Tutorial. If you change them there
// they will of course be changed in this script aslong as the
// RESREF is the kept the same, not the TAG.
void main()
{
object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
if ((GetHitDice(oPC) <= 22))return;
int nInt;
nInt = d100(2);
if (nInt==21)
   {
   CreateItemOnObject("mothpcepicitem1", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==52)
   {
   CreateItemOnObject("mothpcepicitem2", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==53)
   {
   CreateItemOnObject("mothpcepicitem3", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==54)
   {
   CreateItemOnObject("mothpcepicitem4", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==55)
   {
   CreateItemOnObject("mothpcepicitem5", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==56)
   {
   CreateItemOnObject("mothpcepicitem6", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==57)
   {
   CreateItemOnObject("mothpcepicitem7", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==58)
   {
   CreateItemOnObject("mothpcepicitem8", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==59)
   {
   CreateItemOnObject("mothpcepicitem9", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==60)
   {
   CreateItemOnObject("mothpcepicitem10", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==61)
   {
   CreateItemOnObject("mothpcepicitem11", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==62)
   {
   CreateItemOnObject("mothpcepicitem12", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==63)
   {
   CreateItemOnObject("mothpcepicitem13", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==64)
   {
   CreateItemOnObject("mothpcepicitem14", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==65)
   {
   CreateItemOnObject("mothpcepicitem15", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==66)
   {
   CreateItemOnObject("mothpcepicitem16", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==67)
   {
   CreateItemOnObject("mothpcepicitem17", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==68)
   {
   CreateItemOnObject("mothpcepicitem18", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==69)
   {
   CreateItemOnObject("mothpcepicitem19", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==70)
   {
   CreateItemOnObject("mothpcepicitem20", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==71)
   {
   CreateItemOnObject("mothsummondeamon", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==72)
   {
   CreateItemOnObject("mothsummonbalrog", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt==73)
   {
   CreateItemOnObject("mothsummonbanshe", OBJECT_SELF);
   }
else
   {
   }
nInt = d100();
if (nInt>=74)
   {
   }
else
   {
   }
}

