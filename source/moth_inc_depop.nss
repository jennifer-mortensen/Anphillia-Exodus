int GetIsListValid(string sList);
object GetHeadLink(string sList);
object GetTailLink(string sList);
int GetLinkTotal(string sList);
object GetNextLink(object oLink, string sList);
object GetLastLink(object oLink, string sList);
int GetLinkPosition(object oLink, string sList);
int GetIsLinkValid(object oLink, string sList);
void AddLink(object oLink, string sList);
void RemoveLink(object oLink, string sList);
void MakeCircular(string sList);
object GetLink(int iLink, string sList);
void InsertLinkAfter(object oLink, string sList, object oLocation);
void InsertLinkBefore(object oLink, string sList, object oLocation);
void InsertLink(object oLink, string sList, int iLocation);
int GetIsListValid(string sList)
{
    object oList = GetLocalObject(GetModule(), sList);
    return GetIsObjectValid(oList);
}
object GetHeadLink(string sList)
{
    object oHead = GetLocalObject(GetModule(), sList);
    return oHead;
}
object GetTailLink(string sList)
{
    object oHead = GetLocalObject(GetModule(), sList);
    object oTail = GetLocalObject(oHead, sList + "TAIL");
    return oTail;
}
int GetLinkTotal(string sList)
{
    object oHead = GetLocalObject(GetModule(), sList);
    int iTotal = GetLocalInt(oHead, sList + "TOTAL");
    return iTotal;

}
object GetNextLink(object oLink, string sList)
{
    object oNext = GetLocalObject(oLink, sList + "NEXT");
    return oNext;
}
object GetLastLink(object oLink, string sList)
{
    object oLast = GetLocalObject(oLink, sList + "LAST");
    return oLast;

}
int GetLinkPosition(object oLink, string sList)
{
    object oSearch = GetHeadLink(sList);
    int iPosition;
    int iTotal = GetLinkTotal(sList);
    for(iPosition=1;iPosition<=iTotal;iPosition++)
    {
        if(oSearch==oLink) return iPosition;
    oSearch = GetNextLink(oSearch, sList);
    }
    return 0;
}
int GetIsLinkValid(object oLink, string sList)
{
    if(GetLinkPosition(oLink, sList)) return 1;
    else return 0;
}
void AddLink(object oLink, string sList)
{
    if(!GetIsObjectValid(oLink)) return;
    if(GetIsLinkValid(oLink, sList)) return;
    object oHead = GetHeadLink(sList);
    object oTail = GetTailLink(sList);
    if(GetIsObjectValid(oHead))
        {
            SetLocalObject(oTail, sList + "NEXT", oLink);
            SetLocalObject(oLink, sList + "LAST", oTail);
            SetLocalObject(oHead, sList + "TAIL", oLink);
            int iTotal = GetLocalInt(oHead, sList + "TOTAL");
            iTotal = iTotal + 1;
            SetLocalInt(oHead, sList + "TOTAL", iTotal);
        }
    else{
            SetLocalObject(oLink, sList + "TAIL", oLink);
            SetLocalObject(GetModule(), sList, oLink);
            SetLocalInt(oLink, sList + "TOTAL", 1);
        }
}
void RemoveLink(object oLink, string sList)
{
    if(!GetIsObjectValid(oLink)) return;
    if(!GetIsLinkValid(oLink, sList)) return;
    object oNext = GetNextLink(oLink, sList);
    object oLast = GetLastLink(oLink, sList);
    object oHead = GetHeadLink(sList);
    object oTail = GetTailLink(sList);
    int iTotal   = GetLinkTotal(sList);
    iTotal = iTotal - 1;
    SetLocalInt(oHead, sList + "TOTAL", iTotal);
    SetLocalObject(oNext, sList + "LAST", oLast);
    SetLocalObject(oLast, sList + "NEXT", oNext);
    if(oLink==oTail)    SetLocalObject(oHead, sList + "TAIL", oLast);
    if(oLink==oHead){
        SetLocalObject(GetModule(), sList, oNext);
        SetLocalObject(oNext, sList + "TAIL", oTail);
        SetLocalInt(oNext, sList + "TOTAL", iTotal);}
    DeleteLocalObject(oLink, sList + "NEXT");
    DeleteLocalObject(oLink, sList + "LAST");
}
void MakeCircular(string sList)
{
    object oHead = GetHeadLink(sList);
    object oTail = GetTailLink(sList);
    SetLocalObject(oHead, sList + "LAST", oTail);
    SetLocalObject(oTail, sList + "NEXT", oHead);
}
object GetLink(int iLink, string sList)
{
    object oLink = GetHeadLink(sList);
    int iFind;
    for(iFind=1;iLink>iFind;iFind++)oLink = GetNextLink(oLink, sList);
    return oLink;
}
void InsertLinkAfter(object oLink, string sList, object oLocation)
{
    if(!GetIsObjectValid(oLink)) return;
    if(GetIsLinkValid(oLink, sList)) return;
    if(!GetIsListValid(sList)) return;
    object oNextLink = GetNextLink(oLocation, sList);
    object oTail = GetTailLink(sList);
    if(oTail == oLocation) AddLink(oLink, sList);
    else
    {
        SetLocalObject(oLocation, sList + "NEXT", oLink);
        SetLocalObject(oLink, sList + "LAST", oLocation);
        SetLocalObject(oLink, sList + "NEXT", oNextLink);
        SetLocalObject(oNextLink, sList + "LAST", oLink);
        object oHead = GetLocalObject(GetModule(), sList);
        int iTotal = GetLocalInt(oHead, sList + "TOTAL");
        iTotal = iTotal + 1;
        SetLocalInt(oHead, sList + "TOTAL", iTotal);
    }
}
void InsertLinkBefore(object oLink, string sList, object oLocation)
{
    if(!GetIsObjectValid(oLink)) return;
    if(GetIsLinkValid(oLink, sList)) return;
    if(!GetIsListValid(sList)) return;
    object oLastLink = GetLastLink(oLocation, sList);
    object oHead = GetHeadLink(sList);
    if(oHead == oLocation)
    {
        SetLocalObject(oLastLink, sList + "NEXT", oLink);
        SetLocalObject(oLink, sList + "LAST", oLastLink);
        SetLocalObject(oLink, sList + "NEXT", oLocation);
        SetLocalObject(oLocation, sList + "LAST", oLink);
        object oHead = GetLocalObject(GetModule(), sList);
        int iTotal = GetLocalInt(oHead, sList + "TOTAL");
        iTotal = iTotal + 1;
        SetLocalInt(oLink, sList + "TOTAL", iTotal);
        object oTail = GetTailLink(sList);
        SetLocalObject(oLink, sList + "TAIL", oTail);
        SetLocalObject(GetModule(), sList, oLink);
        DeleteLocalObject(oHead, sList + "TAIL");
        DeleteLocalInt(oHead, sList + "TOTAL");
    }
    else
    {
        SetLocalObject(oLastLink, sList + "NEXT", oLink);
        SetLocalObject(oLink, sList + "LAST", oLastLink);
        SetLocalObject(oLink, sList + "NEXT", oLocation);
        SetLocalObject(oLocation, sList + "LAST", oLink);
        object oHead = GetLocalObject(GetModule(), sList);
        int iTotal = GetLocalInt(oHead, sList + "TOTAL");
        iTotal = iTotal + 1;
        SetLocalInt(oHead, sList + "TOTAL", iTotal);
    }
}
void InsertLink(object oLink, string sList, int iLocation)
{
    object oLocation = GetLink(iLocation, sList);
    InsertLinkAfter(oLink, sList, oLocation);
}
//void main(){}
