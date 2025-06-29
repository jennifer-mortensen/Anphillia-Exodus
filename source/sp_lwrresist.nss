#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Lower Resistance has a three round timelock.
    //-----Begin Timelock Code-----
    int iTimer = GetLocalInt(OBJECT_SELF, "LOWER_RESISTANCE_TIMELOCK");
    if (iTimer == TRUE)
    {
        FloatingTextStringOnCreature("<c ее>*No Breach Focus!*</c>",OBJECT_SELF,FALSE);
        SendMessageToPC(OBJECT_SELF, "<cеее>[Server] You do not have enough focus right now.</c>");
        return;
    }
    if (iTimer == FALSE)
    {
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ее>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cеее>[Server] Breach Focus is lost!</c>"));
        SetLocalInt(OBJECT_SELF, "LOWER_RESISTANCE_TIMELOCK", TRUE);
        DelayCommand(18.0, DeleteLocalInt(OBJECT_SELF, "LOWER_RESISTANCE_TIMELOCK"));
        DelayCommand(18.0, FloatingTextStringOnCreature("<c ее>*Breach Focus Regained!*</c>",OBJECT_SELF,FALSE));
    }
    //-----End Timelock Code-----

    //Declare variables.
    object oTarget = GetSpellTargetObject();
    effect eVFX = EffectVisualEffect(VFX_IMP_BREACH);
    effect eLowerResistance = EffectSpellResistanceDecrease(6);
    effect eBreach = EffectLinkEffects(eVFX, eLowerResistance);
    float fBreachDuration = 60.0; //Ten rounds

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBreach, oTarget, fBreachDuration);
}
