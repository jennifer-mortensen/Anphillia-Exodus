#include "x2_inc_toollib"
#include "x2_inc_spellhook"
#include "_inc_summons"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oPC = OBJECT_SELF;
    location lTarget = GetSpellTargetLocation();
    int nDuration = 40;
    effect eSummon;
    MothUnsummonMultipleSummons();
    effect eVis = EffectVisualEffect(460);
    int nSummonEffect = 481;

    int nSummonType = GetLocalInt(oPC, "EDK_SUMMON_TYPE"); //J. Persinne; players can now set their EDK summon type.  It is no longer based on alignment.

    if(nSummonType == EDK_SUMMON_TYPE_RANDOM)
    {
        nSummonType = d8() + 2;
    }
    else if(nSummonType == EDK_SUMMON_TYPE_CHROMATIC)
    {
        nSummonType = d4() + 2;
    }
    else if(nSummonType == EDK_SUMMON_TYPE_METALLIC)
    {
        nSummonType = d4() + 6;
    }

    switch(nSummonType)
    {
        case 3:
            eSummon = EffectSummonCreature("edk_black", nSummonEffect, 0.0f, TRUE);
            break;
        case 4:
            eSummon = EffectSummonCreature("edk_white", nSummonEffect, 0.0f, TRUE);
            break;
        case 5:
            eSummon = EffectSummonCreature("edk_red", nSummonEffect, 0.0f, TRUE);
            break;
        case 6:
            eSummon = EffectSummonCreature("edk_blue", nSummonEffect, 0.0f, TRUE);
            break;
        case 7:
            eSummon = EffectSummonCreature("edk_copper", nSummonEffect, 0.0f, TRUE);
            break;
        case 8:
            eSummon = EffectSummonCreature("edk_silver", nSummonEffect, 0.0f, TRUE);
            break;
        case 9:
            eSummon = EffectSummonCreature("edk_gold", nSummonEffect, 0.0f, TRUE);
            break;
        case 10:
            eSummon = EffectSummonCreature("edk_bronze", nSummonEffect, 0.0f, TRUE);
            break;
    }

    eSummon = ExtraordinaryEffect(eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon,lTarget, HoursToSeconds(nDuration));
    DelayCommand(1.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis,lTarget));
}
