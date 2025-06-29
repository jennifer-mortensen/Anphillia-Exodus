#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDeath = GetCurrentHitPoints(oTarget);
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    nDamage = d6(6) + nCasterLvl;
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
       {
        nDamage = 36 + nCasterLvl;
       }
    if (nMetaMagic == METAMAGIC_EMPOWER)
       {
        nDamage = nDamage + (nDamage/2);
       }
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE){return;}
    if(GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT || GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD){return;}
    if(!GetIsReactionTypeFriendly(oTarget))
    {
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FINGER_OF_DEATH));
     if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
         if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(),SAVING_THROW_TYPE_DEATH))
           {
                if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH,OBJECT_SELF))
                {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                }
                else if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH,OBJECT_SELF))
                {
                eDam = EffectDamage(nDeath*2, DAMAGE_TYPE_MAGICAL);
                eDam = SupernaturalEffect(eDam);
                }
            }
         else
         {
           eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
         }
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
