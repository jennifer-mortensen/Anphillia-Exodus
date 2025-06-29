void main()
{
    object oUser=OBJECT_SELF;
    object oOther=GetLocalObject(oUser,"OTHER");
    object oItem=GetLocalObject(oUser,"ITEM");

    DeleteLocalObject(oUser,"ITEM");
    DeleteLocalObject(oUser,"OTHER");

    AdjustReputation (oUser, oOther, 100);

    effect eVis = EffectVisualEffect(VFX_IMP_AURA_HOLY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oOther);
}
