void main()
{

    ActionSpeakString("<c ¥ >*The Gate will close and lock in 30 seconds...</c>");
    DelayCommand(30.0, ActionCloseDoor(OBJECT_SELF));
}

