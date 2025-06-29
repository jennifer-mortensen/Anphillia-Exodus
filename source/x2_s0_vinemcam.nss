#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eAOE = EffectAreaOfEffect(40);
    location lTarget = GetSpellTargetLocation();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = (MothGetCasterLevel(OBJECT_SELF)/2);
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;
    }
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,6.0))
    {
     FloatingTextStringOnCreature("<c >*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}

