#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eAOE = EffectAreaOfEffect(AOE_PER_DELAY_BLAST_FIREBALL);
    location lTarget = GetSpellTargetLocation();
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = MothGetCasterLevel(OBJECT_SELF) / 2;
    if(GetAppearanceType(OBJECT_SELF) == 1032||
      GetAppearanceType(OBJECT_SELF) == 1033)
    {
        nDuration/5;
    }
    if (nDuration == 0)
    {
        nDuration = 1;
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;
    }
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,2.0))
    {
     FloatingTextStringOnCreature("<cþ¥ >*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    }
}


