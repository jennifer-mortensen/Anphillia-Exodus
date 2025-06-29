#include "_inc_xp"

void main()
{

object oPC = GetPCSpeaker();
object oTarget;
object oMod = GetModule();
object oSpawn;
object oDead;
object oDead2;
object oItem;
location lTarget;

   oItem = GetItemPossessedBy(oPC, "mothphobosheart"); //J. Persinne; quick fix to ensure it's no longer possible to drop the cube (thereby being able to keep it).
   if(oItem == OBJECT_INVALID)
    return;

oDead = GetObjectByTag("Phobos2b");
oDead2 = GetObjectByTag("spawnphobos123");
   DestroyObject(oDead);
   DestroyObject(oDead2);
   oTarget = GetWaypointByTag("Phobos1");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "phoboscleaven", lTarget);
   oTarget = oSpawn;
   DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HOLY_AID), oSpawn));
   DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oSpawn));
   DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oSpawn));
   SendMessageToPC(oPC, " You insert the Golem Essence into the orb. This seems to be the final stage to awakening the slumbering golem. Only one way to be sure...");
   DestroyObject(oItem);
   DelayCommand(3.0,DestroyObject(OBJECT_SELF));
   GiveVirtualXPToCreature(oPC, 575);
object oTargetx;
location lTargetx;
oTargetx = GetWaypointByTag("phobosoverjump111");
lTargetx = GetLocation(oTargetx);
if (GetAreaFromLocation(lTargetx)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
DelayCommand(3.0, AssignCommand(oPC, ActionJumpToLocation(lTargetx)));
oTargetx = oPC;
int nInt;
nInt = GetObjectType(oTargetx);
if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), oTargetx);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_PWKILL), GetLocation(oTargetx));
}


