#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_inc_shifter"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    if(oTarget == OBJECT_SELF){return;}
    int nDC = MothDC();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    //If Outsider Shape and Deamonflesh Golem
    if(GetAppearanceType(OBJECT_SELF) == 293
       || GetAppearanceType(OBJECT_SELF) == 290
       || GetAppearanceType(OBJECT_SELF) == 428
       || GetAppearanceType(OBJECT_SELF) == 468
       || GetAppearanceType(OBJECT_SELF) == 429
       || GetAppearanceType(OBJECT_SELF) == 152
       || GetAppearanceType(OBJECT_SELF) == 1491//new stone
       || GetAppearanceType(OBJECT_SELF) == 420//new iron
       || GetAppearanceType(OBJECT_SELF) == 426//new slaad
       )
    {
        nCasterLvl = GetHitDice(OBJECT_SELF);
        nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD,TRUE)+6;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = d6(5) + nCasterLvl;
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 30 + nCasterLvl;
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
         nDamage += nDamage / 2;
    }
    effect eHeal = EffectHeal(nDamage);
    effect eVs = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eLink = EffectLinkEffects(eVs,eHeal);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eLink2 = EffectLinkEffects(eVis,eDamage);
    if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
    {
        if(!GetIsReactionTypeFriendly(oTarget) &&
            GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD &&
            GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT &&
            !GetHasSpellEffect(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget,nDC, SAVING_THROW_TYPE_NEGATIVE))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink2, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, OBJECT_SELF);
                    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
                }
            }
        }
    }
}
