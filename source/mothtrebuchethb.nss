void main()
{
  object oOwner = OBJECT_SELF;
  int nHBCount = GetLocalInt(oOwner, "HBCountTrebuchet");
  nHBCount++;
  SetLocalInt(oOwner, "HBCountTrebuchet", nHBCount);
  if(nHBCount > 1)
    {
     ExecuteScript("wolfonofftrebuch",oOwner);
     SetLocalInt(oOwner, "HBCountTrebuchet", 0);
    }
}
