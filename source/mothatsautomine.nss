void main()
{
  object oPlayer = GetPCSpeaker();
  if(GetLocalInt(oPlayer,"MOTHAUTOMINE"))
  {
    DeleteLocalInt(oPlayer,"MOTHAUTOMINE");
    FloatingTextStringOnCreature("<cðøþ>*ATS Automining Deactivated!*</c>",oPlayer,FALSE);
    return;
  }
  if(GetLocalInt(oPlayer,"MOTHAUTOMINE")==FALSE)
  {
    SetLocalInt(oPlayer,"MOTHAUTOMINE",TRUE);
    FloatingTextStringOnCreature("<cðøþ>*ATS Automining Activated!*</c>",oPlayer,FALSE);
    return;
  }
}
