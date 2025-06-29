void main()
{
    object oDM = GetLastSpeaker ();
    object oPC;

    oPC = GetLocalObject (oDM, "xpwand_target");

    if (GetIsPC (oPC))
    {
        SendMessageToPC (oPC, "You have been penalized for your lack of roleplay.");
        GiveXPToCreature (oPC, -50);
    }
}
