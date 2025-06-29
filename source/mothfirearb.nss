//Arbalest
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    object oTarget = GetSpellTargetObject();
    int nDamage;
    float fDelay;
    effect eDam;
    effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eVis2 = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
    effect eVis3 = EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE);
    effect eVis4 = EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    eVis = EffectLinkEffects(eVis,eVis4);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DECK_AVATAR));
                int nDamage = d6(22)+16;
                //Set damage effect
                if (MySavingThrow(SAVING_THROW_REFLEX,oTarget,30,SAVING_THROW_TYPE_TRAP,OBJECT_SELF,fDelay) >0)
                   {
                    nDamage /=2;
                   }
                eDam = EffectDamage(nDamage,DAMAGE_TYPE_PIERCING,DAMAGE_POWER_PLUS_FOUR);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            //Apply VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    }

