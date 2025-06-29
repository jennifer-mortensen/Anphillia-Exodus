void main()
{

    object oBlessedBolt = GetSpellCastItem();
    effect eVis  = EffectVisualEffect(VFX_IMP_DEATH);
    effect eSlay = EffectLinkEffects(eVis,EffectDeath());

    if (GetIsObjectValid(oBlessedBolt) == TRUE)
    {
        object oRak = GetSpellTargetObject();
        if(GetIsPC(oRak)){return;}
        if (GetIsObjectValid(oRak) == TRUE)
        {
            int nAppear = GetAppearanceType(oRak);
            if ( nAppear  ==   APPEARANCE_TYPE_RAKSHASA_BEAR_MALE  || nAppear  ==   APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE                 ||
                 nAppear  ==   APPEARANCE_TYPE_RAKSHASA_TIGER_MALE ||  nAppear  ==   APPEARANCE_TYPE_RAKSHASA_WOLF_MALE)
            {
               ApplyEffectToObject(DURATION_TYPE_INSTANT,eSlay,oRak);
            }
            else
            {
               if (FindSubString(GetSubRace(oRak), "Rakshasa") > -1)
               {
                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eSlay,oRak);
               }
            }
        }
    }
}
