void main()
{
    if(GetLocalInt(GetArea(OBJECT_SELF), "MY_PC_COUNT") == -1)
        return;

    object oAttacker = GetLastHostileActor();

    if(!GetIsObjectValid(GetAttemptedAttackTarget()))
    {
        float fDistance = GetDistanceBetween(OBJECT_SELF, oAttacker);
        if(fDistance <= 35.0 && fDistance != -1.0)
        {
            ClearAllActions();
            ActionAttack(oAttacker);
        }
    }
}
