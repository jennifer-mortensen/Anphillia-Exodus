#include "hc_inc_npccorpse"
#include "NW_I0_GENERIC"
#include "hc_inc"
#include "anph_inc"
#include "anph_db_inc"
#include "anph_xp_inc"


void main()
{
    ExecuteScript("mothlichkingdead",OBJECT_SELF);
    object oKiller = GetLastKiller();
    if(GetLocalString(oKiller, "MY_MASTER_IS") != "")
    {
        object oKillerMaster = GetMaster(oKiller);
        oKiller = oKillerMaster;
    }
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    else if(GetRacialType(OBJECT_SELF)==RACIAL_TYPE_ANIMAL)
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
        DelayCommand(30.0,SetIsDestroyable(TRUE, FALSE, TRUE));
    }
    else
    LeaveCorpse();
    AnphRewardXP (OBJECT_SELF, oKiller);
}

