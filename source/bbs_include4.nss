void MothDeleteEntry5(object oBBS, int i)
{
  SetCampaignString("DB_BBS",GetTag(oBBS)+"#P" + IntToString(i),
  GetLocalString(oBBS,"#P" + IntToString(i)));
  SetCampaignString("DB_BBS",GetTag(oBBS)+"#D" + IntToString(i),
  GetLocalString(oBBS,"#D" + IntToString(i)));
  SetCampaignString("DB_BBS",GetTag(oBBS)+"#T" + IntToString(i),
  GetLocalString(oBBS,"#T" + IntToString(i)));
  SetCampaignString("DB_BBS",GetTag(oBBS)+"#M" + IntToString(i),
  GetLocalString(oBBS,"#M" + IntToString(i)));
}
void MothSetEntry(object oBBS, int LatestItem, int TotalItems)
{
  SetCampaignInt("DB_BBS", GetTag(oBBS) + "#L", LatestItem);
  SetCampaignInt("DB_BBS", GetTag(oBBS) + "#C", TotalItems);
}
//void main() {}
