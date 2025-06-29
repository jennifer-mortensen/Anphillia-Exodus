void main()
{
    SetCustomToken(900, "<c þ >Safe"); // Cleaven green is safe
    SetCustomToken(901, "<c þ >Safe"); // Axfell green is safe
    DelayCommand(1.0,SetCustomToken(900, "<c þ >Safe")); // Cleaven green is safe
    DelayCommand(1.0,SetCustomToken(901, "<c þ >Safe")); // Axfell green is safe
    DelayCommand(2.0,SetCustomToken(900, "<c þ >Safe")); // Cleaven green is safe
    DelayCommand(2.0,SetCustomToken(901, "<c þ >Safe")); // Axfell green is safe
    DelayCommand(4.0,DestroyObject(OBJECT_SELF));
}
