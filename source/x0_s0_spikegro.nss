#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eAOE = EffectAreaOfEffect(AOE_PER_ENTANGLE, "x0_s0_spikegroEN", "x0_s0_spikegroHB", "x0_s0_dirgeEX");
    location lTarget = GetSpellTargetLocation();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/2;
    int nMetaMagic = GetMetaMagicFeat();
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;
    }
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE))
    {
     FloatingTextStringOnCreature("<c � >*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
     ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}


