*** Keywords ***
LoginQPLargo
    [Arguments]    ${unidad}
    Run    C:/orant/BIN/ifrun60.EXE ${unidad}:/SFI/GENERAL/FMX/GEMOMENU.fmx    ${unidad}:/SFI_TMP
    sleep    5s
    WinWaitActive    Sistema de Administración de Menús.
    Send    vu_sfi
    Send    {TAB}
    Send    vu_sfi
    Send    {TAB}
    Send    MZALES03
    Send    {TAB}
    Send    {ENTER}
    Send    SOPORTEIT
    send    {TAB}
    sleep    2s
    send    Hightech1
    send    {TAB}
    send    {ENTER}
