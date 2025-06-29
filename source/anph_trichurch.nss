void main()
{
int nSpell = SPELL_BLESS;
object oTarget = GetPCSpeaker();
int nMetaMagic=METAMAGIC_ANY ;
int bCheat=TRUE;
int nDomainLevel=40 ;
int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT;
int bInstantSpell=FALSE;
   DelayCommand(2.0, ActionCastSpellAtObject(nSpell,oTarget,nMetaMagic ,bCheat , nDomainLevel, nProjectilePathType, bInstantSpell));

}
