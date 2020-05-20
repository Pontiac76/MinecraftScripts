#!/bin/bash
echo "Paste link to direct link for installer (http://files.minecraftforge.net/maven/net/minecraftforge/forge/):"
read DL
echo
echo "Enter subdirectory to install to:"
read SUBD
echo
echo "Enter name of start application:"
read STARTUP
echo
echo "Confirm: "
echo "  Installer: ${DL}"
echo "  SubDirectory: `pwd`/${SUBD}"
echo "  Startup Script: ${STARTUP}"
echo
echo "Press ENTER to start install"
read

echo "Creating directory"
mkdir `pwd`/${SUBD}
cd `pwd`/${SUBD}

echo "Downloading"
wget -q ${DL}
echo "Installing"
java -jar `ls` --installServer > /dev/null 2> /dev/null

echo "Linking universal to generic"
ln -s `ls forge-*-universal.jar` forge_server.jar

echo "Create startup script"
echo "#!/bin/bash" > ../${STARTUP}
echo "cd ~/${SUBD}" >> ../${STARTUP}
echo "screen -s ${SUBD} sh ServerStart.sh" >> ../${STARTUP}
chmod +x ../${STARTUP}

echo "Create launcher"
echo "#!/bin/bash" > ServerStart.sh
echo "java -server -Xms2048m -Xmx3072m -XX:PermSize=512m -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -jar forge_server.jar nogui" >> ServerStart.sh
chmod +x ServerStart.sh

echo "Create eula"
echo "eula=true" > eula.txt

echo "Removing installer"
rm *-installer.*

echo "Work Complete."
echo
echo "Start your MC server with [ ./${STARTUP} ]"
echo
