void main()
{
object oPC = GetPCSpeaker();
object oMod = GetModule();
object oTarget;
object oStone1 = GetObjectByTag("mothdustskip1b");
object oStone2 = GetObjectByTag("mothdustskip2b");
object oStone3 = GetObjectByTag("mothdustskip3b");
object oStone4 = GetObjectByTag("mothdustskip4b");
location lTarget;
oTarget = GetWaypointByTag("mothskip12");
lTarget = GetLocation(oTarget);
if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
AssignCommand(oPC, ClearAllActions());
DelayCommand(4.5, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
oTarget = oPC;
//second event
int nInt;
nInt = GetLocalInt(oMod, "mothdisc1");
nInt += 1;
SetLocalInt(oMod, "mothdisc1", nInt);

ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), oTarget);
DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone1)));
DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone2)));
DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone3)));
DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), GetLocation(oStone4)));
}
