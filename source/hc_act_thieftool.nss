#include "hc_text_activate"
void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");
    string sItemTag=GetLocalString(oUser,"TAG");
    DeleteLocalString(oUser,"TAG");
    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");
        if (GetDistanceBetweenLocations(GetLocation(oUser),
                GetLocation(oOther)) > FeetToMeters(10.0))
            SendMessageToPC(oUser, MOVECLOSER);
        else
        {
            DestroyObject(oItem);
            SendMessageToPC(oUser, TOOLBREAK);
        }
}
