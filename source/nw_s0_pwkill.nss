#include "x0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF)/2;
    int nBonus = nCasterLvl*2;
    int nDamage;
    int nDeath = GetCurrentHitPoints(oTarget);
    effect eDam;
    effect eVis1 = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eVis2 = EffectVisualEffect(VFX_FNF_PWKILL);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    nDamage = d8(nCasterLvl) + nBonus;
    if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE){return;}
    if(!MothGetIsFortAlly(oTarget))
    {
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POWER_WORD_KILL));
     if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
         if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(),SAVING_THROW_TYPE_DEATH))
           {
                if(GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT || GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                }
                else if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH,OBJECT_SELF))
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
