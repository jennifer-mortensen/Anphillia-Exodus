#include "moth_inc_craftin"
#include "moth_inc_spells"
void main()
{
    object oUser = OBJECT_SELF;
    if(MothGetIsDisabled(oUser)){return;}
    object oTarget = GetSpellTargetObject();
    if(MothFighterTornadoChargeChecks(oUser,oTarget)==FALSE){return;}
    float fFighter = IntToFloat(GetLevelByClass(CLASS_TYPE_FIGHTER,oUser));
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur1 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 831));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oUser,2.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
    ClearAllActions(TRUE);
    ActionJumpToObject(oTarget,0);
    SetCommandable(FALSE,oUser);
    SetLocalInt(oUser,"MOTHFIGTHERCHARGE2",TRUE);
    SetLocalInt(oUser,"MOTHGENERALCHARGE",TRUE);
    FloatingTextStringOnCreature("<cðøþ>*Tornado Charge: Hit!*</c>",oUser,TRUE);
    DelayCommand(0.1,SetCommandable(TRUE,oUser));
    DelayCommand(0.2,MothTornadoCharge(oUser));
    DelayCommand(1.5,SetCommandable(TRUE,oUser)); //just in case!
    DelayCommand(35.5,DeleteLocalInt(oUser,"MOTHGENERALCHARGE"));
    DelayCommand(36.0,DeleteLocalInt(oUser,"MOTHGENERALCHARGE"));
    DelayCommand(36.0,FloatingTextStringOnCreature("<cðøþ>*Stamina Regained!*</c>",oUser,TRUE));
    DelayCommand(36.0,SendMessageToPC(oUser,"<c ¥ >You now have enough Stamina to Charge!</c>"));
}
