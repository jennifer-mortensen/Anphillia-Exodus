#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage;
    float fDelay;
    effect eExplode;
    effect eExplode1 = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    effect eExplode2 = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eExplode3 = EffectVisualEffect(VFX_FNF_IMPLOSION);
    effect eExplode4 = EffectLinkEffects(eExplode1, eExplode2);
    eExplode = EffectLinkEffects(eExplode4, eExplode3);
    effect eVis1 = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eVis = EffectLinkEffects(eVis1, eVis2);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                    nDamage = d6(16)+16;
                    if (MySavingThrow(SAVING_THROW_REFLEX,oTarget,25,SAVING_THROW_TYPE_TRAP,OBJECT_SELF,fDelay) >0)
                    {
                        nDamage /=2;
                    }
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

