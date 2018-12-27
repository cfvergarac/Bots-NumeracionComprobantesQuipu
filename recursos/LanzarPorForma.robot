*** Keywords ***
LanzarPorForma
    [Arguments]    ${forma}
    sleep     2
    ControlClick    Sistema de Administración de Menús.    \    [CLASS:ui60Drawn_W32; INSTANCE:5]
    Send    {TAB}
    Send    {TAB}
    Send    {ESC}
    Send    ${forma}
    Send    {ENTER}
