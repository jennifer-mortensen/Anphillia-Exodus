void main()
{
object oTarget = GetPCSpeaker();
int nSpell = SPELL_PRAYER;
int nMetaMagic=METAMAGIC_ANY ;
int bCheat=TRUE;
int nDomainLevel=40 ;
int nProjectilePathType=PROJECTILE_PATH_TYPE_DEFAULT;
int bInstantSpell=FALSE;
   if(GetGold(oTarget)>499)
   {
   TakeGoldFromCreature(500,oTarget,TRUE);
   DelayCommand(2.0, ActionCastSpellAtObject(nSpell,OBJECT_SELF,nMetaMagic ,bCheat , nDomainLevel, nProjectilePathType, bInstantSpell));
   }
}
