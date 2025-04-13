; AutoHotkey script to define custom key bindings

#Enter::
{
    Run "wt.exe"
}

#q::
{
    Send "{Alt down}{F4}{Alt up}"
}
