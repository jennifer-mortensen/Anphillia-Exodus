#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    location lCaster = GetLocation(OBJECT_SELF);
    vector vOrigin = GetPosition(OBJECT_SELF);
    float fDelay;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDamage;
    effect eDam;
    int nSpell = GetSpellId();
    int nRay;
    int nDamageType;
    int nVisual1;
    int nVisual2;
    int nSave;
    int nFirstTarget = 1;
    if(nSpell==588)
    {
       nRay = VFX_BEAM_COLD;
       nDamageType = DAMAGE_TYPE_COLD;
       nVisual1 = VFX_IMP_FROST_L;
       nVisual2 = VFX_IMP_FROST_S;
       nSave = SAVING_THROW_TYPE_COLD;
    }
    else if(nSpell==589)
    {
       nRay = VFX_BEAM_FIRE;
       nDamageType = DAMAGE_TYPE_FIRE;
       nVisual1 = VFX_IMP_FLAME_M;
       nVisual2 = VFX_IMP_FLAME_S;
       nSave = SAVING_THROW_TYPE_FIRE;
    }
    else if(nSpell==590)
    {
       nRay = VFX_BEAM_LIGHTNING;
       nDamageType = DAMAGE_TYPE_ELECTRICAL;
       nVisual1 = VFX_IMP_LIGHTNING_S;
       nVisual2 = VFX_IMP_LIGHTNING_S;
       nSave = SAVING_THROW_TYPE_ELECTRICITY;
    }
    effect eVis1 = EffectVisualEffect(nVisual1);
    effect eVis2 = EffectVisualEffect(nVisual2);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    effect eRay1 = EffectBeam(nRay, OBJECT_SELF, BODY_NODE_HAND);
    effect eRay2 = EffectBeam(nRay, OBJECT_SELF, BODY_NODE_HAND);
    object oTarget2 = GetSpellTargetObject();
    location lStart = GetSpellTargetLocation();
    if(GetIsObjectValid(oTarget2))
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay1, oTarget2, 1.3);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay2, oTarget2, 1.3);
    DelayCommand(1.5,RemoveSpellEffects(GetSpellId(),OBJECT_SELF,oTarget2));
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eRay1, lStart, 1.3);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eRay2, lStart, 1.3);
    DelayCommand(1.5,RemoveSpellEffects(GetSpellId(),OBJECT_SELF,OBJECT_SELF));
    }
    float fRange = GetDistanceBetweenLocations(lStart,lCaster) +2.0;
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, fRange, lStart, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, vOrigin);
    while(GetIsObjectValid(oTarget))
        {
          if(!MothGetIsFortAlly(oTarget))
            {
              nDamage = d3(nCasterLvl);
              if (nMetaMagic == METAMAGIC_MAXIMIZE)
                 {
                  nDamage = 3 * nCasterLvl;
                 }
              else if (nMetaMagic == METAMAGIC_EMPOWER)
                 {
                  nDamage = nDamage + nDamage / 2;
                 }
              fDelay = GetDistanceBetweenLocations(lStart, GetLocation(oTarget))/20;
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));
              if(MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), nSave, OBJECT_SELF, fDelay))
              {
                nDamage = nDamage-20;
              }
              //J. Persinne; secondary targets now take half damage.
              if (nFirstTarget >= 1)
                   nFirstTarget--;
              else
                   nDamage = nDamage / 2;
              if(!MyResistSpell(OBJECT_SELF, oTarget))
              {
                eDam = EffectDamage(nDamage, nDamageType);
                DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(1.5,RemoveSpellEffects(GetSpellId(),OBJECT_SELF,oTarget));
              }
             }
           DelayCommand(1.5,RemoveSpellEffects(GetSpellId(),OBJECT_SELF,oTarget));
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, fRange, lStart, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, vOrigin);
        }
}
