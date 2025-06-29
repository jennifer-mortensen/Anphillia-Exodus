#include "moth_inc"
void main()
{
    object oNewbiemerh = GetObjectByTag("NewbieMerchant");
    MothOpenStore(oNewbiemerh, GetLastUsedBy());
}
