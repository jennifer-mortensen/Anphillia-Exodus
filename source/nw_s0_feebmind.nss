#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLvl/8;
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_WILL,1+nBonus,SAVING_THROW_TYPE_ALL);
    effect eVis = EffectVisualEffect(VFX_IMP_CONFUSION_S);
    int nMeta = GetMetaMagicFeat();
    int nDuration = nCasterLvl/4;
    if (nMeta == METAMAGIC_EXTEND)
       {
        nDuration = nDuration * 2;
       }
    if(!MothGetIsFortAlly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oTarget, RoundsToSeconds(nDuration));
        }
    }
}
