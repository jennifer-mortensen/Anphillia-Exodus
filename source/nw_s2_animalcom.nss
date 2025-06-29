//::///////////////////////////////////////////////
//:: Summon Animal Companion
//:: NW_S2_AnimalComp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell summons a Druid's animal companion
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 27, 2001
//:://////////////////////////////////////////////

void main()
{
    SummonAnimalCompanion();
    object oObject = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION);
    int nDruid = GetLevelByClass(CLASS_TYPE_DRUID);
    int nRanger = GetLevelByClass(CLASS_TYPE_RANGER);
    int nLevel = nDruid+nRanger;
    effect eSkill1 = EffectSkillIncrease(SKILL_HIDE,22);
    effect eSkill2 = EffectSkillIncrease(SKILL_MOVE_SILENTLY,22);
    effect eSkill3 = EffectSkillIncrease(SKILL_LISTEN,33);
    effect eSkill4 = EffectSkillIncrease(SKILL_SPOT,33);
    effect eRegen = EffectRegenerate(4, 6.0);
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 5);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, 2);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 5);
    if(GetRacialType(oObject) == RACIAL_TYPE_VERMIN)
    {
    eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, 7);
    }
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, 5);
    effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, 2);
    effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, 2);
    effect eAcc = EffectACIncrease(6,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect eDmg = EffectDamageIncrease(5,DAMAGE_TYPE_BLUDGEONING);
    effect eHpp = EffectTemporaryHitpoints(nDruid*3);
            effect eLink = EffectLinkEffects(eStr, eCha);
            eLink = EffectLinkEffects(eLink, eCon);
            eLink = EffectLinkEffects(eLink, eDex);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eWis);
            eLink = EffectLinkEffects(eLink, eAcc);
            eLink = EffectLinkEffects(eLink, eDmg);
            eLink = EffectLinkEffects(eLink, eSkill1);
            eLink = EffectLinkEffects(eLink, eSkill2);
            eLink = SupernaturalEffect(eLink);
            eHpp = SupernaturalEffect(eHpp);
    //Yep thats it
    SendMessageToPC(OBJECT_SELF, "<c þ >Your Diety blesses your Animal Companion!</c>");
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oObject));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oObject));
    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eHpp, oObject));
}
