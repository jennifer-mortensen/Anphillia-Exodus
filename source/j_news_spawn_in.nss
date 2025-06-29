//::///////////////////////////////////////////////
//:: Name On Spawn's - Vendor and Editor
//:: FileName j_news_spawn_in
//:://////////////////////////////////////////////
/*
    Editor listens, Vendor randomly shouts...not much else.

    Should not change.
*/
//:://////////////////////////////////////////////
//:: Created By: Jasperre
//:://////////////////////////////////////////////

#include "x0_i0_walkway"
#include "j_news_ed_inc"

void main()
{
    string sSub = GetStringLowerCase(GetTag(OBJECT_SELF));
    if(FindSubString(sSub, "vendor") >= 0)
    {
        DelayCommand(10.0, SignalEvent(OBJECT_SELF, EventUserDefined(VENDOR_UDE_NUMBER)));
        SetListeningPatterns();
        WalkWayPoints();
    }
    else
    {
        SetListening(OBJECT_SELF, TRUE);
        // Listen for all if we are not the vendor - IE the editor
        SetListenPattern(OBJECT_SELF, "**", EDITOR_LISTEN_NUMBER);
    }
}
