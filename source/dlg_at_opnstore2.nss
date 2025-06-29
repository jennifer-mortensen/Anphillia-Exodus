#include "moth_inc"
void main()
{
    string sStoreTag = GetLocalString(OBJECT_SELF, "MY_STORE2");
    object oStore = GetNearestObjectByTag(sStoreTag);

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        MothOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakString("Sorry, the store is closed.", TALKVOLUME_TALK);
}
