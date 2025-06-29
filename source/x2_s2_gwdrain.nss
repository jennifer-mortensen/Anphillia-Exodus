#include "x0_i0_spells"
#include "x2_inc_shifter"
void DoDrain(object oTarget, int nDrain)
{
    effect eDrain = EffectNegativeLevel(nDrain);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDrain, oTarget, HoursToSeconds(3));
}
void main()
{
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    object oTarget = GetSpellTargetObject();
    int nDrain = d2(2);
    int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+10;
    int iTimer = GetLocalInt(OBJECT_SELF, "MothSpecDrain");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Draining focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    DelayCommand(1.0, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(1.0, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Draining Focus is lost.</c>"));
    SetLocalInt(OBJECT_SELF, "MothSpecDrain", TRUE);
    DelayCommand(600.0, DeleteLocalInt(OBJECT_SELF, "MothSpecDrain"));
    DelayCommand(600.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    if(oTarget != OBJECT_SELF)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE))
                {
                    {
                       DelayCommand(0.1f,DoDrain(oTarget,nDrain));
                       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
        }
    }
}
