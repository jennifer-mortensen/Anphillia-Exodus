string GetCached2DAString(string s2DA, string sColumn, int nRow)
{
    object oModule = GetModule();
    string sVarName = "C2DA_ " + s2DA + "_" + sColumn + "_" + IntToString(nRow);

    // Fetch
    string sResult = GetLocalString(oModule, sVarName);

    if (sResult == "")
    {
        sResult = Get2DAString(s2DA, sColumn, nRow);
        SetLocalString( oModule, sVarName, sResult );
    }

    return sResult;
}
