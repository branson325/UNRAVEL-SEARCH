@echo off
set "KNOWN_JDK=%ProgramFiles%\Eclipse Adoptium\jdk-17.0.20.101-hotspot"
if not defined JAVA_HOME if exist "%KNOWN_JDK%\bin\java.exe" set "JAVA_HOME=%KNOWN_JDK%"
if not defined JAVA_HOME (
    echo Java 17 or newer is required. Install a JDK and try again.
    pause
    exit /b 1
)
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo JAVA_HOME does not point to a JDK: "%JAVA_HOME%"
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
