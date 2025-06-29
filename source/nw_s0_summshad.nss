#include "x2_inc_spellhook"
#include "moth_inc_spell2"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oArea = GetArea(OBJECT_SELF);
    if(MothGetIsNoPvPArea(oArea))
    {
     return;
    }
    int nMeta = FALSE;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nMeta = TRUE;
    }
    location lLocation = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_DUR_DARKNESS);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis,lLocation,1.0);
    int nDC = MothDC();
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    MothSummonShadow(lLocation,GetSpellId(),nMeta);
}

