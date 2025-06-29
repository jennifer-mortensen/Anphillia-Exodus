void main()
{
    int nBonus = GetLevelByClass(CLASS_TYPE_CLERIC);
    /*if(nBonus<6)
    {
     SendMessageToPC(OBJECT_SELF,"<cеее>[Server] You have too few Cleric levels to channel this Domain Power!</c>");
     return;
    }*/
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDC2 = GetAbilityModifier(ABILITY_CHARISMA)*2;
    int nDC = 14 + nBonus + nDC2;
    effect eSanc = EffectSanctuary(nDC);
    effect eLink = EffectLinkEffects(eVis, eSanc);
    eLink = EffectLinkEffects(eLink, eDur);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_DIVINE_PROTECTION, FALSE));
    int nDuration = 5 + GetAbilityModifier(ABILITY_CHARISMA);
    if ( nDuration < 1 )
    {
        nDuration = 1;
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}


