#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    int nDamage =  MothGetCasterLevel(OBJECT_SELF);
    if (nDamage > 18)
        nDamage = 18;
    MothDoMissileStorm(nDamage, 20, SPELL_FIREBRAND, VFX_IMP_MIRV_FLAME, VFX_IMP_FLAME_M, DAMAGE_TYPE_FIRE, TRUE, TRUE);
}




