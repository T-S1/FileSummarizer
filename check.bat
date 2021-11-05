@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET NUMOUT=10
SET DIR=%1
SET NUMFILES=0

FOR %%F IN (%DIR%/*) DO (
    SET FILES[!NUMFILES!]=%%F
    SET /A NUMFILES+=1
)

SET FILECOUNT=0

:LOOP
    IF !FILECOUNT! EQU %NUMFILES% GOTO :END
    
    SET LINECOUNT=0
    SET FILE=!FILES[%FILECOUNT%]!

    ECHO;
    ECHO %FILE%
    ECHO ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    FOR /F "USEBACKQ" %%A IN (`TYPE !FILE! ^| FIND /C /V ""`) DO SET NUMLINES=%%A
    
    FOR /F "" %%A IN (!FILE!) DO (
        IF !LINECOUNT! EQU %NUMOUT% GOTO :L1
        ECHO %%A
        SET /A LINECOUNT+=1
    )

:L1
    ECHO .
    ECHO .
    ECHO .

    SET /A LINECOUNT=!NUMLINES!-%NUMOUT%
    MORE +!LINECOUNT! !FILE!
    ECHO ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    ECHO !NUMLINES! LINES
    ECHO;
    SET /A FILECOUNT+=1
GOTO :LOOP

:END
ENDLOCAL
