#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    int iTimer = GetLocalInt(OBJECT_SELF, "FocusDancer");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Dancer Focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    if (iTimer == FALSE)
    {
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Dancer Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Dancer Focus is lost.</c>"));
    effect eAOE = EffectAreaOfEffect(AOE_PER_DARKNESS,"mothsddarkness2","mothsddarkness3","");
    location lTarget = GetSpellTargetLocation();
    int nDuration = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,OBJECT_SELF)+12;
    effect eImpact = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eVis = EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eVis, eDur);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,6.7))
    {
     FloatingTextStringOnCreature("<c   >*You cannot apply these two spells at one location!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,OBJECT_SELF, HoursToSeconds(nDuration));
    SetLocalInt(OBJECT_SELF, "FocusDancer", TRUE);
    DelayCommand(180.0, DeleteLocalInt(OBJECT_SELF, "FocusDancer"));
    DelayCommand(180.0, FloatingTextStringOnCreature("<cðøþ>*Dancer Focus Regained!*</c>",OBJECT_SELF,FALSE));
    }
    }
}


