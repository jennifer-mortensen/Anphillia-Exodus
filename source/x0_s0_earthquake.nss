#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDamage;
    //int nDice = 8;
    int nDamagePower = DAMAGE_POWER_PLUS_FIVE;
    float fDelay;
    float nSize =  32.0;
    effect eExplode = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
    effect eVis = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
    effect eDam;
    effect eDam2;
    effect eShake = EffectVisualEffect(356);
    int nMetaMagic = GetMetaMagicFeat();
    location lTarget = GetSpellTargetLocation();
    object oScroll = GetSpellCastItem();
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);

    if (nCasterLvl > 20)
    {
        nCasterLvl = (nCasterLvl-20)*1/4+20;
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, OBJECT_SELF, RoundsToSeconds(1));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_EARTHQUAKE));
            fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            //if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            //{
              nDamage = d8(nCasterLvl);
              //if(GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER,OBJECT_SELF) == TRUE)
              //{
              //  nDamage = d10(nCasterLvl);
              //  nDice = 10;
              //}
              if (nMetaMagic == METAMAGIC_MAXIMIZE)
              {
                 nDamage = 8 * nCasterLvl;
              }
              else if (nMetaMagic == METAMAGIC_EMPOWER || GetHasFeat(FEAT_DESTRUCTION_DOMAIN_POWER, OBJECT_SELF) || nDruid >= 21)
              {
                 nDamage = nDamage + nDamage / 2;
              }
              nDamage = MothGetReflexAdjustedDamage(nDamage,oTarget,MothDC(),SAVING_THROW_TYPE_DIVINE);
              if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
                nDamage = nDamage *2;
              //if(nDamage>130){nDamage = 125+d12();}
              eDam = EffectDamage(nDamage,DAMAGE_TYPE_BLUDGEONING,nDamagePower);
              if(nDamage>0)
                {

                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             //}
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);
    }
}


