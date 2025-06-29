//By: mad_andrew
void main()
{
string oItem = GetTag(GetItemActivated());
object oPC = GetItemActivator();

if(oItem == "DROWDARK")
{
    location locDark = GetItemActivatedTargetLocation();
    object oTarget = GetItemActivatedTarget();
    if(GetIsObjectValid(oTarget) == TRUE)
    {
        AssignCommand(oPC, ActionCastSpellAtObject(SPELL_DARKNESS, oTarget, METAMAGIC_NONE, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }
    else
    {
        AssignCommand(oPC, ActionCastSpellAtLocation(SPELL_DARKNESS, locDark, METAMAGIC_NONE, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }

}

}
