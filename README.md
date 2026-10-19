# 🎗️Unravel Search

Unravel is a Java desktop search app with a dark red theme, browser-style tabs,
web search, and a built-in browser for opening pages. It can also ask a local
[Ollama](https://ollama.com/) model to answer questions using search result
snippets.

> Unravel's browser is JavaFX WebView (WebKit), not Google Chrome. Most pages
> and images should display, but websites that require Chrome-specific
> features may behave differently.

## What you need

- **JDK 17 or newer** to compile and run the app.
- **Apache Maven 3.8 or newer** to download dependencies and start the app.
- **An internet connection** for web search, websites, and the first dependency
  download.
- **Ollama and a downloaded model** for AI answers. Ollama is optional; search
  and browsing do not require it.

The project uses Maven to download JavaFX, Jsoup, and Jackson. You do not need
to download those libraries yourself.

## Install on Windows

### 1. Install Java (JDK 17+)

Download a JDK from [Eclipse Temurin](https://adoptium.net/temurin/releases/).
Choose **JDK**, version **17 or newer**, and the installer for your Windows
processor (usually **x64**, or **aarch64/ARM64** on ARM devices). Run the
installer and enable its options to set `JAVA_HOME` and add Java to `PATH` if
the installer offers them.

Open a new PowerShell window and verify the install:

```powershell
java -version
javac -version
```

Both commands should report version 17 or newer. If Windows cannot find them,
reopen your terminal or IDE after installation. Check that `JAVA_HOME` points
to the JDK installation folder, not its `bin` folder, and that the JDK's `bin`
folder is on `PATH`.

### 2. Install Apache Maven

1. Download the **Binary zip archive** from the
   [official Apache Maven download page](https://maven.apache.org/download.cgi).
2. Extract it to a permanent folder, for example
   `C:\Tools\apache-maven-3.10.0`.
3. Add Maven's `bin` folder (for example, `C:\Tools\apache-maven-3.10.0\bin`)
   to your Windows `Path`.
4. Open a new PowerShell window and verify:

```powershell
mvn -version
```

The output should show Maven 3.8 or newer and the JDK you installed. If Maven
reports that `JAVA_HOME` is not configured correctly, set `JAVA_HOME` to your
JDK folder (for example, `C:\Program Files\Eclipse Adoptium\jdk-17...`) and
reopen PowerShell.

### 3. Get and start Unravel

Clone this repository from GitHub, or download the repository as a ZIP and
extract it. In PowerShell, change to the folder containing `pom.xml`, then
run:

```powershell
mvn javafx:run
```

Alternatively, double-click `run.bat` in the project folder. On the first
launch Maven downloads the project dependencies; this can take a few minutes.

## Enable AI answers with Ollama (optional)

1. Install Ollama from the
   [official Ollama download page](https://ollama.com/download).
2. Start Ollama. On Windows, open the Ollama app; on other systems, follow
   Ollama's installation instructions.
3. Download a model in PowerShell or a terminal:

```powershell
ollama pull llama3.2
```

4. Start (or restart) Unravel. It checks Ollama at
   `http://localhost:11434` and lists the models it finds.
5. Search for something, then click **Ask AI**.

Models can require substantial disk space and memory. Choose a model your
computer can run; the Ollama library lists available models and their sizes.
The AI answer is based on the search-result snippets provided to it, so open
the cited pages to check important details.

If your Ollama server is hosted somewhere other than the default local address,
set `OLLAMA_HOST` before starting Unravel:

```powershell
$env:OLLAMA_HOST = "http://localhost:11434"
mvn javafx:run
```

Replace the example address with the address of your Ollama server.

## What the app contains

- **Search home page** — search box, suggested searches, and a dark red design.
- **Web search** — search requests go to DuckDuckGo; results show page titles,
  links, and available text snippets. This project is not affiliated with
  Google and does not use Google's search service.
- **Browser window** — open results inside the app, with multiple tabs and
  back, forward, reload, home, and address-bar controls. Pages render in JavaFX
  WebView, including images and JavaScript supported by WebKit.
- **Local AI panel** — when Ollama is running and a model is installed, ask it
  to answer a question using snippets from the current web search. AI is
  optional and runs through the Ollama server configured on your computer.
- **Maven build** — `pom.xml` downloads and configures JavaFX for the desktop
  UI and browser, Jsoup for reading search results, and Jackson for Ollama's
  JSON API. No separate library downloads are needed.

## Repository contents

| Path | What it contains |
| --- | --- |
| `main.java` | JavaFX app entry point, desktop UI, tabs, browser navigation, web search, and Ollama integration |
| `pom.xml` | Maven project configuration, Java version, libraries, and `mvn javafx:run` launcher |
| `src/main/resources/dark-red.css` | Dark red theme for the app window and browser controls |
| `run.bat` | Windows helper to find Java and Maven and launch the app |
| `README.md` | Installation, running, Ollama setup, and troubleshooting instructions |

Maven downloads JavaFX, Jsoup, and Jackson into its local dependency cache when
the project is first built; these libraries are not copied into the repository.

## Troubleshooting

### `java` or `javac` is not recognized

Install a JDK (not just a Java runtime), add its `bin` directory to `PATH`, and
open a new terminal. Confirm that `java -version` and `javac -version` both
work.

### `mvn` is not recognized

Add the extracted Maven `bin` directory to `PATH`, then open a new terminal and
check `mvn -version`.

### Maven says `JAVA_HOME` is not set correctly

Set `JAVA_HOME` to the JDK installation directory, such as
`C:\Program Files\Eclipse Adoptium\jdk-17...`. Do not include `\bin` at the
end. Reopen your terminal or IDE after changing environment variables.

### Ollama is offline or no models appear

Start the Ollama app, verify that it is available at
`http://localhost:11434`, and download a model with `ollama pull llama3.2`.
Restart Unravel after starting Ollama or installing a model.

### A website looks or behaves differently

Unravel uses JavaFX WebView rather than Chrome. Some sites rely on browser
features that WebView does not support.

## Project files

- `main.java` — JavaFX application and search/browser behavior
- `pom.xml` — Java version, dependencies, and Maven run configuration
- `src/main/resources/dark-red.css` — application theme
- `run.bat` — Windows launcher
