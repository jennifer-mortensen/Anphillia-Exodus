#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
    int nDuration = MothGetCasterLevel(OBJECT_SELF)/3;
    RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);
    RemoveEffectsFromSpell(oTarget, SPELL_GREATER_STONESKIN);
    RemoveEffectsFromSpell(oTarget, SPELL_FREEDOM_OF_MOVEMENT);
    RemoveEffectsFromSpell(oTarget, 580);
    RemoveEffectsFromSpell(oTarget, SPELL_PREMONITION);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    if(!MyResistSpell(OBJECT_SELF, oTarget))
    {
       MothPetrify(OBJECT_SELF,oTarget,nDuration,GetSpellId(),MothDC(),SAVING_THROW_WILL);
    }
}
