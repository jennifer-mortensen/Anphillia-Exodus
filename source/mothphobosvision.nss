void main()
{
object oPC = GetPCSpeaker();
object oTarget;
oTarget = OBJECT_SELF;
effect eEffect;
eEffect = EffectSeeInvisible();
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);
}

