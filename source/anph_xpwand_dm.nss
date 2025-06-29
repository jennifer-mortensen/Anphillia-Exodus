int StartingConditional()
{
    object oDM = GetLastSpeaker ();
    object oTarget;

    oTarget = GetLocalObject (oDM, "xpwand_target");

    if (oDM == oTarget)
    {
        return TRUE;
    }
    return FALSE;
}
