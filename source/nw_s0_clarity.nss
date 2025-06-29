#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    effect eImm1 = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
    effect eDam = EffectDamage(5, DAMAGE_TYPE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eImm1, eVis);
    eLink = EffectLinkEffects(eLink, eDur);
    object oTarget = GetSpellTargetObject();
    effect eSearch = GetFirstEffect(oTarget);
    int nDuration = MothGetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    int bValid;
    int bVisual;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CLARITY, FALSE));
    while(GetIsEffectValid(eSearch))
    {
        bValid = FALSE;
        if (GetEffectType(eSearch) == EFFECT_TYPE_DAZED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_CHARMED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_SLEEP)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_CONFUSED)
        {
            bValid = TRUE;
        }
        else if(GetEffectType(eSearch) == EFFECT_TYPE_STUNNED)
        {
            bValid = TRUE;
        }
        if (bValid == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            RemoveEffect(oTarget, eSearch);
            bVisual = TRUE;
        }
        eSearch = GetNextEffect(oTarget);
    }
    float fTime = 30.0  + TurnsToSeconds(nDuration);
    if(oTarget != OBJECT_SELF)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fTime);
    }
    else
    {
       SendMessageToPC(OBJECT_SELF,"<cеее>[Server] Not a vaild target. Target needs to be an ally!</c>");
    }

}

