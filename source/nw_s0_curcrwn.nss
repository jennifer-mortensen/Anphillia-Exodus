#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "_inc_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nLevel = MothGetCasterLevel(OBJECT_SELF);
    nLevel = nLevel*2;
    spellsCure(GetDomainAdjustedHeal(d8(6)), GetDomainAdjustedHeal(nLevel), GetDomainAdjustedHeal(48), VFX_IMP_SUNSTRIKE, VFX_IMP_HEALING_G, GetSpellId());
}

