#include "moth_inc"

void main()
{
    string sNPCTag = GetTag(OBJECT_SELF);
    object oStore = GetNearestObjectByTag("daron");

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        MothOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakString("Sorry, the store is closed", TALKVOLUME_TALK);
}
