#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nLevel = MothGetCasterLevel(oCaster);
    effect eVis = EffectVisualEffect(VFX_IMP_BREACH);
    effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL_GREATER);
    object oTarget;
    if(nLevel >17)
    {
        nLevel = 17;
    }
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
     if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
       {
       SignalEvent(oTarget, EventSpellCastAt(oCaster, 68));
       spellsDispelMagic(oTarget, nLevel, eVis, eImpact);
       }
       oTarget = GetNextInPersistentObject();
    }
}
