#include "moth_inc"
// * Returns TRUE if oArea is a woodland area.
//Scans for one or more WAYPOINTS with the Tag "MOTHWOOD"
int MothGetIsWoodland(object oArea);
// * Returns TRUE if oCreature should be tracked.
int MothAllowTracking(object oCreature);
// * Starts Tracking.
void MothStartTracking(object oPlayer);
// * Stops tracking.
void MothEndTracking(object oPlayer);
// * Returns TRUE if oArea already has a Tracker.
int MothAlreadyTracker(object oArea);
// * Returns TRUE if oArea has a PC in it.
int MothPCInArea(object oArea);
// * Spawns a Tracker at the waypoint called "MOTHTRACKERLOC"
void MothSpawnTracker(object oPlayer);
// * Despawns a Tracker. Used with MothSpawnTracker().
void MothDespawnTracker(object oPlayer);
// * Returns TRUE if there already is a footprint at the location.
int MothAlreadyPrint(location lWaypoint, float fSize=1.5);
// * Tracks the PC's movement by placing a waypoint at the players feet each HB
void MothHeartbeatTracking(object oPlayer);
// * Run on OnEnter for all woodland areas.
void MothWoodlandEnter(object oPlayer);
// * Run on OnExit for all woodland areas.
void MothWoodlandExit(object oPlayer);

