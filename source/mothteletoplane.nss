void main()
{
object oPC = GetLastClosedBy();
object oMod = GetModule();

//Make sure it only works once per PC.
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE)return;
//Jump max four-five seperate PC's then destroy the waypoint, depeding on load time.
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
int nInt;
nInt = GetLocalInt(oMod, "mothbemfas1");
nInt += 1;
SetLocalInt(oMod, "mothbemfas1", nInt);
object oTarget;
location lTarget;
//Make sure they always have a way home, no matter the outcome.
oTarget = GetWaypointByTag("mothtoplane");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
AssignCommand(oPC, ActionJumpToLocation(lTarget));
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HARM), GetLocation(oPC));
DelayCommand(2.1,PlaySound("as_mg_telepout1"));
DelayCommand(2.2,PlaySound("as_mg_telepout1"));
DelayCommand(2.3,PlaySound("sco_lgrinelec01"));
DelayCommand(3.0,ActionOpenDoor(OBJECT_SELF));
nInt=GetLocalInt(oMod, "mothbemfas1");
if (nInt == 5)
   {
   DestroyObject(oTarget, 1.0);
   }
if (nInt >= 6)
   {
   DelayCommand(1.2,PlaySound("sce_negative"));
   DelayCommand(1.1,PlaySound("sce_negative"));
   DelayCommand(1.3,PlaySound("sce_negative"));
   DelayCommand(1.9,FloatingTextStringOnCreature("Oh no, it's out of power!",oPC));
   }
}
