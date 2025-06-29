void main()
{

object oPC = GetPCSpeaker();

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_MASS_HEAL, oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

}

