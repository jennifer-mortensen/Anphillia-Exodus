#include "X0_INC_HENAI"
#include "nw_i0_plot"
#include "hc_inc"
void main()
{
    if (GetIsObjectValid(GetMaster()) == TRUE)
    {
        object oMe = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster());
        if (oMe == OBJECT_SELF
            || GetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED") == TRUE)
        {
           SetPlotFlag(oMe, TRUE);
           SetAssociateState(NW_ASC_IS_BUSY, TRUE);
           AddJournalQuestEntry("Henchman", 99, GetMaster(), FALSE, FALSE, FALSE);
           SetIsDestroyable(FALSE, TRUE, TRUE);
           SetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED", TRUE);
            ClearAllActions();
            DelayCommand(0.5, ActionDoCommand(SetCommandable(TRUE)));
            DelayCommand(5.0, ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY, FALSE)));
            DelayCommand(5.0, SetPlotFlag(oMe, FALSE));
            SetCommandable(FALSE);


        }
        else
        if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetMaster()) == OBJECT_SELF)
        {
            object oMaster = GetMaster(OBJECT_SELF);
            if (GetLocalInt(oMod,"REALFAM") &&
                GetIsPC(oMaster) && oMaster != OBJECT_INVALID)
            {
                int nXPPen = 0;
                if (FortitudeSave(oMaster, 15)>0)
                    nXPPen /= 2;
                if(GetXP(oMaster) > nXPPen)
                    SetXP(oMaster, (GetXP(oMaster) - nXPPen));
                else
                    SetXP(oMaster, 1);
                if(GetLocalInt(GetModule(),"PWEXP"))
                {
                }
                SetLocalInt(oMod,"FAMDIED"+GetName(oMaster),1);
            }
            else
            {
                int nDam =0;
                if (nDam >= GetCurrentHitPoints(GetMaster()))
                {
                    nDam = GetCurrentHitPoints(GetMaster()) - 1;
                }
                effect eDam = EffectDamage(nDam);
                FloatingTextStrRefOnCreature(63489, GetMaster(), FALSE);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, GetMaster());
            }
        }
    }
}
