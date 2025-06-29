#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "_inc_spells"
void main()
{
   /*
      Spellcast Hook Code
      Added 2003-06-20 by Georg
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    // End of Spell Cast Hook


    //--------------------------------------------------------------------------
    // GZ: Make sure this aura is only active once
    //--------------------------------------------------------------------------
    RemoveSpellEffects(SPELL_INVISIBILITY_SPHERE,OBJECT_SELF,GetSpellTargetObject());

    RemoveSpellDamageShields();
    MothdoAura2(VFX_DUR_FLIES, VFX_DUR_PROTECTION_GOOD_MAJOR, VFX_DUR_SANCTUARY, DAMAGE_TYPE_ELECTRICAL);
}
