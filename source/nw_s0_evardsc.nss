#include "X0_I0_SPELLS"

void main()
{
    object oCaster = GetAreaOfEffectCreator();

    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }

    object oTarget;
    effect eVis = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eParalyze = EffectParalyze();
    effect eLink = EffectLinkEffects(eVis, eParalyze);
    float fDelay;
    int nCasterLevel = MothGetCasterLevel(oCaster);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    int nTentacles;
    int nTentaclesTotal = d4();
    int nTentaclesMaxPerTarget;
    int i;

    if(nCasterLevel > 20)
    {
        nTentaclesTotal += 20 + ((nCasterLevel - 20) / 3);
    }
    else
    {
        nTentaclesTotal += nCasterLevel;
    }

    nTentaclesMaxPerTarget = nTentaclesTotal / 3; //No more than one third of the tentacles will hit a target.

    oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget) && nTentaclesTotal > 0)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster, oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_EVARDS_BLACK_TENTACLES));
            if(nTentaclesTotal >= nTentaclesMaxPerTarget)
            {
                nTentacles = nTentaclesMaxPerTarget;
            }
            else
            {
                nTentacles = nTentaclesTotal;
            }
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
            nTentaclesTotal -= nTentacles;
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    }
}
