#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    effect eRegen = EffectRegenerate(30, 3.0);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eRegen, eDur);
    int nMeta = GetMetaMagicFeat();
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    if (nMeta == METAMAGIC_EXTEND)
    {
        nLevel *= 2;

    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REGENERATE, FALSE));
    if(GetLevelByClass(CLASS_TYPE_DRUID,oTarget) >= 1)
    {
    eRegen = EffectRegenerate(40, 3.0);
    SendMessageToPC(oTarget,"<c¥  >Your connection with nature improves the spells effect!</c>");
    }
    if(MothGetIsFortAlly(oTarget))
    {
        if(MothAllowSelfRegen(oTarget,OBJECT_SELF))
        {
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nLevel/8));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        else
        {
           SendMessageToPC(OBJECT_SELF,"<c¥¥¥>[Server] Not a vaild target. You cannot target yourself!</c>");
        }
    }
    else
    {
     SendMessageToPC(OBJECT_SELF,"<c¥¥¥>[Server] Not a vaild target. Target needs to be an ally!</c>");
    }
}
