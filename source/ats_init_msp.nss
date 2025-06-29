#include "ats_inc_common"
#include "ats_inc_constant"
#include "ats_config"
#include "ats_inc_skill"
#include "ats_inc_material"
#include "ats_inc_msp"

void main()
{
    object oCurrentSpawnPoint = GetObjectByTag("ATS_MSP_WP");
    int i = 0;
    while(oCurrentSpawnPoint != OBJECT_INVALID)
    {
        ATS_InitMiningSpawnConfig(oCurrentSpawnPoint);
        if(ATS_AssignMiningSpawnConfig(oCurrentSpawnPoint, GetName(oCurrentSpawnPoint)) == TRUE)
            DelayCommand(0.5*i, ATS_TriggerMiningSpawn(oCurrentSpawnPoint));
        oCurrentSpawnPoint = GetObjectByTag("ATS_MSP_WP", ++i);
    }
}
