// hc_bleeding - HardCore Bleeding/Death system
// Archaegeo 2002 July 2

#include "hc_inc"
#include "hc_inc_timecheck"
#include "hc_text_bleed"
#include "hc_inc_death"
#include "hc_inc_remeff"

object oPlayer;

void CheckBleed()
{
    DelayCommand (6.0, ExecuteScript ("hc_bleeding", oPlayer));
}

void SetHP(string sID, object oPlayer)
{
    SetPersistentInt(oMod,"LastHP"+sID,GetCurrentHitPoints(oPlayer));
}

void main()
{
    object oPlayer = OBJECT_SELF;


    if (GetIsObjectValid(OBJECT_SELF))
        oPlayer=OBJECT_SELF;
    else
        return;


    int iPlayerState = GPS(oPlayer);
    int iPlayerMoving=GetLocalInt(oPlayer,"MOVING");
    int iCHP=GetCurrentHitPoints(oPlayer);
    string sName=GetName(oPlayer);
    string sCDK=GetPCPublicCDKey(oPlayer);
    string sID=sName+sCDK;
    string sAreaTag=GetTag(GetArea(oPlayer));
    string sFT="FuguePlane";

    if(GetIsDM(oPlayer)) return;

    int iLHP=GetPersistentInt(oMod,"LastHP"+sID);


    if(GetLocalInt(oMod,"LIMBO") && iPlayerMoving && sAreaTag != sFT)
    {
        CheckBleed();
        return;
    }


    if( iPlayerState==PWS_PLAYER_STATE_DEAD &&
        sAreaTag == sFT)
        return;
    if( iPlayerState!=PWS_PLAYER_STATE_ALIVE &&
        iCHP >= 1 &&
        sAreaTag != sFT &&
        !GetLocalInt(oPlayer,"GHOST"))
    {
        if(iPlayerMoving)
        {
            CheckBleed();
            return;
        }
        SetPlotFlag(oPlayer,FALSE);
        //RemoveEffects(oPlayer);
        SPS(oPlayer, PWS_PLAYER_STATE_ALIVE);
        SetHP(sID, oPlayer);
        object oFR;
        if((oFR=GetItemPossessedBy(oPlayer, "fuguerobe1"))!=OBJECT_INVALID)
            DestroyObject(oFR);
        DelayCommand(0.5,hcDisabledRemove(oPlayer));
    }
    else if(iPlayerState == PWS_PLAYER_STATE_ALIVE) return;
    if( (iCHP == 0 && iPlayerState!=PWS_PLAYER_STATE_DISABLED) ||
        (iPlayerState==PWS_PLAYER_STATE_DISABLED &&
        GetLocalInt(oMod,"DR_APPLIED"+sID)==FALSE))
    {
        hcDisabledSetup(oPlayer);
        CheckBleed();
        return;
    }
    int nHour=nConv;
    int nDay=24*nConv;
    int nSSB=SecondsSinceBegin();

// Check for spontaneous healing
    if(
       ((iPlayerState == PWS_PLAYER_STATE_STABLE ||
         iPlayerState == PWS_PLAYER_STATE_STABLEHEAL) &&
        (GetPersistentInt(oMod,"LastRecCheck"+sID)+nHour) < nSSB) ||
       (iPlayerState == PWS_PLAYER_STATE_RECOVERY &&
        (GetPersistentInt(oMod,"LastRecCheck"+sID)+nDay) < nSSB)
      )
    {
        if( (iCHP > iLHP) &&
             iPlayerState != PWS_PLAYER_STATE_RECOVERY &&
             iPlayerState != PWS_PLAYER_STATE_STABLEHEAL
          )
        {
            SendMessageToPC(oPlayer, STABLERECMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLEHEAL);
            CheckBleed();
            return;
        }
        SetPersistentInt(oMod, "LastRecCheck"+sID, nSSB);
        if(d100() <= 50)
        {
            if (iPlayerState==PWS_PLAYER_STATE_STABLE)
            {
                SPS(oPlayer, PWS_PLAYER_STATE_RECOVERY);
                hcDisabledSetup(oPlayer);
                SendMessageToPC(oPlayer, RECOVERMESSAGE);
                SetHP(sID, oPlayer);
            }
            else if (iPlayerState==PWS_PLAYER_STATE_STABLEHEAL)
            {
                SPS(oPlayer, PWS_PLAYER_STATE_DISABLED);
                hcDisabledSetup(oPlayer);
                SendMessageToPC(oPlayer, DISABLEMESSAGE);
                SetHP(sID, oPlayer);
            }
            else
            {
                SendMessageToPC(oPlayer, HEALNATURAL);
                SPS(oPlayer, PWS_PLAYER_STATE_ALIVE);
            }
        }
        else
        {
            effect eDamage = EffectDamage (1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPlayer);
            SendMessageToPC(oPlayer,SLIPDEATH);
            SetHP(sID, oPlayer);

        }
    }
    else if (iPlayerState==PWS_PLAYER_STATE_DYING)
    {
// Make a stabilization check
        if(iCHP > iLHP)
        {
            SendMessageToPC(oPlayer, STABLERECMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLEHEAL);
            CheckBleed();
            return;
        }
        if (d100() <= 10)
        {
// They stabilized
            SendMessageToPC(oPlayer, STABLEMESSAGE);
            SPS(oPlayer, PWS_PLAYER_STATE_STABLE);
        }
        else
        {
// They bleed!
            SendMessageToPC(oPlayer,SLIPDEATH);
            effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
            ApplyEffectToObject( DURATION_TYPE_INSTANT, eDamage, oPlayer);
            int which = d6();
            switch (which)
            {
                case 1:
                    PlayVoiceChat (VOICE_CHAT_PAIN1, oPlayer);
                break;
                case 2:
                    PlayVoiceChat (VOICE_CHAT_PAIN2, oPlayer);
                break;
                case 3:
                    PlayVoiceChat (VOICE_CHAT_PAIN3, oPlayer);
                break;
                case 4:
                    PlayVoiceChat (VOICE_CHAT_HEALME, oPlayer);
                break;
                case 5:
                    PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPlayer);
                break;
                case 6:
                    PlayVoiceChat (VOICE_CHAT_HELP, oPlayer);
                break;
            }
            SetHP(sID, oPlayer);
        }
    }
    CheckBleed();
}
