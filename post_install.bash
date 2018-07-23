#! /bin/bash

# Identify the distro and continues the installation accordingly

case `lsb_release -sc` in

        xenial)
                # Add PPAs
                add-apt-repository --yes ppa:webupd8team/java
                add-apt-repository --yes ppa:libreoffice/libreoffice-6-0
                
                # Add the GetDeb Repo
                
                sh -c 'echo "deb http://archive.getdeb.net/ubuntu $(lsb_release -sc)-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'
                
                wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
                
                # Bring the system up-to-date
                
                apt -y update
                apt -y upgrade
                apt -y dist-upgrade
                apt -y autoremove
                apt -y autoclean
                
                # Accept Java License
                
                echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
                echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
                echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
                echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
                
                # Accept Microsoft TTF Fonts License
                echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true
                
                # Install additional software
                
                apt install -y dselect
                
                dselect update
                
                dpkg --set-selections < ./pkgs-basic-install.txt
                
                apt-get -y dselect-upgrade
                
                # Set Java JDK 9 as default
                
                apt install -y oracle-java9-set-default
                
                              
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
                chmod 644 ./adduser.conf
                mv ./sysupdate.bash /usrlocal/bin/
                mv ./adduser.conf /etc/
                
                ;;
        bionic)
                # Add PPAs

                add-apt-repository --yes ppa:webupd8team/java
               
               # Bring the system up-to-date
                              
         
                apt -y update
                apt -y upgrade
                apt -y dist-upgrade
                apt -y autoremove
                apt -y autoclean
                  
                # Accept Java License
                
                echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
                echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
                echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
                echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
             
                # Accept Microsoft TTF Fonts License

                echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true
               
                # Install additional software
           
                apt install -y dselect
                dselect update
                dpkg --set-selections < ./pkgs-basic-install.txt
                apt-get -y dselect-upgrade
                # Set Java JDK 9 as default
              
                apt install -y oracle-java9-set-default
                                          
               # Unhide startup programs

                sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
              
                # Disable Apport Deamon
              
                mv /etc/default/apport /etc/default/apport.orig
                cp ./apport /etc/default/
                chmod 644 /etc/default/apport
                
                # Install Power Management Tools
                dpkg --set-selections < ./pkgs-power-mngnt.txt
                apt-get -y dselect-upgrade
    
                ;;
esac
