#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if (!MothDecreaseOnHitSpellChancePC())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    if (nCasterLevel <= 29)
    {
        nCasterLevel = 5;
    }
    else
    {
        nCasterLevel = 15;
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 416));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC()) == FALSE)
        {
            effect eBad = EffectAttackDecrease(nCasterLevel);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBad, oTarget, RoundsToSeconds(nCasterLevel));
        }
    }
}


