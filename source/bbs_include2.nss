void MothDeleteEntry(object oBBS, int i, int TotalItems)
{
  for(i = 1; i <= TotalItems; i++)
  {
  SetLocalString(oBBS,"#P"+IntToString(i),
  GetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + IntToString(i)));
  SetLocalString(oBBS,"#D"+IntToString(i),
  GetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + IntToString(i)));
  SetLocalString(oBBS,"#T"+IntToString(i),
  GetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + IntToString(i)));
  SetLocalString(oBBS,"#M"+IntToString(i),
  GetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + IntToString(i)));
  }
}
void MothDeleteEntry2(object oBBS, int iLoop, int TotalItems, int CurrentEntry)
{
  for (iLoop = CurrentEntry; iLoop < TotalItems; iLoop++)
  {
    SetLocalString(oBBS,"#P"+IntToString(iLoop),
    GetLocalString(oBBS, "#P" + IntToString(iLoop + 1)));
    SetLocalString(oBBS,"#D"+IntToString(iLoop),
    GetLocalString(oBBS, "#D" + IntToString(iLoop + 1)));
    SetLocalString(oBBS,"#T"+IntToString(iLoop),
    GetLocalString(oBBS, "#T" + IntToString(iLoop + 1)));
    SetLocalString(oBBS,"#M"+IntToString(iLoop),
    GetLocalString(oBBS, "#M" + IntToString(iLoop + 1)));
  }
}
//void main() {}
