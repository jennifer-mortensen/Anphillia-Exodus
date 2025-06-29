void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("nw_bugbearboss");

effect eEffect;
eEffect = EffectSeeInvisible();

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}
