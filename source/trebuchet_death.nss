void main()
{

    string sFaction = GetLocalString(OBJECT_SELF, "faction");
    object aimer = GetObjectByTag(sFaction + "trebaimer");
    DestroyObject(aimer);
    object oDirt = GetObjectByTag(sFaction + "trebdirt");
    SetLocalInt(oDirt, "occupied", 0);
}
