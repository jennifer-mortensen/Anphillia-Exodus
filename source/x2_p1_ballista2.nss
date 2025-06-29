//Arbalest
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if(GetTag(OBJECT_SELF) == "CleavenArbalest")
    {
    ExecuteScript("mothfirearb",OBJECT_SELF);
    }
    if(GetTag(OBJECT_SELF) == "AxfellArbalest")
    {
    ExecuteScript("mothfirearb",OBJECT_SELF);
    }
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    effect eDam;
    effect eVis1 = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
    effect eVis2 = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    effect eVis3 = EffectVisualEffect(VFX_COM_SPARKS_PARRY);
    effect eVis4 = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);
    effect eVis = EffectLinkEffects(eVis1,eVis2);
    eVis = EffectLinkEffects(eVis,eVis3);
    eVis = EffectLinkEffects(eVis,eVis4);
    int nMissiles = (nCasterLvl)/4;
    if (nCasterLvl > 20)
    {
        nCasterLvl = 20;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Make SR check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
                int nDamage = d6(nCasterLvl);
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nDamage = nCasterLvl * 6;//Damage is at max
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDamage = nDamage + (nDamage/2);
                }
                //Enter Metamagic conditions
                //Set damage effect
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothDC()))
                {
                nDamage = nDamage/2;
                }
                eDam = EffectDamage(nDamage,DAMAGE_TYPE_PIERCING);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            //Apply VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }

