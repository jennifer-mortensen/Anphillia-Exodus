//MOTHAURACOURAGE1
//Old script hijacked for pre-epic version of ally effect of aura of courage
void main()
{
        object oTarget = GetSpellTargetObject();
        if(oTarget == OBJECT_INVALID){oTarget=OBJECT_SELF;}
        float fDuration = 38.9;
        effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
        effect eBuff = EffectImmunity(IMMUNITY_TYPE_FEAR);
        effect eBuff1 = EffectImmunity(IMMUNITY_TYPE_DAZED);
        effect eBuffAlly = EffectLinkEffects(eBuff,eBuff1);
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuffAlly, oTarget,fDuration));
        DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
}
