#include "jhr_i0_pipe"

void main()
{
    object oActivator = GetItemActivator();
    object oActivatedItem = GetItemActivated();

    if (GetTag(oActivatedItem) == "jhr_bp_pipe")
    {
        SmokePipe(oActivator);
    }
}
