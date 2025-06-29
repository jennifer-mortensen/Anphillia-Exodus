#include "moth_inc"
void main()
{
    object oStore = GetNearestObjectByTag("scrapheap");

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
        MothOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakString("Sorry, the store is closed", TALKVOLUME_TALK);
}
