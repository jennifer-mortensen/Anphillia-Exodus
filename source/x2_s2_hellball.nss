//Moonlight: altered to knockdown all friendlies except the caster.
#include "X0_I0_SPELLS"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
        {
            return;
        }
    int nDamage1, nDamage2, nDamage3, nDamage4, nDamage5;
    float fDelay;
    effect eExplode = EffectVisualEffect(464);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eVis2 = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eVis3 = EffectVisualEffect(VFX_IMP_SONIC);
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    effect eDam1, eDam2, eDam3, eDam4, eDam5, eDam6, eKnock;
    eKnock= EffectKnockdown();
    float fKnock = IntToFloat(nCasterLevel);
    fKnock = fKnock*0.1 + 1.0;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    int nTotalDamage;
    while (GetIsObjectValid(oTarget))
    {
         fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/30 + 0.5f;
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            nDamage1 = d6(9);
            nDamage2 = d6(9);
            nDamage3 = d6(9);
            nDamage4 = d6(9);
            nDamage5 = d6(9);
            nTotalDamage = nDamage1+nDamage2+nDamage3+nDamage4+nDamage5;
            eDam1 = EffectDamage(nDamage1, DAMAGE_TYPE_POSITIVE);
            eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_DIVINE);
            eDam3 = EffectDamage(nDamage3, DAMAGE_TYPE_NEGATIVE);
            eDam4 = EffectDamage(nDamage4, DAMAGE_TYPE_MAGICAL);
            eDam5 = EffectDamage(nDamage5, DAMAGE_TYPE_NEGATIVE);
            if(nTotalDamage > 0)
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam1, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam3, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam4, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam5, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay+0.2f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                DelayCommand(fDelay+0.5f, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget));
             }
        }
       if (oTarget != OBJECT_SELF)
       {
                    DelayCommand(fDelay+0.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget,fKnock));
       }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

