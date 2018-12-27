*** Settings ***
Library           AutoItLibrary    ${OUTPUTDIR}    10    ${True}
Library           Screenshot
Library 		  Dialogs
Library  		  DateTime   
Resource          recursos/LanzarPorForma.robot
Resource          recursos/LoginQP.robot
Test Template     CreaComprobante


*** Test Cases ***  empresa		valor		Observacion		concepto		OrdPago		TpCoGen		TpCoesp		NumCOm		periodoAnul     NumCOmEgre
CP.1				4001		100			cristian1		GC4				2428		902			202			1879		201806			2138
CP.2				4001		100			cristian2		GC4				2425		902			202			1879		201806			2138
CP.3				4001		100			cristian3		GC4				2428		902			202			1879		201806			2138
CP.4				4001		100			cristian4		GC4				2425		902			202			1879		201806			2138



*** Keywords ***

CreaComprobante
	[Arguments]		${empresa}		${valor}		${Observacion}		${concepto}		${OrdPago}		${TpCoGen}		${TpCoesp}		${NumCOm}	  ${periodoAnul}    ${NumCOmEgre} 

    LoginQPLargo    R
    SLEEP    7s
	CrearOrdenPago					${empresa}		${valor}		${Observacion}		${concepto} 
	#AutorizarOrdenPago	 			${empresa}		${OrdPago}
	#Egreso							${empresa}		${OrdPago}		
	#ConsultaMovtesoreria			${empresa}		${TpCoGen}		${NumCOmEgre}
	#AnulacionTesoreria				${empresa}		${TpCoGen}		${TpCoesp}		${NumCOm}	  ${periodoAnul}	${Observacion} 			${NumCOmEgre}
    #parametrizarTipoMovimiento
	
CrearOrdenPago
	[Arguments]		${empresa}		${valor}		${Observacion}		${concepto} 
	
	LanzarPorForma    Cpmolqop
	WinWaitActive     Cpmolqop
	Sleep  1s
	Send  ${empresa}{TAB 3}3
	Sleep  1s
	Send  {TAB 2}
	Sleep  1s
	Send  402
	Sleep  0.5s
	Send              {TAB}811030730 {TAB}
	Send   ${valor}{TAB 2}
	Send  {F9}{ENTER}{TAB}${Observacion}{ENTER}
	Sleep  1s
	Sleep  5s
	Send  {F9}{Down 3}{ENTER}{TAB}${concepto}{TAB 2}{F9}{ENTER}{TAB 7}
	Sleep  10s
    TakeScreenshot    InfNo1
	Sleep  15s
	Send   S{ENTER}{TAB 2}
	Sleep  1s
	Send   S
	Sleep  1s
	Send   {TAB}{ENTER 2}
	Sleep  15s
	TakeScreenshot    InfNo2 
	Send   S{ENTER}
	TakeScreenshot    InfNo2.1 
	Sleep  15s
	Send   S{ENTER} 
	TakeScreenshot    NumComprobante1
    Sleep  16s	
	TakeScreenshot    NumComprobante
	Sleep  16s
	TakeScreenshot    InfNo3	
	Sleep  15s
	ControlClick      Scmcmvco    \    [CLASS:ui60Viewcore_W32; INSTANCE:2]
	WinWaitActive     Scmcmvco
	Sleep  1s
	TakeScreenshot    NumComprobante3
	Send   N{ENTER}
	Sleep  1s
	ControlClick      Cpmolqop    \    [CLASS:ui60Viewcore_W32; INSTANCE:2]
	WinWaitActive  Sistema de Administración de Menús.	
	
	
