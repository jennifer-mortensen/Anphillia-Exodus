void main()
{
    object oUser = GetLastUsedBy();
    object oDoor = GetObjectByTag("mothragnardoorlastroom");
    if(GetLocked(oDoor)==TRUE)
    {
    SetLocked(oDoor,FALSE);
    SendMessageToPC(oUser,"<cðøþ>*You pull the lever and soon after you hear a clicking sound!*</c>");
    }
    else
    {
    SendMessageToPC(oUser,"<cðøþ>*You pull the lever but nothing happens!*</c>");
    }
}
