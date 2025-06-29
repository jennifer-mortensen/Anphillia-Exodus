void main()
{
object oPC = GetLastUsedBy();
object oTarget;
object oSpawn;
object oMod = GetModule();
location lTarget;
string sPC = GetName(oPC);
int nInt;
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "crystalofcosmicd")!= OBJECT_INVALID)
   {
   nInt = GetLocalInt(oMod, "mothstatue1");
   nInt += 1;
   SetLocalInt(oMod, "mothstatue1", nInt);
   DelayCommand(2.0,FloatingTextStringOnCreature("<cýõæ>"+sPC+" inserts the Crystal in the statue. The statue slowly descend into the floor.</c>",oPC));   DelayCommand(2.0,DestroyObject(OBJECT_SELF));
   DelayCommand(2.0,DestroyObject(OBJECT_SELF));
   DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), OBJECT_SELF));
   object oItem;
   oItem = GetItemPossessedBy(oPC, "crystalofcosmicd");
   if (GetIsObjectValid(oItem))
          DestroyObject(oItem);
   }
nInt=GetLocalInt(oMod, "mothstatue1");
if (nInt >= 7)
   {
   oTarget = GetWaypointByTag("mothstatueend");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "mothrodofagebag", lTarget);
   oTarget = oSpawn;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE), oTarget));
   else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_NATURES_BALANCE), GetLocation(oTarget)));
   }
}


