#include "NW_I0_SPELLS"
#include "x0_i0_spells"
void main()
{
    effect eHold = EffectEntangle();
    effect eEntangle = EffectVisualEffect(VFX_DUR_ENTANGLE);
    effect eLink = EffectLinkEffects(eHold, eEntangle);
    object oCaster = GetAreaOfEffectCreator();
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!MothGolemWalkImmunityHigh(oTarget))
         {
         if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oCaster) && !MothGetIsTargetMyPet(oCaster,oTarget))
            {
                SignalEvent(oTarget, EventSpellCastAt(oCaster, 529));
                if(!GetHasSpellEffect(SPELL_ENTANGLE, oTarget))
                {
                        int n =   MySavingThrow(SAVING_THROW_REFLEX, oTarget, MothFogDC(),SAVING_THROW_TYPE_NONE,oCaster);
                        if(n == 0)
                        {
                           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2));
                        }
                }
            }
        }
        oTarget = GetNextInPersistentObject();
    }
}
