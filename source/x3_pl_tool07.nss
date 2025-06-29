#include "moth_inc_craftin"
#include "moth_inc_spells"
void main()
{
    //J. Persinne; altered this script to play nicely with the shifter's dire tiger lunge, which operates on a cooldown of one minute.
    int nEpicDireTigerAppearance = 95;

    object oUser = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nAppearance = GetAppearanceType(oUser);
    int nThrustCooldown = GetLocalInt(oUser, "DIRETIGER_THRUST_TIMELOCK");
    if(MothGetIsDisabled(oUser) && nAppearance != nEpicDireTigerAppearance)
    {
        return;
    }
    else if(MothGetIsDisabledShifter(oUser) && nAppearance == nEpicDireTigerAppearance)
    {
        return;
    }
    if(nAppearance == nEpicDireTigerAppearance && GetLocalInt(oUser, "MOTHFIGTHERCHARGE3") == TRUE)
    {
        //Temporarily enable the thrust charge if this ability is being used by a dire tiger.
        SetLocalInt(oUser, "MOTHFIGTHERCHARGE3", FALSE);
        DelayCommand(0.1, SetLocalInt(oUser, "MOTHFIGTHERCHARGE3", TRUE));
    }
    if(MothFighterThrustChecks(oUser, oTarget) == FALSE)
    {
        return;
    }
    else if(nThrustCooldown == TRUE && nAppearance == nEpicDireTigerAppearance)
    {
        FloatingTextStringOnCreature("<cðøþ>*Thrust: No Focus!*</c>",oUser,TRUE);
        SendMessageToPC(oUser,"<c ¥ >You do not have enough Thrust Focus to Charge!</c>");
        return;
    }
    if(nAppearance == nEpicDireTigerAppearance)
    {
        SetLocalInt(oUser, "DIRETIGER_THRUST_TIMELOCK", 1);
        DelayCommand(60.0, DeleteLocalInt(oUser, "DIRETIGER_THRUST_TIMELOCK"));
        DelayCommand(60.0, FloatingTextStringOnCreature("<c ¥¥>*Thrust Focus Regained!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, FloatingTextStringOnCreature("<c ¥¥>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
        DelayCommand(0.7, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Thrust Focus is lost!</c>"));
    }
    else
    {
        SetLocalInt(oUser,"MOTHFIGTHERCHARGE3",TRUE);
    }

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur1 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_SMOKE);
    effect eDur = EffectLinkEffects(eDur1,eDur2);
    effect eAB = EffectAttackIncrease(4);
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 836));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oUser,2.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oUser,4.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oUser);
    ClearAllActions(TRUE);
    ActionJumpToObject(oTarget,0);
    SetCommandable(FALSE,oUser);
    FloatingTextStringOnCreature("<cðøþ>*Thrust: Successful!*</c>",oUser,TRUE);
    DelayCommand(0.1,SetCommandable(TRUE,oUser));
    DelayCommand(0.3,AssignCommand(oUser,ActionAttack(oTarget)));
    DelayCommand(1.5,SetCommandable(TRUE,oUser)); //just in case!
}
