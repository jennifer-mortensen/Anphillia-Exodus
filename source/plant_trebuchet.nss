#include "anph_inc"
void main()
{
    if(GetLocalInt(OBJECT_SELF, "occupied"))
    {
        return;
    }
    object oPC = GetLastUsedBy();
    object treb = GetItemPossessedBy(oPC, "trebuchetItem");
    if(GetIsObjectValid(treb))
    {
        string sTag = GetTag(GetArea(oPC));
        if((sTag == "SumanValley" || sTag == "SUMAN_VALLEY") && GetIsObjectValid(GetItemPossessedBy(oPC, "axfellwarriorrin")))
        {
            DestroyObject(treb);
            object newTreb = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_trebuchet001", GetLocation(OBJECT_SELF), FALSE, "cleaventrebuchet");
            SetLocalString(newTreb, "faction", "cleaven");
            SetLocalString(newTreb, "target", "gate");
            object ropec = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_ropebndle002", GetLocation(GetWaypointByTag("wp_c_trebaimer")), FALSE, "cleaventrebaimer");
            SetLocalString(ropec, "faction", "cleaven");
            SetLocalInt(OBJECT_SELF, "occupied", 1);
            object catac = CreateObject(OBJECT_TYPE_PLACEABLE, "axfellcatapult", GetLocation(GetWaypointByTag("mothaxfellcatapult")), FALSE);
            object cannonc = CreateObject(OBJECT_TYPE_PLACEABLE, "axfellcannon", GetLocation(GetWaypointByTag("mothaxfellcannon")), FALSE);
        }

        else if((sTag == "RustinRoad" || sTag == "RUSTIN_ROAD") && GetIsObjectValid(GetItemPossessedBy(oPC, "cleavenmilitiari")))
        {
            DestroyObject(treb);
            object newTreb = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_trebuchet001", GetLocation(OBJECT_SELF), FALSE, "axfelltrebuchet");
            SetLocalString(newTreb, "faction", "axfell");
            SetLocalString(newTreb, "target", "gate");
            object ropea = CreateObject(OBJECT_TYPE_PLACEABLE, "zep_ropebndle002", GetLocation(GetWaypointByTag("wp_a_trebaimer")), FALSE, "axfelltrebaimer");
            SetLocalString(ropea, "faction", "axfell");
            SetLocalInt(OBJECT_SELF, "occupied", 1);
            object cataa = CreateObject(OBJECT_TYPE_PLACEABLE, "cleavencatapult", GetLocation(GetWaypointByTag("mothcleavcatapult")), FALSE);
            object cannona = CreateObject(OBJECT_TYPE_PLACEABLE, "cleavencannon", GetLocation(GetWaypointByTag("mothcleavcannon")), FALSE);
        }

    }
}
