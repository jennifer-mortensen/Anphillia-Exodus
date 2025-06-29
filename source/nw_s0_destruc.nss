#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nDamage;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    int nDeath = GetCurrentHitPoints(oTarget);
    effect eDam;
    effect eVis = EffectVisualEffect(234);
    if (nCasterLvl > 20)
    {
        nCasterLvl = (nCasterLvl-20)*2/3+20;
    }
    nDamage = d6(nCasterLvl)-10;
    if(!GetIsReactionTypeFriendly(oTarget))
    {
     SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DESTRUCTION));
     if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
         if(!MySavingThrow(SAVING_THROW_FORT, oTarget, MothDC(),SAVING_THROW_TYPE_DEATH))
           {
                if(GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH,OBJECT_SELF))
                {
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                }
                else if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH,OBJECT_SELF))
                {
                eDam = EffectDamage(nDeath*2, DAMAGE_TYPE_MAGICAL);
                eDam = SupernaturalEffect(eDam);
                }
            }
         else
         {
           eDam = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
         }
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
}
