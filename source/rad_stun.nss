//::///////////////////////////////////////////////
//:: Name rad_stun
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Combat Round End script

    Addition: Uses Power Word Stun on the nearest PC
    if he drops below 150 hitpoints.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    ExecuteScript("nw_c2_default3", OBJECT_SELF);

    object oStunTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    if(GetCurrentHitPoints(oStunTarget) < 150){
        ActionCastSpellAtObject(SPELL_POWER_WORD_STUN, oStunTarget);
    }
}
