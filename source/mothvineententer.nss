#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    effect eHold = EffectEntangle();
    effect eEntangle = EffectVisualEffect(VFX_DUR_ENTANGLE);
    effect eLink = EffectLinkEffects(eHold, eEntangle);
    object oTarget;
    int bValid;
    oTarget = GetEnteringObject();
    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget))
        {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, 529));
                if(!GetHasSpellEffect(SPELL_ENTANGLE, oTarget))
                {
                if(!MyResistSpell(oCaster, oTarget))
                {
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_NONE,oCaster))
                {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
               }
             }
           }
        }
    }
}
