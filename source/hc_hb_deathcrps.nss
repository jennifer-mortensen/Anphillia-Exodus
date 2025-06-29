//hc_dc_heartbeat
//Archaegeo June 27, 2002
// Called by the Death Corpse itself.
// Deletes the corpse if empty and gives items back if player is alive.

#include "hc_inc"
#include "hc_inc_transfer"
#include "anph_inc"

void main()
{
    object oDC=OBJECT_SELF;
    object oOwner=GetLocalObject(oDC,"Owner");
    object oSign;

    int iVal;
    iVal = GetLocalInt (OBJECT_SELF, "count");
    iVal++;

    //ActionSpeakString("count at " + IntToString (iVal), TALKVOLUME_SHOUT);
    /*
    if (iVal >= 40)
    {
        WriteTimestampedLogEntry ("Corpse for " + GetName (oOwner) + " moving home..");
        AnphSendCorpseHome (oOwner);
        iVal = 0;
        return;
        //SendMessageToPC (oOwner, "Your corpse has been moved to the cemetary.");
    }
    */

    if(GetIsObjectValid(oOwner)==FALSE)
    {
        oOwner=GetFirstPC();
        while(GetIsObjectValid(oOwner))
        {
            if(GetName(oOwner)==GetLocalString(oDC,"Name"))
            break;
            oOwner=GetNextPC();
        }
    }
    if(GetIsObjectValid(oOwner)==FALSE) return;
// If my creator has returned to life, give his stuff back

    object oItem;
    string sTag;
    int bFoundCorpse = FALSE;

    if (GetTag(GetArea (oOwner)) == "")
    {
        return;
    }


    oSign = GetNearestObjectByTag ("FugueMarker", oOwner);
    if (!GetIsObjectValid (oSign))
    {
        string sName=GetLocalString(oDC,"Name");
        string sCDK=GetLocalString(oDC,"Key");
        object oPlayerCorpse = GetLocalObject (oMod,"PlayerCorpse"+sName+sCDK);
        DestroyObject (oPlayerCorpse);
        DestroyObject(oDC,2.0);
    }

    oItem = GetFirstItemInInventory (oDC);
    while(GetIsObjectValid(oItem))
    {
        sTag = GetTag (oItem);
        if (sTag == "PlayerCorpse")
        {
            bFoundCorpse = TRUE;
        }
        oItem = GetNextItemInInventory (oDC);
    }

    if (bFoundCorpse == FALSE)
    {
        DestroyObject (oDC);
        return;
    }
}
