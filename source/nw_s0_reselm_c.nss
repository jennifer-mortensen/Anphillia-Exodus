#include "x0_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oScroll = GetSpellCastItem();
    if(GetIsObjectValid(oScroll))
    {
      return;
    }
    effect eAOE = EffectAreaOfEffect(6,"nw_s0_reselm_cfe","nw_s0_endelm_efb","nw_s0_prelm_ax");
    location lTarget = GetSpellTargetLocation();
    effect eImpact = EffectVisualEffect(VFX_IMP_KNOCK);
    if(MothGetIsAoEAtTargetlocation(OBJECT_SELF,lTarget,SHAPE_SPHERE,4.0))
    {
     FloatingTextStringOnCreature("<cŒŒŒ>*You cannot stack traps!*</c>",OBJECT_SELF,FALSE);
    }
    else
    {
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eAOE, lTarget);
    }
}
