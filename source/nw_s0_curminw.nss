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
    spellsCure(GetDomainAdjustedHeal(d4()), GetDomainAdjustedHeal(nLevel), GetDomainAdjustedHeal(4), VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, GetSpellId());
}
