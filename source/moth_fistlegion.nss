#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "moth_inc_bigby"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLevel/2 - 5;
    int nLos = 1;
    effect eDam;
    effect eMeteor1 = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eMeteor2 = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
    effect eMeteor3 = EffectVisualEffect(VFX_IMP_PULSE_HOLY);
    effect eMeteor4 = EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE);
    effect eMeteor = EffectLinkEffects(eMeteor1,eMeteor2);
    eMeteor = EffectLinkEffects(eMeteor,eMeteor3);
    eMeteor = EffectLinkEffects(eMeteor,eMeteor4);
    effect eVis = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eVis2 = EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST);
    effect eDaze = EffectDazed();
    float nRadius = RADIUS_SIZE_COLOSSAL + 4.0;
    location lLocation = GetSpellTargetLocation();
    float fDelay1 = GetDistanceBetweenLocations(lLocation, GetLocation(OBJECT_SELF))/20;
    TLVFXPillar(VFX_FNF_WORD,lLocation, 1, fDelay1, 0.1f, 1.5f);
    TLVFXPillar(VFX_FNF_PWSTUN,lLocation, 1, fDelay1, 0.1f, 1.5f);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lLocation);
    //MothDoFist(lLocation);
    float fDelay;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nRadius, lLocation, nLos, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGetIsFortAlly(oTarget))
        {
            fDelay = 1.6;
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
              {
                 nDamage = d3(nCasterLevel) + (nBonus) /2;
                 if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF, fDelay))
                 {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDaze, oTarget, RoundsToSeconds(nBonus)));
                    nDamage = nDamage*2;
                 }
                 if(nDamage > 0)
                 {
                  eDam = EffectDamage(nDamage+5, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_THREE);
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                  DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                  DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, 1.0));
                  DelayCommand(0.1, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis2, GetLocation(oTarget), 1.0));
                 }
               }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, nRadius, lLocation, nLos, OBJECT_TYPE_CREATURE);
    }
}

