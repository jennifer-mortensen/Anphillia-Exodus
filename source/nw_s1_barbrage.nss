#include "x2_i0_spells"
#include "x0_i0_spells"
void main()
{
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        if(nLevel < 7){nLevel=7;}
        int nIncrease;
        int nSave;
        if (nLevel < 15)
        {
            nIncrease = 4;
            nSave = 2;
        }
        else
        {
            nIncrease = 6;
            nSave = 4;
        }
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + nIncrease;
        string sName = GetName(OBJECT_SELF);
        effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nSave);
        effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave+4);
        effect eAB = EffectAttackIncrease(nSave/2,ATTACK_BONUS_MISC);
        effect eDur = EffectVisualEffect(VFX_DUR_IOUNSTONE_RED);
        effect eLink = EffectLinkEffects(eCon, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eAB);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_BARBARIAN_RAGE, FALSE));
        eLink = ExtraordinaryEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        if (nCon > 0)
        {
            if(GetHasFeat(FEAT_MIGHTY_RAGE))
            {
            nCon = nCon*3/2;
            }
            RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
            DelayCommand(0.5,FloatingTextStringOnCreature("<c¼>*"+sName+" enters Rage!*</c>",OBJECT_SELF));
            DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nLevel)*3));
            DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
            CheckAndApplyEpicRageFeats(nLevel*3);
        }
}
