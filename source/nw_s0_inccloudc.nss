#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    effect eDam;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fDelay;
    int nDuration = MothGetCasterLevel(oCaster,SPELL_INCENDIARY_CLOUD);
    if (nDuration > 21)
    {
       nDuration = 21;
    }
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    oTarget = GetFirstInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster))
        {
            fDelay = GetRandomDelay(0.5, 2.0);
            if(!MyResistSpell(oCaster, oTarget, fDelay))
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_INCENDIARY_CLOUD));
                nDamage = d6(nDuration);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                   nDamage = 6 * nDuration;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2);
                }
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothFogDC(),SAVING_THROW_TYPE_FIRE, oCaster);
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if(nDamage > 0)
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF,OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
