//Main script for Aura of Courage.
//Effects applied via heartbeats.
//Uses old hijacked scripts to apply different bonuses to allies depending on lvl.
//Search for MOTHAURACOURAGE to find all scripts involved.
#include "x2_inc_spellhook"
#include "x2_inc_toollib"
#include "moth_inc_hb"
void main()
{
        if (!X2PreSpellCastCode())
        {
            return;
        }
        object oScroll = GetSpellCastItem();
        if(GetIsObjectValid(oScroll))
        {
          return;
        }
        object oTarget = OBJECT_SELF;
        int nMetaMagic = GetMetaMagicFeat();
        int nCasterLvl = MothGetCasterLevel(oTarget);
        float fDuration = RoundsToSeconds(nCasterLvl);
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
             fDuration = fDuration * 2;
        }
        effect eBuffSelfVis1 = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eBuffSelfVis2 = EffectVisualEffect(VFX_IMP_TORNADO);
        effect eBuffSelfVis3 = EffectVisualEffect(VFX_IMP_AC_BONUS);
        effect eBuffSelfVis = EffectLinkEffects(eBuffSelfVis1,eBuffSelfVis2);
        eBuffSelfVis = EffectLinkEffects(eBuffSelfVis,eBuffSelfVis3);
        effect eAOE = EffectVisualEffect(VFX_DUR_AURA_DRAGON_FEAR);
        effect eBuff = EffectImmunity(IMMUNITY_TYPE_FEAR);
        effect eBuff1 = EffectImmunity(IMMUNITY_TYPE_DAZED);
        effect eBuff2 = EffectImmunity(IMMUNITY_TYPE_CURSED);
        effect eBuff3 = EffectImmunity(IMMUNITY_TYPE_STUN);
        effect eBuffAlly = EffectLinkEffects(eBuff,eBuff1);
        eBuffAlly = EffectLinkEffects(eBuffAlly,eAOE);
        if(nCasterLvl>20)
        {
        eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff2);
        }
        if(nCasterLvl>30)
        {
        eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff2);
        eBuffAlly = EffectLinkEffects(eBuffAlly,eBuff3);
        }
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuffAlly, oTarget,fDuration));
        if(MothGetIsPureClass(CLASS_TYPE_CLERIC,oTarget))
        {
        int nACBonus = nCasterLvl/10;
        int nDamage = IPGetDamageBonusConstantFromNumber(nACBonus);
        effect eAC = EffectACIncrease(3+nACBonus,AC_DEFLECTION_BONUS);
        effect eDamage = EffectDamageIncrease(nDamage,DAMAGE_TYPE_POSITIVE);
        effect eLink = EffectLinkEffects(eAC,eDamage);
        DelayCommand(0.4,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,fDuration));
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBuffSelfVis, oTarget);
        //PlayVoiceChat(VOICE_CHAT_GROUP,oTarget);
        TLVFXPillar(VFX_IMP_IMPROVE_ABILITY_SCORE,GetLocation(oTarget),2,0.1,3.0);
        SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(),FALSE));
        MothApplyAuraOfCourage(oTarget);
}
