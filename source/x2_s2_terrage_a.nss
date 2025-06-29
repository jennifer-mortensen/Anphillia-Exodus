#include "NW_I0_SPELLS"
#include "x2_i0_spells"
#include "_inc_xp"
void main()
{
    object oTarget = GetEnteringObject();
    effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
    effect eDur2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur3 = EffectAttackIncrease(4, ATTACK_BONUS_MISC);
    effect eLink;

    object oBarb =GetAreaOfEffectCreator();
    int nHD = GetECLAdjustedHitDice(GetAreaOfEffectCreator());

    int nRoll = d10(1);
    int nDC = nRoll + GetSkillRank(SKILL_INTIMIDATE,oBarb);
    int nDuration = d3();
    if(GetIsEnemy(oTarget, oBarb))
    {
        SignalEvent(oTarget, EventSpellCastAt(oBarb, GetSpellId()));

          if(GetIsDead(oTarget)==TRUE){return;}//Moth: Remove prompt on corpses
          if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_FEAR))
            {
                if (GetECLAdjustedHitDice(oTarget)< GetECLAdjustedHitDice(oBarb))
                {
                    effect eFear = EffectParalyze();
                    eLink = EffectLinkEffects(eFear, eDur);
                    eLink = EffectLinkEffects(eLink, eDur2);
                    eLink = ExtraordinaryEffect(eLink);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur3, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    //Moth: Only a 10% chance to shout for help
                    if(nRoll==1){PlayVoiceChat(VOICE_CHAT_HELP,oTarget);}
                }
                else if (GetECLAdjustedHitDice(oTarget)< GetECLAdjustedHitDice(oBarb)*2)
                {
                    effect eShake1 = EffectSavingThrowDecrease(SAVING_THROW_ALL,2);
                    effect eShake2 = EffectAttackDecrease(2);
                    eLink = EffectLinkEffects(eShake1, eDur);
                    eLink = EffectLinkEffects(eLink, eShake2);
                    eLink = EffectLinkEffects(eLink, eDur2);
                    eLink = ExtraordinaryEffect(eLink);
                    FloatingTextStrRefOnCreature(83583,oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                 }
          }
      }

}
