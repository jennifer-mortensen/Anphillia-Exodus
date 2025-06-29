#include "moth_inc_craftin"
#include "moth_inc_spells"
void main()
{
    object oUser = OBJECT_SELF;
    if(MothGetIsDisabled(oUser)){return;}
    object oTarget = GetSpellTargetObject();
    if(MothFighterBullrushChargeChecks(oUser,oTarget)==FALSE){return;}
    float fFighter = IntToFloat(GetLevelByClass(CLASS_TYPE_FIGHTER,oUser));
    float fKnockDown = fFighter/10.0;
    effect eKnock = EffectKnockdown();
    eKnock = SupernaturalEffect(eKnock);
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur1 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 830));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oUser,2.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
    ClearAllActions(TRUE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnock,oTarget,1.0+fKnockDown);
    ActionJumpToObject(oTarget,0);
    SetCommandable(FALSE,oUser);
    SetLocalInt(oUser,"MOTHFIGTHERCHARGE",TRUE);
    SetLocalInt(oUser,"MOTHGENERALCHARGE",TRUE);
    FloatingTextStringOnCreature("<cðøþ>*Bullrush: Hit!*</c>",oUser,TRUE);
    DelayCommand(0.1,SetCommandable(TRUE,oUser));
    DelayCommand(0.3,AssignCommand(oUser,ActionAttack(oTarget)));
    DelayCommand(1.5,SetCommandable(TRUE,oUser)); //just in case!
    DelayCommand(35.5,DeleteLocalInt(oUser,"MOTHGENERALCHARGE"));
    DelayCommand(36.0,DeleteLocalInt(oUser,"MOTHGENERALCHARGE"));
    DelayCommand(36.0,FloatingTextStringOnCreature("<cðøþ>*Stamina Regained!*</c>",oUser,TRUE));
    DelayCommand(36.0,SendMessageToPC(oUser,"<c ¥ >You now have enough Stamina to Charge!</c>"));
}
