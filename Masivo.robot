*** Settings ***
Library           AutoItLibrary    ${OUTPUTDIR}    10    ${True}
Library           Screenshot
Library 		  Dialogs
Library  		  DateTime   
Resource          recursos/LanzarPorForma.robot
Resource          recursos/LoginQP.robot
Test Template     masivo


*** Test Cases ***  empresa		TpCoGen		TpCoesp		   
CP.1				4001		902			202			
 
*** Keywords ***

masivo
	[Arguments]		${empresa}		${TpCoGen}		${TpCoesp}	

    LoginQPLargo    U
    SLEEP    7s
	CrearOrdenPagoMasivo	 ${empresa}      ${TpCoGen}      ${TpCoesp}
	

CrearOrdenPagoMasivo

   [Arguments]      ${empresa}      ${TpCoGen}      ${TpCoesp}

	${fechaActual} =  Get Current Date	result_format=%d%m%Y
	LanzarPorForma  Temopgms
	WinWaitActive   Temopgms
	Sleep  			2s
	Send   		     ${empresa}{TAB 1}
	Send             1{TAB 1}
	Send             902{TAB}
	Send  			202{TAB}
	Send  			2{TAB}
	Send             7{TAB}
	Send             059{TAB}
	Send             5900252211{TAB 2}
	Send             2018{TAB 6}
	Send             ${fechaActual}{ENTER}
	Sleep            9s
	#Send             {PGDN 6}
	#Send             {UP 1}
	#Send             {SPACE}
	Sleep             7s
	Take Screenshot   CrearOrdenPagoMasivo
  