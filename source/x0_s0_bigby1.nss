#include "nw_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
void RunHandImpact1(object oTarget, object oCaster)
{
    int nBonus2 = MothGetCasterLevel(oCaster)/2;
    if (GZGetDelayedSpellEffectsExpired(SPELL_BIGBYS_INTERPOSING_HAND,oTarget,oCaster))
    {
        return;
    }
    int nDam = d12(2);
    effect eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_PLUS_THREE);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    DelayCommand(9.0f,RunHandImpact1(oTarget,oCaster));
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();

    if(GetTag(oTarget) == "ASSAULT_LADDER_SPRINGBOARD")
        oTarget = GetLocalObject(oTarget, "MY_LADDER");

    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nPCBonus = 8;
    if (!GetIsPC(oTarget)){nPCBonus = 0;}
    int nMetaMagic = GetMetaMagicFeat();
    effect eAC1 = EffectAttackDecrease(10, ATTACK_BONUS_MISC);
    effect eVis = EffectVisualEffect(VFX_DUR_BIGBYS_INTERPOSING_HAND);
    effect eLink = EffectLinkEffects(eAC1, eVis);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF,
                                              SPELL_BIGBYS_INTERPOSING_HAND,
                                              TRUE));
    if (GetHasSpellEffect(SPELL_BIGBYS_CLENCHED_FIST,oTarget) ||  GetHasSpellEffect(SPELL_BIGBYS_CRUSHING_HAND,oTarget) ||  GetHasSpellEffect(SPELL_BIGBYS_FORCEFUL_HAND,oTarget) ||  GetHasSpellEffect(SPELL_BIGBYS_GRASPING_HAND,oTarget) ||  GetHasSpellEffect(SPELL_BIGBYS_INTERPOSING_HAND,oTarget)  )    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
             nDuration = nDuration * 2;
        }
    if (!MyResistSpell(OBJECT_SELF, oTarget))
       {
            effect ePlaceholder = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            if (GetIsImmune(oTarget, IMMUNITY_TYPE_PARALYSIS) ||
                GetHasFeat(FEAT_PERFECT_SELF,oTarget))
            {
             nDuration = nDuration / 3;
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        ePlaceholder, oTarget,
                                        RoundsToSeconds(nDuration) * 2 / 3);
            RunHandImpact1(oTarget, OBJECT_SELF);
            int nCasterRoll = MothDC();
            int nTargetRoll1 = d20();
            int nTargetRoll2 = GetSkillRank(SKILL_CONCENTRATION,oTarget)/2+nPCBonus;
            int nTargetRoll = nTargetRoll2 + nTargetRoll1;
            string sTargetRollFinal = IntToString(nTargetRoll);
            string sTargetRoll1  =  IntToString(nTargetRoll1);
            string sTargetRoll2  =  IntToString(nTargetRoll2);
            string sCasterRoll  =  IntToString(nCasterRoll);
        if (nTargetRoll1==20)
        {
                    SendMessageToPC(OBJECT_SELF,"<cÝ¡Ý>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    SendMessageToPC(oTarget,"<cðøþ>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        eVis, oTarget,
                                        RoundsToSeconds(nDuration) * 2 / 3);
         return;
        }
        if (nTargetRoll1==1)
        {
                    SendMessageToPC(OBJECT_SELF,"<cÝ¡Ý>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *faliure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    SendMessageToPC(oTarget,"<cðøþ>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *faliure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            eLink,
                            oTarget,
                            RoundsToSeconds(nDuration));
                            return;
        }
        if (nCasterRoll > nTargetRoll)
        {
                    SendMessageToPC(OBJECT_SELF,"<cÝ¡Ý>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *faliure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    SendMessageToPC(oTarget,"<cðøþ>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *faliure* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            eLink,
                            oTarget,
                            RoundsToSeconds(nDuration));
        }
        else if (nCasterRoll == nTargetRoll)
        {
                    SendMessageToPC(OBJECT_SELF,"<cÝ¡Ý>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    SendMessageToPC(oTarget,"<cðøþ>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        eVis, oTarget,
                                        RoundsToSeconds(nDuration) * 2 / 3);
        }
        else
        {
                    SendMessageToPC(OBJECT_SELF,"<cÝ¡Ý>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    SendMessageToPC(oTarget,"<cðøþ>" + GetName(oTarget) + "</c><c ¿þ> : Concentration Save vs. Interposal : *success* :(" + sTargetRoll1 + " + " + sTargetRoll2 + " = " + sTargetRollFinal + " vs DC: " + sCasterRoll + ")</c>");
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                        eVis, oTarget,
                                        RoundsToSeconds(nDuration) * 2 / 3);
        }
       }
}


