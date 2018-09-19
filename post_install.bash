#! /bin/bash

# Identify the distro and continues the installation accordingly

case `lsb_release -sc` in

        xenial)
                # Add PPAs
                add-apt-repository --yes ppa:libreoffice/libreoffice-6-0
                add-apt-repository --yes ppa:linuxuprising/java
                              
                # Bring the system up-to-date
                
                apt -y update
                apt -y upgrade
                apt -y dist-upgrade
                apt -y autoremove
                apt -y autoclean
                
                              
                # Accept Microsoft TTF Fonts License
                echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true
                
                # Install additional software
                
                apt install -y dselect
                
                dselect update
                
                dpkg --set-selections < ./pkgs-basic-install.txt
                
                apt-get -y dselect-upgrade
                
                # Unhide startup programs
                
                sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
                
                # Move the Launcher to the Bottom of the Screen
                
                #gsettings set com.canonical.Unity.Launcher launcher-position Bottom
                
                # Disable Apport Deamon
                
                mv /etc/default/apport /etc/default/apport.orig
                cp ./apport /etc/default/
                chmod 644 /etc/default/apport
                               
                # Install Power Management Tools
                (./power-mngnt-install)
                
                # Install Scripts
                
                chmod +x ./sysupdate.bash
                chmod +x ./mka2z.bash
                chmod 644 ./adduser.conf
                mv ./sysupdate.bash /usrlocal/bin/
                mv ./mka2z /usr/local/bin
                mv ./adduser.conf /etc/
                            
                ;;
        bionic)
                # Add PPAs
                
                add-apt-repository --yes ppa:linuxuprising/java

             
               # Bring the system up-to-date
                              
         
                apt -y update
                apt -y upgrade
                apt -y dist-upgrade
                apt -y autoremove
                apt -y autoclean
                  
                            
                # Accept Microsoft TTF Fonts License

                # Install Java 10
                apt -y install oracle-java10-installer
               
                # Install additional software
           
                apt install -y dselect
                dselect update
                dpkg --set-selections < ./pkgs-basic-install.txt
                apt-get -y dselect-upgrade
                                                          
               # Unhide startup programs

                sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
              
                # Disable Apport Deamon
              
                mv /etc/default/apport /etc/default/apport.orig
                cp ./apport /etc/default/
                chmod 644 /etc/default/apport
                
                # Install Power Management Tools
                dpkg --set-selections < ./pkgs-power-mngnt.txt
                apt-get -y dselect-upgrade
    
    # Install Scripts
                
                chmod +x ./sysupdate.bash
                chmod +x ./mka2z.bash
                chmod 644 ./adduser.conf
                mv /etc/adduser.conf /etc/adduser.conf.orig
                mv ./sysupdate.bash /usr/local/bin/
                mv ./mka2z.bash /usr/local/bin
                mv ./adduser.conf /etc/
                
                ;;
esac
