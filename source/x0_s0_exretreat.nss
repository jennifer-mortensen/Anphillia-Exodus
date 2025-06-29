#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x3_inc_horse"
void main()
{

    object oItem = GetSpellCastItem();

    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    if(GetLocalInt(oTarget,"HasMountExp")== TRUE)
    {
        SendMessageToPC(oTarget,"<cеее>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    if(HorseGetIsMounted(oTarget)== TRUE)
    {
        SendMessageToPC(oTarget,"<cеее>[Server] You cannot use this spell while Mounted.</c>");
        return ;
    }
    if(GetLevelByClass(CLASS_TYPE_MONK, oTarget) >= 1 && GetTag(oItem) != "STARTER_BOOTS")
    {
        SendMessageToPC(oTarget,"<cеее>[Server] Monks cannot use this spell.</c>");
        return ;
    }
    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
    {
        return ;
    }
    if (GetHasSpellEffect(SPELL_MASS_HASTE, oTarget) == TRUE)
    {
        return ;
    }
    if (GetHasSpellEffect(647, oTarget) == TRUE)
    {
        return ;
    }
    int nDuration = MothGetCasterLevel(OBJECT_SELF) + 10;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eFast = EffectMovementSpeedIncrease(150);
    effect eLink = EffectLinkEffects(eFast, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;
    }
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 455, FALSE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}
