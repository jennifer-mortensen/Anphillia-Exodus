#include "X0_I0_SPELLS"
#include "x2_inc_shifter"
void main()
{
    int nDuration = GetLevelByClass(CLASS_TYPE_SHIFTER);
    int nDC = ShifterGetSaveDC(OBJECT_SELF,SHIFTER_DC_HARD)+8;
    location lTargetLocation = GetSpellTargetLocation();
    effect eGaze = EffectDominated();
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eVisDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eLink = EffectLinkEffects(eDur, eVisDur);
    int iTimer = GetLocalInt(OBJECT_SELF, "MothVampDom");
    if (iTimer == TRUE)
    {
    FloatingTextStringOnCreature("<cðøþ>*No Domination focus!*</c>",OBJECT_SELF,FALSE);
    SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] You do not have enough focus right now.</c>");
    return;
    }
    DelayCommand(1.0, FloatingTextStringOnCreature("<cðøþ>*Focus Lost!*</c>",OBJECT_SELF,FALSE));
    DelayCommand(1.0, SendMessageToPC(OBJECT_SELF, "<c¥¥¥>[Server] Domination Focus is lost.</c>"));
    SetLocalInt(OBJECT_SELF, "MothVampDom", TRUE);
    DelayCommand(300.0, DeleteLocalInt(OBJECT_SELF, "MothVampDom"));
    DelayCommand(300.0, FloatingTextStringOnCreature("<cðøþ>*Focus Regained!*</c>",OBJECT_SELF,FALSE));
    object oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    int bBreak = FALSE;
    while(GetIsObjectValid(oTarget) && !bBreak)
    {
        if(spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_GAZE_DOMINATE));
            float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            if(GetIsEnemy(oTarget))
            {
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                {
                    if (!GetHasSpellEffect(GetSpellId(),oTarget))
                    {
                        eGaze = GetScaledEffect(eGaze, oTarget);
                        eLink = EffectLinkEffects(eLink, eGaze);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration*4)));
                        bBreak = TRUE;
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 23.0, lTargetLocation, TRUE);
    }
}

