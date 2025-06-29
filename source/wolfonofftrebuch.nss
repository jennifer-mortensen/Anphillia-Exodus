#include "x0_i0_spells"
void main()
{
    object oUser = OBJECT_SELF;
    PlaySound("zep_catapult");
    string target = GetLocalString(oUser, "faction") + GetLocalString(oUser, "target");
    object oWaypoint = GetWaypointByTag(target);
    ActionCastSpellAtLocation(773,GetLocation(oWaypoint),METAMAGIC_ANY,TRUE,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
}



