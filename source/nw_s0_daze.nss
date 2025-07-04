#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
    effect eDaze = EffectDazed();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDaze);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 2;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = 4;
    }
    if (AmIAHumanoid(oTarget) == TRUE)
    {
        if(GetHitDice(oTarget) <= 5)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DAZE));
               if (!MyResistSpell(OBJECT_SELF, oTarget))
               {
                    if (!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_MIND_SPELLS))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
            }
        }
    }
}
