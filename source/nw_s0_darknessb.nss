#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "_inc_gen"
#include "_inc_subrace"
void main()
{
    object oCaster = GetAreaOfEffectCreator();
    int nRounds;
    effect eStun = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_DUR_BLIND);
    object oTarget;
    object oCreator;
    float fDelay;
    int nDC = MothFogDC()+4;
    int nHostile = SPELL_TARGET_STANDARDHOSTILE;
    if(
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DRIDER_MALE) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DRIDER_FEMALE) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DRIDER_MALE_EPIC) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DRIDER_FEMALE_EPIC) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DROW_MALE) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DROW_FEMALE) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DROW_MALE_EPIC) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_DROW_FEMALE_EPIC) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_MALE_EPIC) ||
                GetIsPolymorphType(oCaster, ANPH_POLYMORPH_TYPE_KOBOLD_COMMANDO_FEMALE_EPIC))
    {
      nDC = nDC+11;
    }
    if (!GetIsObjectValid(oCaster))
    {
        DestroyObject(OBJECT_SELF);
        return;
    }
    if (!GetIsPC(oCaster))
    {
        nHostile = SPELL_TARGET_SELECTIVEHOSTILE;
    }
    oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
          if(spellsIsTarget(oTarget, nHostile, oCaster) && !GetIfLightBlindnessApplies(oTarget))
          {
            SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_DARKNESS));
            if(!MyResistSpell(oCaster, oTarget))
            {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_SPELL,oCaster))
                    {
                        if (GetIsImmune(oTarget, IMMUNITY_TYPE_BLINDNESS) == FALSE)
                        {
                            nRounds = 3;
                            fDelay = GetRandomDelay(0.75, 1.75);
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nRounds)));
                        }
                    }
            }
         }
        oTarget = GetNextInPersistentObject();
    }
}
