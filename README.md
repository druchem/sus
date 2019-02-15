# SUS

A collection of scripts to automate and complete [final test version A](http://seidl.cs.vsb.cz/wiki/index.php/SUS#Fin.C3.A1ln.C3.AD_test_.2819.4.2018.29) of VŠB FEI course UNIX Systems Management (SUS).

### Prerequisites
  - Debian Stretch (tested on 4.9.0-8-amd64)
  - (optional) VirtualBox environment for PXE boot

### Usage
Clone this repository, modify environment variables to match your configuration in ```install.sh``` and run the script. The scripts can also be hosted on a remote server and piped directly into bash (not recomennded) with ```wget -q -O - <domain> | bash``` using ```download.sh``` script (don't forget to modify the configuration aswell). 

License
----
This repository is licensed with [MIT Licence](https://opensource.org/licenses/MIT).


**Free Software, Hell Yeah!**