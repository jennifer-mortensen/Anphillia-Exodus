#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int nDamage;
    object oCaster = GetAreaOfEffectCreator();
    int nDuration = GetLevelByClass(CLASS_TYPE_RANGER,oCaster)+10;
    effect eDam;
    object oTarget;
    int nSave = nDuration;
    effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    oTarget = GetEnteringObject();
    if(!MothGetIsFortAlly(oTarget,oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(oCaster, 336));
        nDamage = d4(nDuration);
        nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDuration, SAVING_THROW_TYPE_TRAP);
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
        if(nDamage > 0)
          {
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
           ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
          }
        DestroyObject(OBJECT_SELF);
    }
}
