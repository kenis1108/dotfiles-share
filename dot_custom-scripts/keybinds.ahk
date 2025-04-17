; AutoHotkey script to define custom key bindings

#Enter::
{
    Run "wt.exe"
}

#q::
{
    Send "{Alt down}{F4}{Alt up}"
}

CapsLock & Space::
{
    Send "{Enter}"
}

CapsLock & q::
{
  Send "{Del}"
}

CapsLock & e::
{
  Send "{Backspace}"
}