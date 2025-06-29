#include "ats_inc_common"
#include "ats_inc_math"

void main()
{
    ATS_RemoveAllInstances("ATS_FORGE_FLAME");

    location locForge;
    location locAttachment;
    vector vAttachmentPos;
    vector vTranslate;
    float fDirection;

    int iNum = 0;
    object oCurrentForge = GetObjectByTag("ATS_FORGE_BASIC", iNum++);
    object oCurrentFlame;
    while(oCurrentForge != OBJECT_INVALID)
    {
        locForge = GetLocation(oCurrentForge);
        fDirection = ATS_CorrectDirection(GetFacing(oCurrentForge));

        vAttachmentPos = GetPositionFromLocation(locForge);
        vAttachmentPos.z += 0.5;

        vector vRelativeVector = Vector(0.25, 0.5, 0.0);
        vTranslate = ATS_Transform2DVector(vRelativeVector, fDirection);

        vAttachmentPos += vTranslate;

        locAttachment = Location( GetAreaFromLocation(locForge), vAttachmentPos,
                                  GetFacingFromLocation(locForge) );
        CreateObject(OBJECT_TYPE_PLACEABLE, "ats_flame_small", locAttachment, TRUE);
        oCurrentForge = GetObjectByTag("ATS_FORGE_BASIC", iNum++);
    }
}
