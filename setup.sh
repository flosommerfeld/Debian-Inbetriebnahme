#!/bin/bash

# Info: Dieses Skript dient zur Einrichtung von Debian Systemen.
# Letztes Veränderungsdatum: 04.10.19
# Author: Florian Sommerfeld
# Getestet unter (Augabe von uname -a): Linux debianPc 4.19.0-6-amd64 #1 SMP Debian 4.19.67-2+deb10u1 (2019-09-20) x86_64 GNU/Linux ----- Debian 10!
# Hinweis: Im Idealfall dieses Skript direkt nach dem Aufsetzen des Betriebssystems starten; Voraussetzung ist, dass GNOME und Nautilus verwendet werden!



# Variablen
balenaEtcher = "balenaEtcher-1.5.57-x64"
eclipseCpp = "eclipse-cpp-2019-09-R-linux-gtk-x86_64"
eclipseJava = "eclipse-java-2019-09-R-linux-gtk-x86_64"
megaSync = "megasync-Debian_10.0_amd64"
megaSyncNautilusExt = "nautilus-megasync-Debian_10.0_amd64"
rabbitVcs = "rabbitvcs-0.17.1"
pencil = "Pencil_3.0.4_amd64"
starUml = "StarUML-3.1.0-x86_64"
virtualbox = "virtualbox-6.0_6.0.12-amd64"


echo "###########################################"
echo "Debian Einrichtungsskript von Florian"
echo "###########################################"
echo "Voraussetzung für dieses Skript ist, dass man GNOME als DE benutzt!"
echo ""
echo "Schritte:"

echo "#1: Füge den Benutzer '$USER' in die Sudoers-Datei."
echo "$USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "#2: Behebe ein häufiges NetworkManager Problem (Randomisierte Mac-Adresse verbieten)"
echo "[device]" >> /etc/NetworkManager/NetworkManager.conf
echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf

echo "#3: Gnome konfigurieren (Mausgeschwindigkeit usw.)"
gsettings set org.gnome.shell favorite-apps "['firefox-esr.desktop', 'libreoffice-writer.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'org.gnome.Terminal.desktop']"
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gnome.desktop.peripherals.mouse accel-profile "flat"
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant "dark"
gsettings set org.gnome.desktop.peripherals.mouse speed -0.172661870504 #Aktuell benutze ich lieber den Wert 0
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

echo "#4: Florians standardmäßige Ordnerstruktur anlegen"
mkdir /home/$USER/Workspaces
mkdir /home/$USER/Software
mkdir /home/$USER/Files

echo "#5.1: Installation von nützlicher Software (über apt)"
apt-get update && apt-get upgrade
apt-get install -y net-tools sudo command-not-found dconf-editor redshift redshift-gtk snapd flatpak gdebi filezilla htop gnome-software-plugin-flatpak curl libcanberra-gtk-module libcanberra-gtk3-module openjdk-11-source openjdk-11-jdk openjdk-11-doc openjfx openjfx-source git python-nautilus python-configobj python-gtk2 python-glade2 python-svn python-dbus python-dulwich subversion meld rabbitvcs-core rabbitvcs-cli rabbitvcs-gedit rabbitvcs-nautilus libdouble-conversion1 libpcre2-16-0 libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5opengl5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libqt5x11extras5 libsdl1.2debian libxcb-xinerama0 qt5-gtk-platformtheme qttranslations5-l10n libc-ares2 libcrypto++6 libmediainfo0v5 libtinyxml2-6a libzen0v5 gparted

apt-get update

echo "#5.2: Installation von nützlicher Software (über flatpak)"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.keepassxc.KeePassXC
flatpak install -y flathub io.atom.Atom
flatpak install -y flathub com.axosoft.GitKraken

echo "#5.3: Installation von nützlicher Software (über snap)"
snap install mailspring
snap install tusk

echo "#5.4: Installation von Eclipse (Java und C/C++)"
unzip -v pkgs/$eclipseCpp.zip
unzip -v pkgs/$eclipseJava.zip
mv pkgs/$eclipseCpp /home/$USER/Software
mv pkgs/$eclipseJava /home/$USER/Software
mv /home/$USER/Software/$eclipseCpp mv /home/$USER/Software/eclipse-cpp
mv /home/$USER/Software/$eclipseCpp mv /home/$USER/Software/eclipse-java
cp misc/icon-c.png /home/$USER/Software/eclipse-cpp
cp misc/eclipse-cpp.desktop /usr/share/applications
cp misc/eclipse-java.desktop /usr/share/applications

echo "#5.5: Installation von StarUML"
cp pkgs/$starUml /home/$USER/Software/

echo "#5.6: Installation von Balena Etcher"
cp pkgs/$balenaEtcher /home/$USER/Software/

echo "#5.7: Installation von MegaSync"
sudo dpkg -i pkgs/$megaSync.deb
sudo dpkg -i pkgs/$megaSyncNautilusExt.deb

echo "#5.8: Installation von Pencil"
sudo dpkg -i pkgs/$pencil.deb

echo "#5.9: Installation von Virtualbox"
sudo dpkg -i pkgs/$virtualbox.deb

echo "#6: Folgende Sachen konnte ich nicht automatisieren:"
echo "Keyboard-Shortcuts für das Terminal, ... "
echo "- Die oben genannten Sachen müssen manuell gemacht werden -"

echo "#7: Optionaler Schritt für Nvidia-Grafikkarten"
echo "Über apt das Paket nvidia-detect installieren (apt install nvidia-detect)"
echo "nvidia-detect ausführen und machen, was das Skript einem sagt"



#Eventuell noch: main contrib non-free in die apt.sources hinzufügen?
