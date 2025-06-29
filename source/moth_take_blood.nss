#include "_inc_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oBlood = GetFirstItemInInventory(oPC);
    object oPartyMember;
    int nBloodTurnedIn;
    int nTotalXPReward;
    int nTotalGoldReward;
    int nPartyMembers = 1;

    while(oBlood != OBJECT_INVALID) //Delete all blood, and count the total the PC had.
    {
        if(GetTag(oBlood) == "mothdragonblood")
        {
            DestroyObject(oBlood);
            nBloodTurnedIn++;
        }
        oBlood = GetNextItemInInventory(oPC);
    }

    nTotalXPReward = 100 * nBloodTurnedIn;
    nTotalGoldReward = 600 * nBloodTurnedIn;

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
   WriteTimestampedLogEntry("Player "+GetName(oPC)+" "+GetPCPublicCDKey(oPC)+" "+GetPCPlayerName(oPC)+" returned "+IntToString(nBloodTurnedIn)+" dragon blood to "+GetName(OBJECT_SELF)+".");
}

