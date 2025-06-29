#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oArea = GetArea(OBJECT_SELF);
    if(MothGetIsNoPvPArea(oArea))
    {
     return;
    }
    int iTimer = GetLocalInt(OBJECT_SELF, "MOTHKEGSPELL");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No School focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now. The spell is lost.</c>");
    return;
    }
    if (iTimer == FALSE)
    {
    location lLocation = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(496);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis,lLocation);
    int nDC = MothDC();
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 325));
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2,OBJECT_SELF,RoundsToSeconds(6));
    DelayCommand(0.7, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Necromancy Focus is lost.</c>"));
    SetLocalInt(OBJECT_SELF, "MOTHKEGSPELL", TRUE);
    DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, "MOTHKEGSPELL"));
    DelayCommand(60.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(1.0,MothRitualZombie(OBJECT_SELF,lLocation,nDC));
    }
}




