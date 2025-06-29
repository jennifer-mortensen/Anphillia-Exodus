void MothDeleteEntry3(object oBBS, int iLoop)
{
      SetLocalString(oBBS,"#P"+IntToString(iLoop+1),
      GetLocalString(oBBS, "#P" + IntToString(iLoop)));
      SetLocalString(oBBS,"#D"+IntToString(iLoop+1),
      GetLocalString(oBBS, "#D" + IntToString(iLoop)));
      SetLocalString(oBBS,"#T"+IntToString(iLoop+1),
      GetLocalString(oBBS, "#T" + IntToString(iLoop)));
      SetLocalString(oBBS,"#M"+IntToString(iLoop+1),
      GetLocalString(oBBS, "#M" + IntToString(iLoop)));
}
void MothDeleteEntry4(object oBBS, int TotalItems)
{
    SetLocalString(oBBS,"#P"+IntToString(1),
    GetLocalString(oBBS, "#P" + IntToString(TotalItems + 1)));
    SetLocalString(oBBS,"#D"+IntToString(1),
    GetLocalString(oBBS, "#D" + IntToString(TotalItems + 1)));
    SetLocalString(oBBS,"#T"+IntToString(1),
    GetLocalString(oBBS, "#T" + IntToString(TotalItems + 1)));
    SetLocalString(oBBS,"#M"+IntToString(1),
    GetLocalString(oBBS, "#M" + IntToString(TotalItems + 1)));
}
//void main() {}
