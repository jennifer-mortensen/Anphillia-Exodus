#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
    effect eSight = EffectTrueSeeing();
    effect eLink = EffectLinkEffects(eDur, eSight);
    eLink = EffectLinkEffects(eLink, eDur);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TRUE_SEEING, FALSE));
    int nDuration = GetLevelByClass(CLASS_TYPE_HARPER,OBJECT_SELF)+2;
    float fFloat = IntToFloat(nDuration*40);
    int iTimer = GetLocalInt(OBJECT_SELF, "FocusSpellHarper");
    int nCasterLvl = MothGetCasterLevel(OBJECT_SELF);
    if (oTarget == OBJECT_SELF){SendMessageToPC(OBJECT_SELF,"<cðøþ>*You cannot target yourself!*</c>"); return;}
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Class focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<cðøþ>You do not have enough focus right now. The spell is lost!</c>");
    return;
    }
    if (iTimer == FALSE)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<cðøþ>Harper Sight Focus is lost!</c>"));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*2));
    SetLocalInt(OBJECT_SELF, "FocusSpellHarper", TRUE);
    DelayCommand(fFloat, DeleteLocalInt(OBJECT_SELF, "FocusSpellHarper"));
    DelayCommand(fFloat, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    }
}
