/* Use a placeable wall door. This allows for locks and traps to be
 * placed on the door and plays an animation of the user opening
 * the door.
 *
 * Works for both standard and secret doors. For standard, the tag
 * of the waypoint destination must be set to LOC_<tag of door>.
 * For secret, the waypoint should be set to LOC_<tag of detect trigger>.
 *
 * This goes in the OnUsed event handler of the actual
 * placeable door object.
 */

#include "x0_i0_secret"

void main()
{
    object oUser = GetLastUsedBy();

    // Allow for traps and locks
    if (GetIsTrapped(OBJECT_SELF)) {return;}

    if (GetLocked(OBJECT_SELF)) {
        // See if we have the key and unlock if so
        string sKey = GetTrapKeyTag(OBJECT_SELF);
        object oKey = GetItemPossessedBy(oUser, sKey);
        if (sKey != "" && GetIsObjectValid(oKey)) {
            SendMessageToPC(oUser, "<c���>"+GetStringByStrRef(7945)+"</c>");
            SetLocked(OBJECT_SELF, FALSE);
        } else {
            // Print '*locked*' message and play sound
            DelayCommand(0.1, PlaySound("as_dr_locked2"));
            FloatingTextStringOnCreature("<c���>*"
                                         + GetStringByStrRef(8307)
                                         + "*</c>",
                                         oUser);
            return;
        }
    }

    // Handle opening/closing
    if (!GetIsSecretItemOpen(OBJECT_SELF)) {
        // play animation of user opening it
        AssignCommand(oUser, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
        DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
        SetIsSecretItemOpen(OBJECT_SELF, TRUE);
    } else {
        // it's open -- go through and then close
        UseSecretTransport(GetLastUsedBy());
        //ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
        SetIsSecretItemOpen(OBJECT_SELF, FALSE);
    }
}
