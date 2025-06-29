const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;
#include "x2_inc_switches"
#include "x0_i0_spells"
void main()
{
    int nBonus = GetLocalInt(OBJECT_SELF,"MOTHOAKLVL");
    int nAB = nBonus/10;
    int nDamage = 4 + nAB;
    // Pure Bonus, added 07/02/2010. Thonil.
    //J. Persinne, Feb. 11 2010; revised this a bit: ents now receive the intended damage bonus (+4, not +12), and all pure druids, regardless of level, will receive the pure druid bonuses to their ent.
    object oCaster = GetLocalObject(OBJECT_SELF, "MY_MASTER");
    if(GetLevelByClass(CLASS_TYPE_DRUID, oCaster) == GetHitDice(oCaster))
    {
        nAB += 3;
        nDamage += 1;
    }
    nDamage = IPGetDamageBonusConstantFromNumber(nDamage);
    int nHP = nBonus*5;
    location lTarget1 = GetLocation(OBJECT_SELF);
    effect eVis1 = EffectVisualEffect(137);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis1,lTarget1,180.0);
    DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis1,lTarget1,180.0));
    DelayCommand(6.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis1,lTarget1,180.0));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(471),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_FLIES),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamage,DAMAGE_TYPE_ACID),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamage,DAMAGE_TYPE_SLASHING),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamage,DAMAGE_TYPE_NEGATIVE),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(nDamage,DAMAGE_TYPE_PIERCING),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackIncrease(3+nAB),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(nHP),OBJECT_SELF);
    PlayAnimation(ANIMATION_FIREFORGET_TAUNT);
    PlaySound("c_treant_bat1");
    DelayCommand(0.1,PlaySound("c_treant_bat1"));
    string sTag;
    object oNPC;
    int nSpecEvent = GetLocalInt(OBJECT_SELF,"X2_USERDEFINED_ONSPAWN_EVENTS");
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    sTag=GetLocalString(OBJECT_SELF,"X3_HORSE_OWNER_TAG");
    if (GetStringLength(sTag)>0)
    {
        oNPC=GetNearestObjectByTag(sTag);
        if (GetIsObjectValid(oNPC)&&GetObjectType(oNPC)==OBJECT_TYPE_CREATURE)
        {
            AddHenchman(oNPC);
        }
        else
        {
            oNPC=GetObjectByTag(sTag);
            if (GetIsObjectValid(oNPC)&&GetObjectType(oNPC)==OBJECT_TYPE_CREATURE)
            {
                AddHenchman(oNPC);
            }
            else
            {
                DeleteLocalString(OBJECT_SELF,"X3_HORSE_OWNER_TAG");
            }
        }
    }
    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }
}
