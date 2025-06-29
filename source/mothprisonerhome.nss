void main()
{
    object oPC = GetLastUsedBy();
    string sAxfellWaypointTag = "mothjumpaxfellhome01";
    string sCleavenWaypointTag = "mothjumpcleavenhome01";
    if (GetLocalString(oPC,"MothSetFactionInt") == "MothAxfellMember")
    {
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag(sAxfellWaypointTag))));
        return;
    }
    else     if (GetLocalString(oPC,"MothSetFactionInt") == "MothCleavenMember")
    {
        AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag(sCleavenWaypointTag))));
        return;
    }
    else {AssignCommand(OBJECT_SELF, ActionSpeakString("No faction found.")); return;}
}
