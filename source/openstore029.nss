#include "moth_inc"
void main()
{
    object oStore = GetNearestObjectByTag("DispelShop");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        MothOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
