void main()
{
object oPC = GetPCSpeaker();
object oTarget;
oTarget = GetObjectByTag("mothdiscdoor1");
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_KNOCK),oTarget);
SetLocked(oTarget, FALSE);
}
