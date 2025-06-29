#include "x2_inc_switches"
#include "x0_i0_spells"
void main()
{
     object oItem = GetSpellCastItem();
     object oSpellTarget = GetSpellTargetObject();
     if(GetObjectType(oSpellTarget) != OBJECT_TYPE_CREATURE) //J. Persinne; do not apply these effects if the target is not a creature.
        return;
     object oSpellOrigin = OBJECT_SELF;
        if(GetSpellId() == 791)
          {
             object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSpellOrigin);
             if(MatchShield(oShield)==FALSE){return;}
             int nDice = d20();
             if(nDice<18){return;}
             effect eKnock = EffectKnockdown();
             effect eVis = EffectVisualEffect(VFX_DUR_SMOKE);
             if(GetIsImmune(oSpellTarget,IMMUNITY_TYPE_KNOCKDOWN,oSpellOrigin))
             {
                FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Target Immune!*</c>",oSpellOrigin,TRUE);
                return;
             }
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oSpellOrigin,1.5);
                int nTargetRoll1 = d20();
                int nCasterRoll1 = d20();
                int nCasterRoll = 19 + GetBaseAttackBonus(oSpellOrigin) + GetAbilityModifier(ABILITY_STRENGTH,oSpellOrigin) + nCasterRoll1;
                int nTargetRoll2 = GetSkillRank(SKILL_DISCIPLINE,oSpellTarget);
                int nTargetRoll = nTargetRoll2 + nTargetRoll1;
                string sTargetRollFinal = IntToString(nTargetRoll);
                string sTargetRoll1  =  IntToString(nTargetRoll1);
                string sTargetRoll2  =  IntToString(nTargetRoll2);
                string sCasterRoll  =  IntToString(nCasterRoll);
                string sName = GetName(oSpellTarget);
                if (nTargetRoll1==20)
                {
                  SendMessageToPC(oSpellOrigin,"<cÝ¡Ý>" + sName + "</c><c  Í> : Discipline : *auto success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  SendMessageToPC(oSpellTarget,"<cðøþ>" + sName + "</c><c  Í> : Discipline : *auto success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Resisted!*</c>",oSpellOrigin,TRUE);
                  return;
                }
                else if (nTargetRoll1==1)
                {
                  SendMessageToPC(oSpellOrigin,"<cÝ¡Ý>" + sName + "</c><c  Í> : Discipline : *critical failure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  SendMessageToPC(oSpellTarget,"<cðøþ>" + sName + "</c><c  Í> : Discipline : *critical failure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Critical Hit!*</c>",oSpellOrigin,TRUE);
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oSpellTarget,3.0);
                  return;
                }
                else if (nCasterRoll > nTargetRoll)
                {
                  SendMessageToPC(oSpellOrigin,"<cÝ¡Ý>" + sName + "</c><c  Í> : Discipline : *failure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  SendMessageToPC(oSpellTarget,"<cðøþ>" + sName + "</c><c  Í> : Discipline : *failure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Hit!*</c>",oSpellOrigin,TRUE);
                  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oSpellTarget,3.0);
                  return;
                }
                else if (nCasterRoll == nTargetRoll)
                {
                  SendMessageToPC(oSpellOrigin,"<cÝ¡Ý>" + sName + "</c><c  Í> : Discipline : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  SendMessageToPC(oSpellTarget,"<cðøþ>" + sName + "</c><c  Í> : Discipline : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Resisted!*</c>",oSpellOrigin,TRUE);
                  return;
                }
                else if (nCasterRoll < nTargetRoll)
                {
                  SendMessageToPC(oSpellOrigin,"<cÝ¡Ý>" + sName + "</c><c  Í> : Discipline : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  SendMessageToPC(oSpellTarget,"<cðøþ>" + sName + "</c><c  Í> : Discipline : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                  FloatingTextStringOnCreature("<cðøþ>*Auto Knockdown: Resisted!*</c>",oSpellOrigin,TRUE);
                  return;
                }
            }
            else if (GetSpellId() == 792)
            {
                     int nDice = d20();
                     if(nDice<16){return;}
                     int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN,oSpellOrigin);
                     int nDC = nLevel+13;
                     float fDuration = IntToFloat(nLevel);
                     fDuration = fDuration*0.2;
                     if(!MySavingThrow(SAVING_THROW_WILL,oSpellTarget,nDC,SAVING_THROW_TYPE_NONE,oSpellOrigin))
                     {
                         effect eDur= EffectVisualEffect(VFX_DUR_ICESKIN);
                         effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
                         effect eSlow = EffectCutsceneImmobilize();
                         effect eLink = EffectLinkEffects(eDur,eSlow);
                         effect eDexFix = EffectAbilityIncrease(ABILITY_DEXTERITY, 1);
                         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oSpellTarget,2.0);
                         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oSpellTarget, IntToFloat(nLevel / 2));
                         DelayCommand(2.1, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDexFix,oSpellTarget,0.5));
                         ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oSpellTarget);
                         FloatingTextStringOnCreature("<cðøþ>*Lethargic Assail: Hit!*</c>",oSpellOrigin,TRUE);
                     }
                     else
                     {
                         FloatingTextStringOnCreature("<cðøþ>*Lethargic Assail: Resisted!*</c>",oSpellOrigin,TRUE);
                     }
                    return;
            }
}
