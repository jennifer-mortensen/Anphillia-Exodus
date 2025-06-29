void main()
{
    object oPC = GetPCSpeaker();
    WriteTimestampedLogEntry ("Client Crafts Equipment >>> ");
    if (GetIsObjectValid(oPC))
    {
        string sCDK = GetLocalString(GetModule(), GetName(oPC) + "CDKey");
        string sPlayerName = GetLocalString(GetModule(), GetName(oPC) + "PlayerName");
        WriteTimestampedLogEntry ("Crafting Player is:" + sPlayerName +
                                  ", Handle:" + GetName(oPC)  +
                                  ", CD KEY:" + sCDK);
     }
}
