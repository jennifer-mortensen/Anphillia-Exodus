#include "hc_inc"
void main()
{
    if (GetIsObjectValid(GetItemPossessedBy(OBJECT_SELF, "BadgeOfFallen")))
    {
        return;
    }
    if(GetLocalInt(oMod,"REALFAM"))
    {
        if(GetLocalInt(oMod,"FAMDIED"+GetName(OBJECT_SELF)))
        {
            object oPC=OBJECT_SELF;
            if(GetGold(oPC) < 10)
            {
                SendMessageToPC(oPC,"<c þ >You need 10gp to pay for the materials.</c>");
                return;
            }
            TakeGoldFromCreature(10, oPC, TRUE);
        }
    }
    SummonFamiliar();
    object oObject = GetAssociate(ASSOCIATE_TYPE_FAMILIAR);
    int nBonus = 4;
    int nBonus2 = 6;
    int nAC = 4;
    int nDamage = DAMAGE_BONUS_4;
    int nDamageType = DAMAGE_TYPE_BLUDGEONING;
    int nDamageType2 = DAMAGE_TYPE_PIERCING;
    effect eSki = EffectSkillDecrease(SKILL_OPEN_LOCK,6);
    //If RDD Warlock
    if(GetAppearanceType(OBJECT_SELF) == 1032||
       GetAppearanceType(OBJECT_SELF) == 1033
    )
    {
    nBonus = 8;
    nBonus2 = 10;
    nAC = 16;
    nDamage = DAMAGE_BONUS_8;
    nDamageType = DAMAGE_TYPE_FIRE;
    nDamageType2 = DAMAGE_TYPE_MAGICAL;
    SetCreatureAppearanceType(oObject,1668);
    SetPortraitId(oObject,198);
    effect eSki1 = EffectAttackIncrease(nAC,ATTACK_BONUS_MISC);
    effect eSki2 = EffectRegenerate(4,6.0);
    eSki = EffectLinkEffects(eSki1,eSki2);
    }
    effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, nBonus);
    effect eCha = EffectAbilityIncrease(ABILITY_CHARISMA, nBonus);
    effect eCon = EffectAbilityIncrease(ABILITY_CONSTITUTION, nBonus2);
    effect eDex = EffectAbilityIncrease(ABILITY_DEXTERITY, nBonus);
    effect eInt = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nBonus);
    effect eWis = EffectAbilityIncrease(ABILITY_WISDOM, nBonus);
    effect eAcc = EffectACIncrease(nAC,AC_NATURAL_BONUS,AC_VS_DAMAGE_TYPE_ALL);
    effect eDmg = EffectDamageIncrease(nDamage,nDamageType);
    effect eDmg2 = EffectDamageIncrease(nDamage,nDamageType2);
            effect eLink = EffectLinkEffects(eStr, eCha);
            eLink = EffectLinkEffects(eLink, eCon);
            eLink = EffectLinkEffects(eLink, eDex);
            eLink = EffectLinkEffects(eLink, eInt);
            eLink = EffectLinkEffects(eLink, eWis);
            eLink = EffectLinkEffects(eLink, eAcc);
            eLink = EffectLinkEffects(eLink, eDmg);
            eLink = EffectLinkEffects(eLink, eDmg2);
            eLink = SupernaturalEffect(eLink);
            eSki = SupernaturalEffect(eSki);
    SendMessageToPC(OBJECT_SELF, "<c þ >Your Familiar draws upon your Arcane Powers!</c>");
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oObject));
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSki, oObject));
}
