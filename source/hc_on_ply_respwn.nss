//Hardcore Respawn
//Archaegeo 2002 Jun 24

// This goes in OnPlayerRespawn in Module Properties Events
// It checks to see if the player has a god, and if so whether or
// not he feels like listening to them.  As is now, they can pray
// as often as they want, with a 3% chance. (May set time limit or
// bad effect for annoying your God later). To go to normal respawn
// just comment out the section as noted below.
#include "hc_inc"
#include "hc_inc_remeff"
#include "hc_inc_on_respwn"

void main()
{
    if(!preEvent()) return;
    object oRespawner = GetLastRespawnButtonPresser();
    string sID=GetName(oRespawner)+GetPCPublicCDKey(oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
    RemoveEffects(oRespawner);

    if(GetLocalInt(oMod,"LIMBO"))
    {
        AssignCommand(oRespawner, JumpToLocation(
                  GetPersistentLocation(oMod,"DIED_HERE"+sID)));
    }
// Clean up their player corpse token if one exists
    if(GetLocalInt(oMod,"LOOTSYSTEM"))
    {
        object oPCT=GetLocalObject(oMod,"PlayerCorpse"+sID);
        if(GetIsObjectValid(oPCT)) DestroyObject(oPCT,3.0);
    }

// At this point they are respawned where they stand.  If you want to move them
// to safety, you should do so here.


    postEvent();
}
