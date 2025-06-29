#include "_inc_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oHele = GetFirstItemInInventory(oPC);
    object oPartyMember;
    int nHeleTurnedIn;
    int nTotalGoldReward;
    int nTotalXPReward;
    int nPartyMembers = 1;

    while(oHele != OBJECT_INVALID) //Delete all items
    {
        if(GetTag(oHele) == "mothhellenous1")
        {
            DestroyObject(oHele);
            nHeleTurnedIn++;
        }
        oHele = GetNextItemInInventory(oPC);
    }

    nTotalGoldReward = 450 * nHeleTurnedIn;
    nTotalXPReward = 50 * nHeleTurnedIn;

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
            GiveGoldToCreature(oPartyMember, nTotalGoldReward / nPartyMembers);
            GiveVirtualXPToCreature(oPartyMember, nTotalXPReward / nPartyMembers);
        }
        oPartyMember = GetNextFactionMember(oPC);
    }

   WriteTimestampedLogEntry("Player "+GetName(oPC)+" "+GetPCPublicCDKey(oPC)+" "+GetPCPlayerName(oPC)+" returned "+IntToString(nHeleTurnedIn)+" Hellenous proof to "+GetName(OBJECT_SELF)+".");
}
