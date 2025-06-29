#include "hc_inc"
#include "anph_inc"

void main()
{
    object oDC = OBJECT_SELF;
    object oItem;
    int bFoundToken = FALSE;
    string sTag;

    /* If the corpse doesn't have the token
       in it, destroy it */
    oItem = GetFirstItemInInventory (oDC);
    while (GetIsObjectValid (oItem))
    {
        sTag = GetTag (oItem);
        if (sTag == "PlayerCorpse")
        {
            bFoundToken = TRUE;
        }
        oItem = GetNextItemInInventory (oDC);
    }
    if (bFoundToken == FALSE)
    {
        oItem = GetFirstItemInInventory (oDC);
        WriteTimestampedLogEntry ("Destroying corpse for player " +
                                  GetLocalString (oDC, "Name") +
                                  " because token is not in it.");
        DestroyObject (oItem);
        DestroyObject (oDC);
        return;
    }

    object oOwner = AnphFindPlayerByKey (GetLocalString (oDC, "Name"),
                                         GetLocalString (oDC, "Key"));

    if (GetIsObjectValid (oOwner))
    {
        if (GetLocalInt (oOwner, "DiedButNotInFugue") == 1)
        {
            return;
        }

        if (GetTag (GetArea (oOwner)) == "")
        {
            return;
        }

        object oSign = GetNearestObjectByTag ("FugueMarker", oOwner);
        if (!GetIsObjectValid (oSign))
        {
            oItem = GetFirstItemInInventory (oDC);
            WriteTimestampedLogEntry ("Destroying corpse for player " +
                                      GetLocalString (oDC, "Name") +
                                      " because player is not in fugue.");
            DestroyObject (oItem);
            DestroyObject (oDC);
        }
    }
}
