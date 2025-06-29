#include "_inc_xp"
void main()
{
    object oItem;
    object oPC = GetPCSpeaker();
    string sTag;
    int nDice;
    int nXP = 0;
    if(GetECLAdjustedHitDice(oPC)<11)
    {
     nXP = 16;
    }
    int iReward;
    oItem = GetFirstItemInInventory (oPC);
    while(GetIsObjectValid(oItem))
    {
        iReward = 58;
        sTag = GetTag (oItem);
        if (sTag == "NW_IT_MSMLMISC08")
        {
            nDice = d20(3);
            iReward = iReward + nDice;
            DestroyObject (oItem);
            GiveGoldToCreature (oPC, iReward);
            GiveXPToCreature(oPC,nXP);
        }
        oItem = GetNextItemInInventory (oPC);
    }
}
