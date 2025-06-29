#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    effect eAttack = EffectAttackIncrease(20);
    effect eDur = EffectVisualEffect(VFX_DUR_GLOW_WHITE);
    effect eLink = eAttack;
    eLink = EffectLinkEffects(eLink, eDur);
    oTarget = OBJECT_SELF;
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 415, FALSE));
        int iTimer = GetLocalInt(OBJECT_SELF, "truestrike");
        int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
        if (iTimer == TRUE)
        {
        FloatingTextStringOnCreature("<c ее>*No True Strike Focus!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
        }
        if (iTimer == FALSE)
        {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] True Strike Focus is lost!</c>"));
        oTarget = OBJECT_SELF;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 15.0);;
        SetLocalInt(OBJECT_SELF, "truestrike", TRUE);
        DelayCommand(35.0, DeleteLocalInt(OBJECT_SELF, "truestrike"));
        DelayCommand(35.0, FloatingTextStringOnCreature("<c ее>*True Strike Focus Regained!*</c>",OBJECT_SELF,FALSE));
        }
}

