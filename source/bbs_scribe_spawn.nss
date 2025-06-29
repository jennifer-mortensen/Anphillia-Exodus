#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"
void main()
{
    SetListenPattern(OBJECT_SELF, "**", 777); //listen to all text
    SetListening(OBJECT_SELF, TRUE);          //be sure NPC is listening
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    GenerateNPCTreasure();     //* Use this to create a small amount of treasure on the creature
}


