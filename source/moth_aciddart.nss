#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTargetCone1;
    location lCaster = GetLocation(OBJECT_SELF);
    vector vOrigin1 = GetPosition(OBJECT_SELF);
    float fFacing = GetFacing(OBJECT_SELF);
    float fDelay;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nBonus = nCasterLvl;
    int nDamage;
    effect eDam;
    int nDamageType = DAMAGE_TYPE_ACID;
    int nVisual1 = VFX_COM_HIT_ACID;
    int nVisual2 = VFX_IMP_ACID_L;
    int nVisual3 = VFX_IMP_ACID_S;
    effect eHit = EffectVisualEffect(VFX_DUR_MIRV_ACID);
    effect eVis1 = EffectVisualEffect(nVisual1);
    effect eVis2 = EffectVisualEffect(nVisual2);
    effect eVis3 = EffectVisualEffect(nVisual3);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    location lStart = GetSpellTargetLocation();
    object oTarget2;
    object oTarget3;
    object oTarget4;
    object oTarget5;
    object oTarget6;
    int nTargetsHit;
    float fRange = GetDistanceBetweenLocations(lStart,lCaster)+0.1;
   /* float fSpread = fRange/1.5;
    location lStart1 = GenerateNewLocationFromLocation(lStart,fSpread,0.0,0.0);
    location lStart2 = GenerateNewLocationFromLocation(lStart,fSpread,fFacing - 25.0,0.0);
    location lStart3 = GenerateNewLocationFromLocation(lStart,fSpread,fFacing + 25.0,0.0);
    location lStart4 = GenerateNewLocationFromLocation(lStart,fSpread,fFacing - 55.0,0.0);
    location lStart5 = GenerateNewLocationFromLocation(lStart,fSpread,fFacing + 55.0,0.0);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eHit,lStart1,2.0);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eHit,lStart2,2.0);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eHit,lStart3,2.0);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eHit,lStart4,2.0);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eHit,lStart5,2.0); */
    //TargetCone1 = GetFirstObjectInShape(SHAPE_SPELLCONE,fRange, lStart, TRUE, OBJECT_TYPE_CREATURE, vOrigin1);
    oTargetCone1 = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lStart, TRUE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTargetCone1) && nTargetsHit < 3)
        {
          if(!MothGetIsFortAlly(oTargetCone1))
            {
              nTargetsHit++;
              nDamage = d2(nCasterLvl)+nBonus;
              if (nMetaMagic == METAMAGIC_MAXIMIZE)
                 {
                  nDamage = 2 * nCasterLvl+nBonus;
                 }
              else if (nMetaMagic == METAMAGIC_EMPOWER)
                 {
                  nDamage = nDamage + nDamage / 2;
                 }
              fDelay = GetDistanceBetweenLocations(lCaster, GetLocation(oTargetCone1))/22;
              SignalEvent(oTargetCone1, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
              if(MySavingThrow(SAVING_THROW_FORT, oTargetCone1, MothDC(), SAVING_THROW_TYPE_ACID, OBJECT_SELF, fDelay))
              {
                nDamage = nDamage-20;
              }
              if(!MyResistSpell(OBJECT_SELF, oTargetCone1))
              {
                eDam = EffectDamage(nDamage, nDamageType);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHit,oTargetCone1,1.5);
                DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTargetCone1));
                DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTargetCone1));
              }
             }
          oTargetCone1 = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lStart, TRUE, OBJECT_TYPE_CREATURE);
        }
}
