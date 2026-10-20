@echo off
if defined JAVA_HOME (
    if not exist "%JAVA_HOME%\bin\java.exe" (
        echo JAVA_HOME does not point to a JDK: "%JAVA_HOME%"
        pause
        exit /b 1
    )
)
if defined JAVA_HOME set "PATH=%JAVA_HOME%\bin;%PATH%"
set "JAVA_MAJOR="
if defined JAVA_HOME (
    for /f "tokens=3" %%V in ('java -version 2^>^&1 ^| findstr /i "version"') do (
        for /f "tokens=1 delims=." %%M in ("%%~V") do set "JAVA_MAJOR=%%M"
    )
)
if not defined JAVA_MAJOR set "JAVA_HOME="
if defined JAVA_MAJOR if %JAVA_MAJOR% LSS 25 (
    set "JAVA_HOME="
    set "JAVA_MAJOR="
)
if not defined JAVA_HOME (
    for /d %%J in ("%USERPROFILE%\.jdk\jdk-25*") do (
        if exist "%%~fJ\bin\java.exe" set "JAVA_HOME=%%~fJ"
    )
)
if not defined JAVA_HOME (
    for /d %%J in ("%ProgramFiles%\Eclipse Adoptium\jdk-25*") do (
        if exist "%%~fJ\bin\java.exe" set "JAVA_HOME=%%~fJ"
    )
)
if not defined JAVA_HOME (
    echo Java 25 or newer is required. Install a JDK and try again.
    pause
    exit /b 1
)
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo JAVA_HOME does not point to a JDK: "%JAVA_HOME%"
    pause
    exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
if not defined JAVA_MAJOR (
    for /f "tokens=3" %%V in ('java -version 2^>^&1 ^| findstr /i "version"') do (
        for /f "tokens=1 delims=." %%M in ("%%~V") do set "JAVA_MAJOR=%%M"
    )
)
if not defined JAVA_MAJOR (
    echo Unable to determine the Java version in "%JAVA_HOME%".
    pause
    exit /b 1
)
if %JAVA_MAJOR% LSS 25 (
    echo Java 25 or newer is required. Found Java %JAVA_MAJOR%.
    pause
    exit /b 1
)
set "PATH=%JAVA_HOME%\bin;%PATH%"
where mvn >nul 2>&1
if errorlevel 1 (
    for /d %%M in ("%LOCALAPPDATA%\Programs\Apache\Maven\apache-maven-*") do (
        if exist "%%~fM\bin\mvn.cmd" set "MAVEN_HOME=%%~fM"
    )
    if defined MAVEN_HOME set "PATH=%MAVEN_HOME%\bin;%PATH%"
)
where mvn >nul 2>&1
if errorlevel 1 (
    echo Maven 3.8 or newer is required. Install Maven and try again.
    pause
    exit /b 1
)
mvn javafx:run
if errorlevel 1 pause
