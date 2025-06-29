#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
#include "x2_inc_toollib"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    effect eFire;
    effect eMeteor = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eVis1 = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eVis2 = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    float nRadius = 32.0;
    location lLocation = GetLocation(OBJECT_SELF);
    if (nCasterLevel > 20)
    {
        nCasterLevel = (nCasterLevel-20)*2/3+20;
    }
    float fRandom1 = GetRandomDelay();
    float fRandom2 = GetRandomDelay();
    float fRandom3 = GetRandomDelay();
    float fRandom4 = GetRandomDelay();
    float fRandom5 = GetRandomDelay();
    location lTarget1 = GenerateNewLocationFromLocation(lLocation,5.0+fRandom1,0.0+fRandom1,10.0+fRandom1);
    location lTarget2 = GenerateNewLocationFromLocation(lLocation,5.0+fRandom2,75.0+fRandom2,75.0+fRandom2);
    location lTarget3 = GenerateNewLocationFromLocation(lLocation,5.0+fRandom3,150.0+fRandom3,150.0+fRandom3);
    location lTarget4 = GenerateNewLocationFromLocation(lLocation,5.0+fRandom4,175.0+fRandom4,175.0+fRandom4);
    location lTarget5 = GenerateNewLocationFromLocation(lLocation,5.0+fRandom5,250.0+fRandom5,250.0+fRandom5);
    DelayCommand(fRandom5,TLVFXPillar(VFX_IMP_LIGHTNING_M,lLocation,3,0.0f));
    DelayCommand(fRandom5,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lTarget1));
    DelayCommand(fRandom4,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lTarget2));
    DelayCommand(fRandom3,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lTarget3));
    DelayCommand(fRandom2,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lTarget4));
    DelayCommand(fRandom1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, lTarget5));
    float fDelay;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nRadius,lLocation);
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            fDelay = GetRandomDelay();
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(!MyResistSpell(OBJECT_SELF, oTarget, 0.5))
              {
                      nDamage = d6(nCasterLevel)+nMothBonus3;
                      nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(),SAVING_THROW_TYPE_ELECTRICITY);
                      eFire = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                      if(nDamage > 0)
                      {
                       DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                       DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                      }
               }
        }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, nRadius, lLocation);
    }
}

