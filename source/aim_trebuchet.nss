void main()
{
    string sFaction = GetLocalString(OBJECT_SELF, "faction");
    object trebuchet = GetObjectByTag(sFaction + "trebuchet");
    object oUser = GetLastUsedBy();
    if(GetIsObjectValid(trebuchet))
    {
        string sTarget = GetLocalString(trebuchet, "target");
        string feedback = "<c þþ>*Trebuchet now aiming towards the ";

        if(sTarget == "left")
        {
            sTarget = "gate";
            feedback += "enemey gate!*</c>";
        }
        else if(sTarget == "gate")
        {
            sTarget = "right";
            feedback += "right battlements!*</c>";
        }
        else if(sTarget == "right")
        {
            sTarget = "left";
            feedback += "left battlements!*</c>";
        }

        SetLocalString(trebuchet, "target", sTarget);
        FloatingTextStringOnCreature(feedback,oUser,FALSE);
    }
}
