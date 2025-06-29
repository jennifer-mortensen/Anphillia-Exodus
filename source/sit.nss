void main()
{
  object oChair = OBJECT_SELF;
  if(GetLocalInt(GetLastUsedBy(),"HasMountExp")== TRUE)
  {
   SendMessageToPC(GetLastUsedBy(),"<cþ  >You cannot sit here while Mounted.</c>");
   return ; // does nothing if has mount
  }
  if(!GetIsObjectValid(GetSittingCreature(oChair)))
  {
    AssignCommand(GetLastUsedBy(), ActionSit(oChair));
  }
}
