void main()
{
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectCutsceneGhost(),OBJECT_SELF);
    DelayCommand(1.0,ActionSpeakString("READY",TALKVOLUME_TALK));
    DelayCommand(2.5,ActionSpeakString("SET",TALKVOLUME_TALK));
    DelayCommand(3.5,ActionSpeakString("GO!",TALKVOLUME_TALK));
    DelayCommand(3.6,PlayVoiceChat(VOICE_CHAT_ATTACK,OBJECT_SELF));
    DestroyObject(OBJECT_SELF,3.7);
}

