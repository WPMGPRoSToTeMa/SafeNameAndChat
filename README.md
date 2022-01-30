# SafeNameAndChat [![Download](https://camo.githubusercontent.com/1c836b9a3bc97bddd0d35f531833ce0eab6f1a82c69bc47987a3068b4d1197ed/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f762f72656c656173652f57504d4750526f53546f54654d612f536166654e616d65416e64436861742e737667)](https://github.com/WPMGPRoSToTeMa/SafeNameAndChat/releases/latest) [![Downloads](https://camo.githubusercontent.com/d12eaaf6643e932e38e267852f633a581423216858bc1bb7ab7bfa9d1654f419/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f646f776e6c6f6164732f57504d4750526f53546f54654d612f536166654e616d65416e64436861742f746f74616c3f636f6c6f723d696d706f7274616e74)]() [![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Build instructions
### Checking requirements
There are several software requirements for building SafeNameAndChat:

#### Windows
<pre>
Visual Studio 2015 (C++14 standard) and later
</pre>

#### Linux
<pre>
git >= 1.8.5
cmake >= 3.10
GCC >= 4.9.2 (Optional)
ICC >= 15.0.1 20141023 (Optional)
LLVM (Clang) >= 6.0 (Optional)
</pre>

### Building

#### Windows
Use `Visual Studio` to build, open `SafeNameAndChat.sln` and just select from the solution configurations list `Release` or `Debug` and platform x86

#### Linux

* Optional options using `build.sh --compiler=[gcc] --jobs=[N] -D[option]=[ON or OFF]` (without square brackets)

<pre>
-c=|--compiler=[icc|gcc|clang]  - Select preferred C/C++ compiler to build
-j=|--jobs=[N]                  - Specifies the number of jobs (commands) to run simultaneously (For faster building)

<sub>Definitions (-D)</sub>
DEBUG                           - Enables debugging mode
USE_STATIC_LIBSTDC              - Enables static linking library libstdc++
</pre>

* ICC          <pre>./build.sh --compiler=intel</pre>
* LLVM (Clang) <pre>./build.sh --compiler=clang</pre>
* GCC          <pre>./build.sh --compiler=gcc</pre>

##### Checking build environment (Debian / Ubuntu)

<details>
<summary>Click to expand</summary>

<ul>
<li>
Installing required packages
<pre>
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y gcc-multilib g++-multilib
sudo apt-get install -y build-essential
sudo apt-get install -y libc6-dev libc6-dev-i386
</pre>
</li>

<li>
Select the preferred C/C++ Compiler installation
<pre>
1) sudo apt-get install -y gcc g++
2) sudo apt-get install -y clang
</pre>
</li>
</ul>

</details>
