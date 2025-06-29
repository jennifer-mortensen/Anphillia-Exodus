void main()
{
  object oPC = GetPCSpeaker();
  if(GetPhenoType(oPC)==PHENOTYPE_NORMAL)
    {
      SetPhenoType(PHENOTYPE_BIG,oPC);
    }
  else if(GetPhenoType(oPC)==PHENOTYPE_BIG)
    {
      SetPhenoType(PHENOTYPE_NORMAL,oPC);
    }
  else
    {
    return;
    }
}
