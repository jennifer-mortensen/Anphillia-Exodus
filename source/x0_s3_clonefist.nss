#include "nw_i0_generic"
#include "moth_inc_spell2"
#include "x2_inc_spellhook"
void FakeHB(int nLevel)
{
    int nExplode = GetLocalInt(OBJECT_SELF, "X0_L_MYTIMERTOEXPLODE");
    int nCountdown = nLevel/2 + 5;
    object oMaster = GetLocalObject(OBJECT_SELF, "X0_L_MYMASTER");
    if (nExplode == nCountdown)
    {
        ClearAllActions();
        PlayVoiceChat(VOICE_CHAT_GOODBYE);
        DestroyObject(OBJECT_SELF, 0.5);
        SetCommandable(FALSE);
        return;
    }
    else
    {
        if(GetIsResting(oMaster))
        {
         DestroyObject(OBJECT_SELF, 0.5);
        }
        object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oMaster, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        if (GetIsObjectValid(oEnemy) )
        {
            DetermineCombatRound(oEnemy);
        }
        SetListening(OBJECT_SELF, FALSE);
        ActionMoveToObject(GetLocalObject(OBJECT_SELF, "X0_L_MYMASTER"), TRUE);
        SetLocalInt(OBJECT_SELF, "X0_L_MYTIMERTOEXPLODE", nExplode + 1);
        DelayCommand(2.0, FakeHB(nLevel));
    }
}
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget = GetSpellTargetObject();
    object oAxfell = GetObjectByTag("MOTHAXFELLHOLDER");
    object oCleaven = GetObjectByTag("MOTHCLEAVENHOLDER");
    object oAxfell2 = GetObjectByTag("MOTHAXFELL2HOLDER");
    object oCleaven2 = GetObjectByTag("MOTHCLEAVEN2HOLDER");
    object oCaster = OBJECT_SELF;
    int nLevel = MothGetCasterLevel(oCaster);
    object oFireGuy;
    int nAssociateType = GetAssociateType(oTarget); //J. Persinne; spell altered not to work on dominated creatures or henchmen in order to prevent all sorts of messy bugs.
    if(MothGetIsAssociate(oTarget) && !MothGetIsFortAlly(oTarget) && nAssociateType != ASSOCIATE_TYPE_DOMINATED && nAssociateType != ASSOCIATE_TYPE_HENCHMAN)
    {
       if(!MySavingThrow(SAVING_THROW_WILL, oTarget, MothDC(), SAVING_THROW_TYPE_SPELL, OBJECT_SELF))
       {
       oFireGuy = CopyObject(oTarget, GetLocation(oTarget), OBJECT_INVALID, GetName(oTarget) + "CLONEFROMFISTS");
       }
       else return;
    }
    else if(MothGetIsAssociate(oTarget) && MothGetIsFortAlly(oTarget) && nAssociateType != ASSOCIATE_TYPE_DOMINATED && nAssociateType != ASSOCIATE_TYPE_HENCHMAN)
    {
       oFireGuy = CopyObject(oTarget, GetLocation(oTarget), OBJECT_INVALID, GetName(oTarget) + "CLONEFROMFISTS");
    }
    else
    {
      SendMessageToPC(oCaster, "<cеее>[Server] Invalid Target. Target must be an animal companion, familiar, or summon!</c>");
      return;
    }
    ChangeToStandardFaction(oFireGuy, STANDARD_FACTION_COMMONER);
    SetPCLike(oCaster, oFireGuy);
    if(GetLocalString(oCaster,"MothSetFactionInt")=="MothAxfellMember")
    {
     AdjustReputation(oFireGuy,oAxfell2,100);
     AdjustReputation(oFireGuy,oAxfell,100);
     AdjustReputation(oFireGuy,oCleaven2,-100);
     AdjustReputation(oFireGuy,oCleaven,-100);
    }
    else if(GetLocalString(oCaster,"MothSetFactionInt")=="MothCleavenMember")
    {
     AdjustReputation(oFireGuy,oAxfell2,-100);
     AdjustReputation(oFireGuy,oAxfell,-100);
     AdjustReputation(oFireGuy,oCleaven2,100);
     AdjustReputation(oFireGuy,oCleaven,100);
    }
    SetLocalInt(oFireGuy, "X0_L_MYTIMERTOEXPLODE",1);
    SetLocalObject(oFireGuy, "X0_L_MYMASTER", oCaster);
    AssignCommand(oFireGuy, FakeHB(nLevel));
    effect eVis = EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVis, oFireGuy);
    effect eFlame = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFlame, oFireGuy);
}

