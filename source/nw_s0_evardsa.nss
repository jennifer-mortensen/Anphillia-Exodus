#include "X0_I0_SPELLS"

void main()
{
    object oCaster = GetAreaOfEffectCreator();
    object oTarget = GetEnteringObject();;
    effect eVis = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eParalyze = EffectParalyze();
    effect eLink = EffectLinkEffects(eVis, eParalyze);
    float fDelay;
    int nCasterLevel = MothGetCasterLevel(oCaster);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    int nTentacles = d4();
    int i;

    if(nCasterLevel > 20)
    {
        nTentacles += 20 + ((nCasterLevel - 20) / 3);
    }
    else
    {
        nTentacles += nCasterLevel;
    }

    nTentacles /= 3; //No more than one third of the tentacles will hit a target.

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster, oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_EVARDS_BLACK_TENTACLES));
        for(i = 0; i < nTentacles; i++)
        {
            if(nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 10;
            }
            else
            {
                nDamage = d6() + 4;
                if(nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage / 2);
                }
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_TWO), oTarget);
        }
        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothFogDC(), SAVING_THROW_TYPE_NONE, oCaster))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
        }
    }
}
