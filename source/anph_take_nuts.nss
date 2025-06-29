#include "_inc_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oNuts = GetFirstItemInInventory(oPC);
    object oPartyMember;
    int nNutsTurnedIn;
    int nTotalReward;
    int nPartyMembers = 1;

    while(oNuts != OBJECT_INVALID) //Delete all nuts, and count the total the PC had.
    {
        if(GetTag(oNuts) == "magicnuts")
        {
            DestroyObject(oNuts);
            nNutsTurnedIn++;
        }
        oNuts = GetNextItemInInventory(oPC);
    }

    nTotalReward = 1000 * nNutsTurnedIn;

    oPartyMember = GetFirstFactionMember(oPC);
    while(oPartyMember != OBJECT_INVALID) //Find the total member of party members in the area of the PC speaker so we know how many ways to split the reward.
    {
        if(oPartyMember != oPC && GetArea(oPartyMember) == GetArea(oPC))
            nPartyMembers++;
        oPartyMember = GetNextFactionMember(oPC);
    }

    oPartyMember = GetFirstFactionMember(oPC);
    while(oPartyMember != OBJECT_INVALID) //Hand out the reward to all party members in the area.
    {
        if(GetArea(oPartyMember) == GetArea(oPC))
        {
            GiveGoldToCreature(oPartyMember, nTotalReward / nPartyMembers);
            GiveVirtualXPToCreature(oPartyMember, nTotalReward / nPartyMembers);
        }
        oPartyMember = GetNextFactionMember(oPC);
    }
}

