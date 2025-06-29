#include "moth_inc_tracker"
void main()
{
 object oOwner = OBJECT_SELF;
 int nHBCount2 = GetLocalInt(oOwner, "HBCount2");
 nHBCount2++;
 SetLocalInt(oOwner, "HBCount2", nHBCount2);
 if(nHBCount2 > 3)
   {
    object oPC1 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oOwner,1);
    object oPC2 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oOwner,2);
    object oPC3 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oOwner,3);
    object oPC4 = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,PLAYER_CHAR_IS_PC,oOwner,4);
    if(GetIsObjectValid(oPC1))
    {
    DelayCommand(0.2,MothHeartbeatTracking(oPC1));
    }
    if(GetIsObjectValid(oPC2))
    {
    DelayCommand(0.4,MothHeartbeatTracking(oPC2));
    }
    if(GetIsObjectValid(oPC3))
    {
    DelayCommand(0.6,MothHeartbeatTracking(oPC3));
    }
    if(GetIsObjectValid(oPC4))
    {
    DelayCommand(0.8,MothHeartbeatTracking(oPC4));
    }
    SetLocalInt(oOwner, "HBCount2", 0);
   }
}

