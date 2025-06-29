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
    MothDoMissileStorm(nDamage, 20, SPELL_BALL_LIGHTNING, VFX_IMP_MIRV_ELECTRIC, VFX_IMP_LIGHTNING_S, DAMAGE_TYPE_ELECTRICAL, TRUE, TRUE);
}
