void main()
{
object oPC = GetEnteringObject();
object oCaster = GetObjectByTag("serisbeamertwo");
object oTarget = GetObjectByTag("serisbeamerthree");
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CALL_LIGHTNING, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
}
