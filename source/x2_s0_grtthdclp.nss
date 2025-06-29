#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDC = MothDC();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    if (nCasterLvl > 25)
    {
         nCasterLvl = 25;
    }
    int nDamage = d4(nCasterLvl)+nMothBonus3;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    effect eVis  = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis2 = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eVis3 = EffectVisualEffect(VFX_IMP_STUN);
    effect eDeaf;
    effect eKnock = EffectKnockdown();
    effect eStun1 = EffectDeaf();
    effect eStun2 = EffectSilence();
    effect eStun = EffectLinkEffects(eStun1,eStun2);
    effect eShake = EffectVisualEffect(356);
    effect eImmune = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, 2.0f);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
       if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
       {
        if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_SONIC);
            eDeaf = EffectDamage(nDamage,DAMAGE_TYPE_SONIC);
            if(nDamage > 0)
            {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeaf, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(4)));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay+0.8, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmune, oTarget, RoundsToSeconds(4)));
            }
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SONIC))
            {
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, 6.0f));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis3, oTarget,4.0f));
            }
        }
       }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

