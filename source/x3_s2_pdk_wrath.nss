#include "x0_i0_spells"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    if(!LineOfSightObject(oPC,oTarget)){return;}
    if (oPC == oTarget)
    {
         SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot target yourself using this ability</c>");
         IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_WRATH);
         return;
    }
    if(MothGetIsFortAlly(oTarget)==TRUE)
    {
         SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot target an ally using this ability</c>");
         IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_WRATH);
         return;
    }
    if(GetObjectType(oTarget)!=OBJECT_TYPE_CREATURE)
    {
         SendMessageToPC(oPC, "<c¥¥¥>[Server] You cannot target an object</c>");
         IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_WRATH);
         return;
    }
    if (GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, OBJECT_SELF) >= 10)
    {
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartWrath")==0)
          {
          int nChamp =1;
          IncrementRemainingFeatUses(OBJECT_SELF,FEAT_PDK_WRATH);
          FloatingTextStringOnCreature("<c“pØ>*Epic Purple Dragon Knight. First Oath of Wrath is a free action!*</c>",OBJECT_SELF);
          SetLocalInt(OBJECT_SELF,"MothPDKStartWrath",nChamp);
          }
        if(GetLocalInt(OBJECT_SELF,"MothPDKStartWrath")>=1)
          {
          }
    }
    int nRace = GetRacialType(oTarget);
    int nClass = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT, oPC);
    int nChr = GetAbilityModifier(ABILITY_CHARISMA);
    int nDur = (nChr*5)+1;
    int nBonus = nChr;
    string sString = "<c“pØ>this creature type</c>";
    effect eAttack = EffectAttackIncrease(nBonus);
    effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_4, DAMAGE_TYPE_BLUDGEONING);
    effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL, nBonus);
    effect eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus);
    eAttack = VersusRacialTypeEffect(eAttack, nRace);
    eDamage = VersusRacialTypeEffect(eDamage, nRace);
    eSave = VersusRacialTypeEffect(eSave, nRace);
    eSkill = VersusRacialTypeEffect(eSkill, nRace);
    eAttack = ExtraordinaryEffect(eAttack);
    eDamage = ExtraordinaryEffect(eDamage);
    eSave = ExtraordinaryEffect(eSave);
    eSkill = ExtraordinaryEffect(eSkill);
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 809, FALSE));
    RemoveEffectsFromSpell(oPC, 809);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oPC, RoundsToSeconds(nDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage, oPC, RoundsToSeconds(nDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSave, oPC, RoundsToSeconds(nDur));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSkill, oPC, RoundsToSeconds(nDur));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_OATH), oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PDK_WRATH), oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_GOOD_HELP), oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_EVIL_HELP), oPC);
    FloatingTextStringOnCreature("<c“pØ>*Your wrath is directed towards </c>"+sString+"<c“pØ>!*</c>",OBJECT_SELF);
}
