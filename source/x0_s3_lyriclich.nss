void main()
{
    if (!GetHasFeat(FEAT_BARD_SONGS, OBJECT_SELF))
    {
        FloatingTextStringOnCreature("<cðøþ>*No more Bard Songs left!*</c>",OBJECT_SELF,FALSE);
        return;
    }
    DecrementRemainingFeatUses(OBJECT_SELF, FEAT_BARD_SONGS);
    PlaySound("as_cv_flute2");
    ActionCastSpellAtObject(SPELL_HORRID_WILTING, OBJECT_SELF, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

}
