#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

void main()
{
    SetListenPattern(OBJECT_SELF, "**", 777);
    SetListening(OBJECT_SELF, TRUE);
    object oSpeaker = GetLocalObject(OBJECT_SELF, "ats_sw_activator");
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),
                        OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneGhost(),
                        OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED),
                        OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTrueSeeing(),
                        OBJECT_SELF);
    FloatingTextStringOnCreature("<cþÞ >*You have 2 minutes to speak a new name for your Item.</c>", oSpeaker);
    DelayCommand(120.0, SetLocalString(oSpeaker, "moth_sw_novalue",""));
    DelayCommand(120.0, AssignCommand(oSpeaker, ActionResumeConversation()));
    DelayCommand(120.0, DestroyObject(OBJECT_SELF));
}


