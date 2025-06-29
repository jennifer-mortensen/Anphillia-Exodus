#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "nw_i0_generic"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPlayer = OBJECT_SELF;
    object oWaypoint1 = OBJECT_INVALID;
    object oWaypoint2 = OBJECT_INVALID;
    object oWaypoint3 = OBJECT_INVALID;
    object oWaypoint4 = OBJECT_INVALID;
    object oWaypoint5 = OBJECT_INVALID;
    object oWaypoint6 = OBJECT_INVALID;
    int nCasterLvl = MothGetCasterLevel(oPlayer);
    effect eStrike1 = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
    effect eStrike2 = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    effect eStrike3 = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eStrike = EffectLinkEffects(eStrike1,eStrike2);
    eStrike = EffectLinkEffects(eStrike, eStrike3);
    location lLocation = GetLocation(oPlayer);
    string sFaction = "Axfell";
    if(MothHasItem(oPlayer, "cleavenmilitiari"))
    {
      sFaction = "Cleaven";
    }
    if (nCasterLvl <= 19)
    {
    oWaypoint1 = GetNearestObjectByTag("DeathCorpse",oPlayer, 1);
    oWaypoint2 = GetNearestObjectByTag("DeathCorpse",oPlayer, 2);
    }
    else if (nCasterLvl <= 29)
    {
    oWaypoint1 = GetNearestObjectByTag("DeathCorpse",oPlayer, 1);
    oWaypoint2 = GetNearestObjectByTag("DeathCorpse",oPlayer, 2);
    oWaypoint3 = GetNearestObjectByTag("DeathCorpse",oPlayer, 3);
    }
    else if (nCasterLvl <= 39)
    {
    oWaypoint1 = GetNearestObjectByTag("DeathCorpse",oPlayer, 1);
    oWaypoint2 = GetNearestObjectByTag("DeathCorpse",oPlayer, 2);
    oWaypoint3 = GetNearestObjectByTag("DeathCorpse",oPlayer, 3);
    oWaypoint4 = GetNearestObjectByTag("DeathCorpse",oPlayer, 4);
    }
    else
    {
    oWaypoint1 = GetNearestObjectByTag("DeathCorpse",oPlayer, 1);
    oWaypoint2 = GetNearestObjectByTag("DeathCorpse",oPlayer, 2);
    oWaypoint3 = GetNearestObjectByTag("DeathCorpse",oPlayer, 3);
    oWaypoint4 = GetNearestObjectByTag("DeathCorpse",oPlayer, 4);
    oWaypoint5 = GetNearestObjectByTag("DeathCorpse",oPlayer, 5);
    oWaypoint6 = GetNearestObjectByTag("DeathCorpse",oPlayer, 6);
    }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLocation);
    SignalEvent(oPlayer, EventSpellCastAt(oPlayer, GetSpellId(),FALSE));
    if(GetIsObjectValid(oWaypoint1) && GetLocalString(oWaypoint1, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint1,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    if(GetIsObjectValid(oWaypoint2) && GetLocalString(oWaypoint2, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint2,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    if(GetIsObjectValid(oWaypoint3) && GetLocalString(oWaypoint3, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint3,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    if(GetIsObjectValid(oWaypoint4) && GetLocalString(oWaypoint4, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint4,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    if(GetIsObjectValid(oWaypoint5) && GetLocalString(oWaypoint5, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint5,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
    if(GetIsObjectValid(oWaypoint6) && GetLocalString(oWaypoint6, "Faction") == sFaction)
    {
      ActionCastSpellAtObject(SPELL_RESURRECTION,oWaypoint6,METAMAGIC_ANY,TRUE,40,PROJECTILE_PATH_TYPE_DEFAULT,TRUE);
    }
}

