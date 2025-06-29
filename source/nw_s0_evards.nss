#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    effect eAOE = EffectAreaOfEffect(AOE_PER_EVARDS_BLACK_TENTACLES ,"nw_s0_evardsa", "nw_s0_evardsc");
    int nDuration = MothGetCasterLevel(OBJECT_SELF) / 2;
    int nMetaMagic = GetMetaMagicFeat();
    location lTarget = GetSpellTargetLocation();

    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }

    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF, lTarget, SHAPE_SPHERE, 5.0))
    {
        FloatingTextStringOnCreature("<cðþþ>*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}



