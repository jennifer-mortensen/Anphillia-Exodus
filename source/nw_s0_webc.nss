#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{

    effect eWeb = EffectEntangle();
    object oCaster = GetAreaOfEffectCreator();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    object oTarget;
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && !MothGolemWalkImmunityMedium(oTarget))
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oCaster)  && !MothGetIsTargetMyPet(oCaster,oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_WEB));
                if(!MyResistSpell(oCaster, oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_TRAP,oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeb, oTarget, RoundsToSeconds(1));
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(1));
                    }
                }
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}