int MothGetIsWoodland(object oArea)
{
    int nCheck=FALSE;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetTag(oObject) == "MOTHWOOD")
         {
             nCheck=TRUE;
         }
         oObject = GetNextObjectInArea(oArea);
    }
    if(nCheck==FALSE)
    {
     return FALSE;
    }
    else return TRUE;
}
//Returns TRUE if oCreature should be tracked.
int MothAllowTracking(object oCreature)
{
    if(!GetIsPC(oCreature))
    {
     return FALSE;
    }
    if(GetHasFeat(FEAT_TRACKLESS_STEP,oCreature))
    {
     return FALSE;
    }
    if(GetLocalInt(oCreature,"MOTHISTRACKED"))
    {
     return FALSE;
    }
    else return TRUE;
}
void MothStartTracking(object oPlayer)
{
    if(!MothAllowTracking(oPlayer)){return;}
    SetLocalInt(oPlayer,"MOTHISTRACKED",TRUE);
}
void MothEndTracking(object oPlayer)
{
 if(GetLocalInt(oPlayer,"MOTHISTRACKED"))
   {
    DeleteLocalInt(oPlayer,"MOTHISTRACKED");
   }
}
//Returns TRUE if oArea already has a Tracker.
int MothAlreadyTracker(object oArea)
{
    int nCheck=FALSE;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetResRef(oObject) == "moth_tracker")
         {
             nCheck=TRUE;
         }
         oObject = GetNextObjectInArea(oArea);
    }
    if(nCheck==FALSE)
    {
     return FALSE;
    }
    else return TRUE;
}
//Returns TRUE if oArea has a PC in it.
int MothPCInArea(object oArea)
{
    int nCheck=FALSE;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetIsPC(oObject))
         {
             nCheck=TRUE;
         }
         oObject = GetNextObjectInArea(oArea);
    }
    if(nCheck==FALSE)
    {
     return FALSE;
    }
    else return TRUE;
}
void MothSpawnTracker(object oPlayer)
{
   object oArea = GetArea(oPlayer);
   object oWaypoint = GetNearestObjectByTag("MOTHTRACKERLOC",oPlayer);
   location lLocation = GetLocation(oWaypoint);
   if(!MothAlreadyTracker(oArea))
   {
     object oTracker = CreateObject(OBJECT_TYPE_CREATURE,"moth_tracker",lLocation);
   }
}
void MothDespawnTracker(object oPlayer)
{
   object oArea = GetArea(oPlayer);
   object oTracker = GetNearestObjectByTag("MOTH_TRACKER",oPlayer);
   if(!MothPCInArea(oArea))
   {
     SetPlotFlag(oTracker,FALSE);
     DelayCommand(0.1,DestroyObject(oTracker));
   }
}
//Returns TRUE if there already is a footprint at the location.
int MothAlreadyPrint(location lWaypoint, float fSize=1.5)
{
    int nCheck=FALSE;
    string sWaypoint;
    object oWaypoint = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lWaypoint, FALSE,OBJECT_TYPE_WAYPOINT);
    while (GetIsObjectValid(oWaypoint))
    {
       sWaypoint = GetTag(oWaypoint);
       if(sWaypoint=="MOTHWAYPRINT")
          {
           nCheck=TRUE;
          }
      oWaypoint = GetNextObjectInShape(SHAPE_SPHERE, fSize, lWaypoint, FALSE,OBJECT_TYPE_WAYPOINT);
    }
    if(nCheck==FALSE)
    {
     return FALSE;
    }
    else return TRUE;
}
//Tracks the PC's movement by placing a waypoint at the players feet each HB
void MothHeartbeatTracking(object oPlayer)
{
    if(GetIsDM(oPlayer)){return;}
    if(GetHasFeat(FEAT_TRACKLESS_STEP,oPlayer)){return;}
    location lFootprint = GetLocation(oPlayer);
    if(MothAlreadyPrint(lFootprint))
    {
    return;
    }
    float fDirection = GetFacing(oPlayer);
    int nFacing = FloatToInt(fDirection);
    string sRace = "Tracks";
    string sFaction = "Cleaven";
    if(GetLocalString(oPlayer,"MothSetFactionInt")=="MothAxfellMember")
    {
      sFaction = "Axfell";
    }
    string sName = GetName(oPlayer);
    object oFootPrint = CreateObject(OBJECT_TYPE_WAYPOINT,"mothwayprint",lFootprint);
    SetLocalInt(oFootPrint,"MOTHTRACKFACING",nFacing);
    SetLocalString(oFootPrint,"MOTHTRACKRACE",sRace);
    SetLocalString(oFootPrint,"MOTHTRACKFACTION",sFaction);
    SetLocalString(oFootPrint,"MOTHTRACKNAME",sName);
    DelayCommand(HoursToSeconds(12),DestroyObject(oFootPrint));
}
//Replace the waypoint with a visual footprint placeable and rename it accordingly
void MothFootprint(object oWaypoint, int nLevel, object oPlayer)
{
    location lLocation = GetLocation(oWaypoint);
    object oFootPrint = CreateObject(OBJECT_TYPE_PLACEABLE,"mothfootprint",lLocation);
    DelayCommand(HoursToSeconds(6),DestroyObject(oFootPrint));
    int nFacing = GetLocalInt(oWaypoint,"MOTHTRACKFACING");
    float fFacing = IntToFloat(nFacing);
    string sRace = GetLocalString(oWaypoint,"MOTHTRACKRACE");
    string sFaction = GetLocalString(oWaypoint,"MOTHTRACKFACTION");
    string sName = GetLocalString(oWaypoint,"MOTHTRACKNAME");
    if(GetHasFeat(FEAT_EPIC_BANE_OF_ENEMIES,oPlayer))
    {
    DelayCommand(0.1,SetName(oFootPrint,""+sName+"'s Footprints"));
    }
    else if(!GetHasFeat(FEAT_EPIC_BANE_OF_ENEMIES,oPlayer))
    {
     if(nLevel>20)
       {
        DelayCommand(0.1,SetName(oFootPrint,""+sFaction+" Footprints"));
       }
     else
       {
        DelayCommand(0.1,SetName(oFootPrint,sRace));
       }
    }
    AssignCommand(oFootPrint,SetFacing(fFacing));
}
//Fire when Tracker Tool is used.
void MothTrackerTool(object oPlayer)
{
    if(GetLocalInt(oPlayer,"MOTHTRACKTOOL1")==TRUE){return;}
    int nLevel = GetLevelByClass(CLASS_TYPE_RANGER, oPlayer);
    if(nLevel < 15)
    {
    SendMessageToPC(oPlayer,"<cðæŒ>*You need atleast Four Favored Enemies to use this Tool!*</c>");
    return;
    }
    object oArea = GetArea(oPlayer);
    if(!MothGetIsWoodland(oArea))
    {
    SendMessageToPC(oPlayer,"<cðæŒ>*This Item can only be used in a Forest!*</c>");
    return;
    }
    DelayCommand(1.0,SendMessageToPC(oPlayer,"<cðæŒ>*You search the surroundings for tracks!*</c>"));
    SetLocalInt(oPlayer,"MOTHTRACKTOOL1",TRUE);
    DelayCommand(8.0,DeleteLocalInt(oPlayer,"MOTHTRACKTOOL1"));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.5);
    object oWaypoint1 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 1);
    object oWaypoint2 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 2);
    object oWaypoint3 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 3);
    object oWaypoint4 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 4);
    if(GetIsObjectValid(oWaypoint1))
    {
    DelayCommand(3.1,MothFootprint(oWaypoint1,nLevel,oPlayer));
    DelayCommand(5.1,DestroyObject(oWaypoint1));
    }
    if(GetIsObjectValid(oWaypoint2))
    {
    DelayCommand(3.2,MothFootprint(oWaypoint2,nLevel,oPlayer));
    DelayCommand(5.2,DestroyObject(oWaypoint2));
    }
    if(GetIsObjectValid(oWaypoint3))
    {
    DelayCommand(3.3,MothFootprint(oWaypoint3,nLevel,oPlayer));
    DelayCommand(5.3,DestroyObject(oWaypoint3));
    }
    if(GetIsObjectValid(oWaypoint4))
    {
    DelayCommand(3.4,MothFootprint(oWaypoint4,nLevel,oPlayer));
    DelayCommand(5.4,DestroyObject(oWaypoint4));
    }
}
//Fire when Druids Ear is used.
void MothDruidsEar(object oPlayer)
{
    if(GetLocalInt(oPlayer,"MOTHTRACKTOOL1")==TRUE){return;}
    int nLevel = GetLevelByClass(CLASS_TYPE_DRUID, oPlayer);
    if(nLevel < 21)
    {
    SendMessageToPC(oPlayer,"<cðæŒ>*You need be an Epic Druid to use this Item!*</c>");
    return;
    }
    object oArea = GetArea(oPlayer);
    if(!MothGetIsWoodland(oArea))
    {
    SendMessageToPC(oPlayer,"<cðæŒ>*This Item can only be used in a Forest!*</c>");
    return;
    }
    SetLocalInt(oPlayer,"MOTHTRACKTOOL1",TRUE);
    DelayCommand(8.0,DeleteLocalInt(oPlayer,"MOTHTRACKTOOL1"));
    DelayCommand(1.0,SendMessageToPC(oPlayer,"<cðæŒ>*You search the surroundings for tracks!*</c>"));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,3.5);
    object oWaypoint1 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 1);
    object oWaypoint2 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 2);
    object oWaypoint3 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 3);
    object oWaypoint4 = GetNearestObjectByTag("MOTHWAYPRINT",oPlayer, 4);
    if(GetIsObjectValid(oWaypoint1))
    {
    DelayCommand(3.1,MothFootprint(oWaypoint1,1,oPlayer));
    DelayCommand(5.1,DestroyObject(oWaypoint1));
    }
    if(GetIsObjectValid(oWaypoint2))
    {
    DelayCommand(3.2,MothFootprint(oWaypoint2,1,oPlayer));
    DelayCommand(5.2,DestroyObject(oWaypoint2));
    }
    if(GetIsObjectValid(oWaypoint3))
    {
    DelayCommand(3.3,MothFootprint(oWaypoint3,1,oPlayer));
    DelayCommand(5.3,DestroyObject(oWaypoint3));
    }
    if(GetIsObjectValid(oWaypoint4))
    {
    DelayCommand(3.4,MothFootprint(oWaypoint4,1,oPlayer));
    DelayCommand(5.4,DestroyObject(oWaypoint4));
    }
}
//Run on OnEnter for all woodland areas.
void MothWoodlandEnter(object oPlayer)
{
  if(GetIsDM(oPlayer)==FALSE)
  {
   MothHeartbeatTracking(oPlayer);
   MothSpawnTracker(oPlayer);
  }
}
//Run on OnExitr for all woodland areas.
void MothWoodlandExit(object oPlayer)
{
  if(GetIsDM(oPlayer)==FALSE)
  {
   MothHeartbeatTracking(oPlayer);
   MothDespawnTracker(oPlayer);
  }
}
//void main() {}
