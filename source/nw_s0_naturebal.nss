#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "_inc_spells"
#include "_inc_gen"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    if(GetTag(OBJECT_SELF) == "Ent")
    {
        ExecuteScript("mothentsummon",OBJECT_SELF);
        return;
    }
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
    effect eSR;
    effect eVis2 = EffectVisualEffect(VFX_IMP_BREACH);
    effect eNature = EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    int nRand;
    int nCasterLevel = MothGetCasterLevel(OBJECT_SELF);
    if(GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_LIZARDFOLK_MALE_EPIC) || GetIsPolymorphType(OBJECT_SELF, ANPH_POLYMORPH_TYPE_LIZARDFOLK_FEMALE_EPIC))
    {   //J. Persinne; Lizardfolk Whipmasters add their shifter level to this spell's caster level.
        nCasterLevel += GetLevelByClass(CLASS_TYPE_SHIFTER);
    }
    int nDuration = 10;
    int nMetaMagic = GetMetaMagicFeat();
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
    float fDelay;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eNature, GetLocation(OBJECT_SELF));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE);
    while(GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        if(MothGetIsFortAlly(oTarget))
        {
           if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
            {
              SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NATURES_BALANCE, FALSE));
              nRand = d6(nCasterLevel);
              if (nMetaMagic == METAMAGIC_MAXIMIZE)
              {
                 nRand = 6 * nCasterLevel;
              }
              else if (nMetaMagic == METAMAGIC_EMPOWER)
              {
                 nRand = nRand + nRand/2;
              }
              object oScroll = GetSpellCastItem();
              if(GetIsObjectValid(oScroll))
              {
                nRand = nRand+36;
              }
              if (nRand > 180)
              {
                  nRand = 170 - d8(2);
              }
              eHeal = EffectHeal(nRand);
              if(nDruid > 0) //J. Persinne; Druids now provide a heal over time effect to affected targets with this spell.
              {
                ApplyDruidHoT(nRand, oTarget);
              }
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
        else if(!MothGetIsFortAlly(oTarget))
        {
                      SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_NATURES_BALANCE));
                      nCasterLevel/2;
                      if(nCasterLevel == 0)
                      {
                        nCasterLevel = 1;
                      }
                      nRand = d2(nCasterLevel);
                      if (nMetaMagic == METAMAGIC_MAXIMIZE)
                      {
                         nRand = 2 * nCasterLevel;
                      }
                      else if (nMetaMagic == METAMAGIC_EMPOWER)
                      {
                         nRand = nRand + (nRand/2);
                      }
                      eSR = EffectSpellResistanceDecrease(nRand);
                      effect eLink = EffectLinkEffects(eSR, eDur);
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                      DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), FALSE);
    }
}

