#include "spawn_functions"

void NESS_AbandonSpawn( object oSpawned, int bManageCorpse=TRUE )
{
    // find the spawn's parent
    object oSpawn = GetLocalObject(oSpawned, "ParentSpawn");
    if (!GetIsObjectValid(oSpawn))
    {
       // Camp or non-NESS creature.  Ignore for now
       return;
    }
    // find the object on the parent
    string sChildSlot;
    int nSpawnNumber;
    int nChildSlot;
    object oCreature;
    nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    for (nChildSlot = 1; nChildSlot <= nSpawnNumber; nChildSlot++)
    {
        // Retrieve Child
        sChildSlot = "ChildSlot" + PadIntToString(nChildSlot, 2);
        oCreature = GetLocalObject(oSpawn, sChildSlot);
        // Is this who we seek?
        if (oCreature == oSpawned)
        {
           SetLocalObject(oSpawn, sChildSlot, OBJECT_INVALID);
           break;
        }
    }
    // manage corpse? Note that this will have no effect one way or the other
    // if the CD flag isn't in use
    if (! bManageCorpse)
    {
       SetLocalInt(oSpawned, "ProcessedDeath", TRUE);
       float fCorpseDecay = GetLocalFloat(oSpawn, "f_CorpseDecay");
       if (fCorpseDecay > 0. || GetLocalInt(GetModule(), "AlwaysDestroyCorpses"))
       {
          // We were managing it, so we need to make it destroyable
          AssignCommand(oSpawned, SetIsDestroyable(TRUE, FALSE));
       }
    }
}

int NESS_IsNessSpawn(object oSpawned)
{
   if(GetIsObjectValid(GetLocalObject(oSpawned, "ParentSpawn")))
   {
      return TRUE;
   }
   return FALSE;
}

void main()
{
    /*
     * Full-Edge Area Transition
     * -------------------------
     * Based on The Mighty Teleport Script from Richard Conner
     * Jonathan Warrington
     *
     * Usage
     * -----
     * This is attached to the OnClick event of a GenericTrigger
     * Two properties need to be modified to your areas.  First,
     * the GetObjectByTag line, fill in the tag of your trigger,
     * that's in the destination area.  Second, make sure the
     * appropriate vDest is uncommented.
     */
    //Get the PC that just clicked on the transition
    object oClicker = GetEnteringObject();

    if(!GetIsPC(oClicker)) //J. Persinne; relinquish control of NESS spawns from the NESS handler so that dominated creatures will not despawn.
    {
        if(NESS_IsNessSpawn(oClicker))
        {
            if(GetIsObjectValid(GetMaster(oClicker)))
            {
                NESS_AbandonSpawn(oClicker);
            }
            else
            {
                AssignCommand(oClicker, ClearAllActions(TRUE));
                SetLocalInt(oClicker, "TRANSITION_HALTED", TRUE);
                return;
            }
        }
    }

    if(!GetIsPC(oClicker) && !GetIsDM(oClicker) && !GetIsDMPossessed(oClicker) && !GetIsObjectValid(GetMaster(oClicker))) //J. Persinne; do not allow faction NPCs to transition.
    {
        object oAxfellFaction = GetObjectByTag("MOTHAXFELLHOLDER");
        object oAxfell2Faction = GetObjectByTag("MOTHAXFELL2HOLDER");
        object oCleavenFaction = GetObjectByTag("MOTHCLEAVENHOLDER");
        object oCleaven2Faction = GetObjectByTag("MOTHCLEAVEN2HOLDER");
        object oRanzingtonFaction = GetObjectByTag("MOTHRANZHOLDER");

        if(GetFactionEqual(oClicker, oAxfellFaction) ||
           GetFactionEqual(oClicker, oAxfell2Faction) ||
           GetFactionEqual(oClicker, oCleavenFaction) ||
           GetFactionEqual(oClicker, oCleaven2Faction) ||
           GetFactionEqual(oClicker, oRanzingtonFaction))
            {
                SetLocalInt(oClicker, "TRANSITION_HALTED", TRUE);
                return;
            }
    }


    //Get the location of the PC
    location lLoc = GetLocation( oClicker );
    //Get the PC's postion
    vector vEnter = GetPositionFromLocation( lLoc );
    //The Trigger that's in the destination area
    //object oTrap = GetNearestTrapToObject (oClicker);
    SendMessageToPC (oClicker, "trigger: " + GetTag (OBJECT_SELF));
    object oTran = GetObjectByTag( GetTag (OBJECT_SELF) + "Marker");
    //Get the destination area
    object oDestArea = GetArea( oTran );

    // Calculate the new position.. x stays the same
    // as this is a north-south transition, so we
    // just have to invert y.
    if (vEnter.y < 10.0)
    {
        vEnter.y = 150.0;
    } else {
        vEnter.y = 10.0;
    }

    //Get the PC's facing
    float fFacing = GetFacingFromLocation( lLoc );
    //Create a new Location to place the PC in
    location locNew = Location( oDestArea, vEnter, fFacing );
    //Clear all PC actions, (Stop walking) and then jump
    //to the new location.
    AssignCommand( oClicker, ClearAllActions() );
    AssignCommand( oClicker, JumpToLocation( locNew ) );
}

