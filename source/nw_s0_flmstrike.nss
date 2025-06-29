#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
  object oTarget;
  int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
  int nDamage, nDamage2, nDamageTotal;
  int nMetaMagic = GetMetaMagicFeat();
  effect eStrike = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
  effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
  effect eHoly;
  effect eFire;
  if (nCasterLvl > 20)
  {
    nCasterLvl = 20;
  }
  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE|OBJECT_TYPE_PLACEABLE|OBJECT_TYPE_DOOR);
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, GetSpellTargetLocation());
  while ( GetIsObjectValid(oTarget) )
  {
       if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
       {
           SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_STRIKE));
           if (!MyResistSpell(OBJECT_SELF, oTarget, 0.6))
           {
                nDamage =  d6(nCasterLvl);
                nDamage2 =  d4(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = 6 * nCasterLvl;
                     nDamage2 = 4 * nCasterLvl;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                      nDamage = nDamage + (nDamage/2);
                      nDamage2 = nDamage2 + (nDamage2/2);
                }
                if(nDamage2>90){nDamage2=85+d10();}
                nDamage = MothGetReflexAdjustedDamage(nDamage, oTarget, MothDC(), SAVING_THROW_TYPE_FIRE);
                if(MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_DIVINE, OBJECT_SELF, 0.6))
                {
                 nDamage2 /= 2;
                }
                eHoly =  EffectDamage(nDamage2,DAMAGE_TYPE_DIVINE);
                eFire =  EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                nDamageTotal = nDamage+nDamage2;
                if(nDamageTotal > 0)
                {
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(0.6, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHoly, oTarget));

                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE,GetSpellTargetLocation(), FALSE, OBJECT_TYPE_CREATURE|OBJECT_TYPE_PLACEABLE|OBJECT_TYPE_DOOR);
    }
}
