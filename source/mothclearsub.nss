void main()
{
object oPC = GetEnteringObject();
object oTarget;
location lTarget;
SetSubRace(oPC, "");
if (GetAbilityScore(oPC, ABILITY_STRENGTH)>= 30)
    {
        oTarget = GetWaypointByTag("prisonerpoint1");
        lTarget = GetLocation(oTarget);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(lTarget));
    }
else
    {
    }
}
