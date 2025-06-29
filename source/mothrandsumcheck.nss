int StartingConditional()
{
    object oPC = GetPCSpeaker();
    if(GetLocalInt(oPC,"mothrandsumcheck") == TRUE)
    {
    return TRUE;
    }
  return FALSE;
}