AutorizarOrdenPago
	[Arguments]		  ${empresa}	${OrdPago}
	
	LanzarPorForma    Cpmoauto
	WinWaitActive     Cpmoauto
	Send			  ${empresa}{TAB 2}
	SLEEP             3s
	Send			  {TAB}{F7}${OrdPago}{F8}
	Sleep			  3s
	TakeScreenshot
	Sleep			  3s
	Send			  S{TAB}N{TAB 3}N{TAB}
	ControlClick      Cpmoauto    \    [CLASS:ui60Viewcore_W32; INSTANCE:2] 
	WinWaitActive	  Sistema de Administración de Menús.
	
Egreso
	[Arguments]		  ${empresa}    ${OrdPago}
	
	LanzarPorForma    Temoegpr
	WinWaitActive  Temoegpr
	Send      ${empresa}{TAB}1{ENTER}
	Sleep  1s
	Send  {TAB 2}
	Sleep  0.5s
	Send  902{TAB}
	Sleep      0.5s
	Send  {TAB}{F9}{DOWN}{ENTER}{TAB}
	Sleep  5s
	Send  2{ENTER}
	Sleep  1s
	Send  {ENTER}
	Sleep  1s
	Send              ${OrdPago}{TAB 2}7{TAB}059{TAB}5900252211{TAB 4}S{F10}
	Sleep  15s
	TakeScreenshot    ComprobanteEgreso
	Send    {ENTER}
	Send    N{ENTER} 
	ControlClick      Temoegpr    \    [CLASS:ui60Viewcore_W32; INSTANCE:2] 
	WinWaitActive	  Sistema de Administración de Menús.
	

ConsultaMovtesoreria
	[Arguments]		  ${empresa}		${TpCoGen}		${NumCOmEgre}
	LanzarPor Forma    Temcmovi
	WinWaitActive     Temcmovi
	Send              {TAB}${empresa}{TAB}${TpCoGen}{TAB 2}201806{TAB}
	Send              ${NumCOmEgre}{F8}
    Sleep             2s
	TakeScreenshot    Consultamovtesoreria
	ControlClick       Temcmovi    \     [CLASS:Button; INSTANCE:1] 
	Sleep             3s
	TakeScreenshot    Consultaestado
	ControlClick      Cpmcopgn    \    [CLASS:ui60Viewcore_W32; INSTANCE:2]
    Winkill			  Cpmcopgn
	Sleep             2s
	Send   			  {ENTER}
	
	
AnulacionTesoreria
	[Arguments]		 ${empresa}		${TpCoGen}		${TpCoesp}		${NumCOmEgre}	  ${periodoAnul}	${Observacion}    	${NumCOmEgre}
	
	LanzarPorForma    Temoanul
	WinWaitActive	  Temoanul
	${fechaActual} =  Get Current Date	result_format=%d%m%Y
	Send			  ${empresa}{TAB}1{TAB 3}${TpCoGen}{TAB}${TpCoesp}{TAB}${NumCOmEgre}{ENTER}{TAB}{ENTER}
    Sleep			  2.5s	
	Take Screenshot   documentoanular
	Send			  {TAB 3}${periodoAnul}{TAB}${fechaActual}{TAB}${observacion}{TAB}S{ENTER}
	Sleep			  2s	
	Take Screenshot   anulacion
	ControlClick      Nota    \    [CLASS:Button; INSTANCE:1]
	Take Screenshot   anulacion2	
	Send			  {ENTER}
	Sleep			  2s
	Send			  {ENTER}
	ControlClick      Temoanul    \    [CLASS:ui60Viewcore_W32; INSTANCE:2] 
	WinWaitActive	  Sistema de Administración de Menús.
	
parametrizarTipoMovimiento

   LanzarPorForma   Cpmstpmv
   WinWaitActive    Cpmstpmv
   SLEEP            1s
   Send             {DOWN 2}{TAB 13}N{TAB 2}N{TAB 4}N{TAB 5}N{F10}
   ControlClick     Cpmstpmv    \    [CLASS:ui60Viewcore_W32; INSTANCE:2] 
   WinWaitActive	Sistema de Administración de Menús.
	
	
	
	