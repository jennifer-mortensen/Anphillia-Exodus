#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{

    effect eWeb = EffectSlow();
    object oCaster = GetAreaOfEffectCreator();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    object oTarget;
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGolemWalkImmunityMedium(oTarget))
        {
            if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster)  && !MothGetIsTargetMyPet(oCaster,oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_SPIKE_GROWTH));
                if(!MyResistSpell(oCaster, oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothFogDC(),SAVING_THROW_TYPE_TRAP,oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eWeb, oTarget, RoundsToSeconds(2));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}
