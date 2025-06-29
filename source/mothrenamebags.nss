#include "NW_I0_GENERIC"
void main()
{
    int iMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (iMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        BeginConversation();
    }
    else
    if(iMatch == 777 && GetIsObjectValid(oShouter) && GetIsPC(oShouter))
    {
      if (oShouter == GetLocalObject(OBJECT_SELF, "ats_sw_activator"))
      {
        string sSaid = GetMatchedSubstring(0);
        SetLocalString(oShouter, "moth_rename_bag", sSaid);
        FloatingTextStringOnCreature("<cþÞ >*Item Name fetched: "+sSaid+"*</c>", oShouter);
        AssignCommand(oShouter, ActionResumeConversation());
        DelayCommand(1.5, DestroyObject(OBJECT_SELF));
      }
    }
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}

