#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
        int nDuration = MothGetCasterLevel(OBJECT_SELF)*2;
        int nIncrease;
        int nSave;
        nIncrease = d2(2);
        nSave = d2(4);
        int nMetaMagic = GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration * 2;
        }
        //PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
        effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
        effect eDur = EffectVisualEffect(VFX_DUR_GLOW_RED);
        effect eLink = EffectLinkEffects(eCon, eStr);
        eLink = EffectLinkEffects(eLink, eSave);
        eLink = EffectLinkEffects(eLink, eDur);
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 422, FALSE));
        eLink = MagicalEffect(eLink);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        RemoveEffectsFromSpell(OBJECT_SELF, GetSpellId());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration*3));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
}
