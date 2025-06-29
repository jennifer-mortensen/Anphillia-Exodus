#include "x2_inc_spellhook"
#include "nw_i0_plot"
#include "hc_inc_pwdb_func"
#include "hc_text_activate"
#include "hc_inc_rezpen"
#include "anph_inc"
#include "moth_inc_effects"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
{
    object oMod = GetModule();
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    int nAtDC;
    object oDC;
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        if(GetTag(oTarget)=="DeathCorpse")
        {
            oDC=oTarget;
            oTarget = AnphFindPlayerByKey (GetLocalString (oDC, "Name"),
                                           GetLocalString (oDC, "Key"));
            nAtDC=1;
        }
    }
    if(nAtDC || GetIsDead(oTarget))
    {
        if(nAtDC && GetIsObjectValid(oTarget)==FALSE)
        {
            SendMessageToPC(oCaster,NOTONLINE);
            SetPersistentLocation(oMod,"RESLOC"+
                GetLocalString(oDC,"Name")+
                GetLocalString(oDC,"Key"), GetLocation(oCaster));
            if(GetIsDM(oCaster))
                SetPersistentInt(oMod,"PlayerState"+
                GetLocalString(oDC,"Name")+
                GetLocalString(oDC,"Key"), 8);
            else
                SetPersistentInt(oMod,"PlayerState"+
                GetLocalString(oDC,"Name")+
                GetLocalString(oDC,"Key"), 7);
            return;
        }
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
        if(!MothGetIsInFugue(oTarget))
        {
        SendMessageToPC(OBJECT_SELF,"<cþ¥ >Only Players in Fugue Plane can be resurrected!</c>");
        return;
        }
        int nHealed = GetMaxHitPoints(oTarget);
        effect eRaise = EffectResurrection();
        effect eHeal = EffectHeal(nHealed + 11);
        effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        SetPlotFlag(oTarget, FALSE);
        MothRemoveEffects(oTarget);
        int nGhost=GetLocalInt(oMod,"GHOSTSYSTEM");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        if(nGhost)
            DeleteLocalInt(oTarget, "GHOST");
        if(GetLocalInt(oMod,"BLEEDSYSTEM"))
                DelayCommand(6.0,ExecuteScript("hc_bleeding", oTarget));
        if(GetLocalInt(oMod,"LIMBO") && !nGhost)
        {
            AssignCommand(oTarget,JumpToObject(oDC));
        }
        if( GetLocalInt(oMod,"REZPENALTY") && GetIsDM(oCaster)==FALSE)
            DelayCommand(5.0,hcRezPenalty(oTarget));
    }
}
}
