#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eAOE = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM);
    location lTarget = GetSpellTargetLocation();
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/5;
    effect eImpact = EffectVisualEffect(259);
    int nMetaMagic = GetMetaMagicFeat();
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;
    }
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,6.7))
    {
     FloatingTextStringOnCreature("<cڥ#>*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    PlaySound("sps_bugs");
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}


