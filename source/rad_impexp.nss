//::///////////////////////////////////////////////
//:: Name x2_def_endcombat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Combat Round End script

    Addition: if the callers hitpoints drop below one quarter,
        improved expertise will be activated.
 */
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default3", OBJECT_SELF);
    if(GetCurrentHitPoints() < (GetMaxHitPoints() / 4)){
        SetActionMode(OBJECT_SELF, ACTION_MODE_IMPROVED_EXPERTISE, 1);
    }
}
