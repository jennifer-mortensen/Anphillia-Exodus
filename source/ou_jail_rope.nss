#include "_inc_faction"

// Function which opens and unlocks a door if it is locked.
// Else it closes and locks the door.
void ThLockUnlock(string sDoor)
{
object oDoor;
       oDoor = GetObjectByTag(sDoor);

    if (!GetLocked(oDoor))
      {
      SetLocked(oDoor, TRUE);
      ActionCloseDoor(oDoor);
      }

    else
      {
      SetLocked(oDoor, FALSE);
      ActionOpenDoor(oDoor);
      }
}

// Function which unlocks a door, does nothing if the door is already unlocked.
void ThUnlock(string sDoor)
{
object oDoor;
       oDoor = GetObjectByTag(sDoor);

SetLocked(oDoor, FALSE);
ActionOpenDoor(oDoor);

// ?Send Defensive Faction Message? 'A Great Rumbling Is Heard From Suman Valley etc'
// ?Send Assault Faction Massage? '<Assaulters> Have succesfully released the prisoners etc'
// ?Limit to Opposition only? (EG, only axfell can use cleavens
// and Vice Versa)
}

void main()
{
object oTarget = OBJECT_SELF;
object oPC = GetLastUsedBy();

int nRequiresFaction = GetLocalInt(OBJECT_SELF, "REQUIRES_FACTION");
int nFaction = GetLocalInt(OBJECT_SELF, "FACTION");
string sMessage = GetLocalString(OBJECT_SELF, "FAILURE_MESSAGE");

if(nRequiresFaction)
{
    switch(nFaction)
    {
        case FACTION_AXFELL:
            if(!GetIsObjectValid(GetItemPossessedBy(oPC, "axfellwarriorrin")))
            {
                if(sMessage != "")
                    FloatingTextStringOnCreature(sMessage, oPC, FALSE);
                 return;
            }
            break;
        case FACTION_CLEAVEN:
            if(!GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenmilitiari")))
            {
                if(sMessage != "")
                    FloatingTextStringOnCreature(sMessage, oPC, FALSE);
                 return;
            }
            break;
    }
}

if(GetLocalInt(oPC, "IS_IN_CELL") == TRUE)
{
    FloatingTextStringOnCreature("Perhaps it would be unwise to lock yourself in...", oPC, FALSE);
    return;
}

// Cleaven

if (GetTag(oTarget) == ("clv_jail_rope_1"))
   {
   ThLockUnlock("clv_jail_door_1");
   }
if (GetTag(oTarget) == ("clv_jail_rope_2"))
   {
   ThLockUnlock("clv_jail_door_2");
   }
if (GetTag(oTarget) == ("clv_jail_rope_3"))
   {
   ThLockUnlock("clv_jail_door_3");
   }
if (GetTag(oTarget) == ("clv_jail_rope_4"))
   {
   ThLockUnlock("clv_jail_door_4");
   }
if (GetTag(oTarget) == ("clv_jail_rope_5"))
   {
   ThLockUnlock("clv_jail_forcefield");
   }

//Cleaven Master Switch

if (GetTag(oTarget) == ("clv_jail_master_switch"))
   {
   ThUnlock("clv_jail_door_1");
   ThUnlock("clv_jail_door_2");
   ThUnlock("clv_jail_door_3");
   ThUnlock("clv_jail_door_4");

   PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
   DelayCommand(5.0f, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0));
   }

//Axfell

if (GetTag(oTarget) == ("axf_jail_rope_1"))
   {
   ThLockUnlock("axf_jail_door_1");
   }
if (GetTag(oTarget) == ("axf_jail_rope_2"))
   {
   ThLockUnlock("axf_jail_door_2");
   }
if (GetTag(oTarget) == ("axf_jail_rope_3"))
   {
   ThLockUnlock("axf_jail_door_3");
   }
if (GetTag(oTarget) == ("axf_jail_rope_4"))
   {
   ThLockUnlock("axf_jail_door_4");
   }
if (GetTag(oTarget) == ("axf_jail_rope_5"))
   {
   ThLockUnlock("axf_jail_forcefield");
   }

//Axfell Master Switch

if (GetTag(oTarget) == ("axf_jail_master_switch"))
   {
   ThUnlock("axf_jail_door_1");
   ThUnlock("axf_jail_door_2");
   ThUnlock("axf_jail_door_3");
   ThUnlock("axf_jail_door_4");

   PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
   DelayCommand(5.0f, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0));
   }
}
