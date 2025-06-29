#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
  object oTarget;
  int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
  int nDamagen, nModify, nHurt, nHP;
  int nMetaMagic = GetMetaMagicFeat();
  effect eKill;
  effect eHeal;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
  effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  float fDelay;
  if (nCasterLvl > 30)
  {
    nCasterLvl = 30;
  }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nModify = d8(nCasterLvl);
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 8 *nCasterLvl;
                    }
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        nModify /= 2;
                    }
                    nHurt =  nModify;
                    eKill = EffectDamage(nHurt, DAMAGE_TYPE_POSITIVE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        else
        {
            if(!GetIsReactionTypeHostile(oTarget) || GetFactionEqual(oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE, FALSE));
                nHP = d6(nCasterLvl);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nHP =6*nCasterLvl;
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nHP = nHP + (nHP/2);
                }
                if(nHP>100)
                {
                nHP = 100 + d6();
                }
                eHeal = EffectHeal(nHP);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
