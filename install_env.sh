#!/usr/bin/env bash

set -x

set -e


rm -rf ~/download
echo "Creation du dossier download..."
mkdir ~/download
if [ -e ~/download]
then
    echo "Dossier download cree"
else
    echo "La creation du dossier n'a pas eu lieu"
    mkdir ~/download
fi

#  Download Python SDK
    #  wget --no-check-certificate -P ~/download --user=robotique@consertotech.pro --password=Conserto01 https://community.ald.softbankrobotics.com/en/dl/ZmllbGRfY29sbGVjdGlvbl9pdGVtLTEyNDEtZmllbGRfc29mdF9kbF9leHRlcm5hbF9saW5rLTAtOGVlYTk3?width=500&height=auto --progress=bar:force 2>&1 | awk 'BEGIN{RS="\r"} /% / {printf $0  RS} END{print ""}'

#  Download C++ SDK
#  wget --no-check-certificate -P ~/download --user=robotique@consertotech.pro --password=Conserto01 https://community.ald.softbankrobotics.com/en/dl/ZmllbGRfY29sbGVjdGlvbl9pdGVtLTEyNDUtZmllbGRfc29mdF9kbF9leHRlcm5hbF9saW5rLTAtZmU3ZTBi?width=500&height=auto --progress=bar:force 2>&1 | awk 'BEGIN{RS="\r"} /% / {printf $0  RS} END{print ""}'

#  Download the cross tool chain
#  wget --no-check-certificate -P ~/download --user=robotique@consertotech.pro --password=Conserto01 https://community.ald.softbankrobotics.com/en/dl/ZmllbGRfY29sbGVjdGlvbl9pdGVtLTEyODUtZmllbGRfc29mdF9kbF9leHRlcm5hbF9saW5rLTAtMmNkZTAx?width=500&height=auto --progress=bar:force 2>&1 | awk 'BEGIN{RS="\r"} /% / {printf $0  RS} END{print ""}'

#  Download the cross tool chain
#  wget --no-check-certificate -P ~/robotopi_download --user=robotique@consertotech.pro --password=Conserto01 https://community.ald.softbankrobotics.com/en/dl/ZmllbGRfY29sbGVjdGlvbl9pdGVtLTEyMjgtZmllbGRfc29mdF9kbF9leHRlcm5hbF9saW5rLTAtNWEyN2U0?width=500&height=auto --progress=bar:force 2>&1 | awk 'BEGIN{RS="\r"} /% / {printf $0  RS} END{print ""}'

cd ~

ctc = ctc-linux64*
cpp_sdk = naoqi-sdk*
py_sdk = pynaoqi-python*
chrgrph_exec = choregraphe-suite*

echo " --------------------- Verification de la langue --------------------- "
langue = $( locale | grep LANGUAGE | cut -d= -f2)

if [ $langue = "fr_FR" ]
then
    "Verification de l'existance des fichiers"
    if [ -e ~/Téléchargements/$ctc ] && [ -e ~/Téléchargements/$cpp_sdk ] && [ -e ~/Téléchargements/$py_sdk ] && [ -e ~/Téléchargements/$chrgrph_exec ]
    then
        echo -e "Langue : Fr\nCopie des archives dans le dossier download..."
        mv ~/Téléchargements/$ctc ~/download
        mv ~/Téléchargements/$cpp ~/download
        mv ~/Téléchargements/$py_sdk ~/download
        mv ~/Téléchargements/$chrgrph_exec ~/download
    else
        echo "Il manque un ou des dossier(s)..."
        exit 1
    fi
else
    echo "Veuillez choisir la langue en français"
    exit 1
fi

cd ~/Téléchargements

if [ -x $chrgrph_exec]
then
    sudo ./$chrgrph_exec
else
    sudo chmod a+x $chrgrph_exec;
    ./$chrgrph_exec
fi

echo "Copiez et collez cette clé de licence : 654e-4564-153c-6518-2f44-7562-206e-4c60-5f47-5f45"

cd /tmp
git clone git@bitbucket.org:consertoroboticteam/environmentinstallation.git
git clone git@bitbucket.org:consertoroboticteam/script.git

mv ~/download /tmp/environmentinstallation
cd /tmp/environmentinstallation
sudo ./conserto.sh

gnome-terminal -e 'bash -c "cd /tmp/environmentinstallation;./createEnv.sh;"';

# ------------------------- Clonage du repo Testenv -------------------------- #
echo " --------------------- Installation du repo TestEnv ---------------------"
cd ~/Devel
git clone git@bitbucket.org:consertoroboticteam/testenv.git
cd testenv
sudo chmod a+x build.sh
./build.sh


# -------------------------- Clonage du repo Simulator ----------------------- #
echo " ------------------- Installation du repo Simulator ----------------------"
cd ~/Devel
git clone git@bitbucket.org:consertoroboticteam/simulator.git

echo "Création du fichier .sconf..."
cd ~
touch .sconf
echo -e "[NAOQI] path = /opt/Aldebaran/Choregraphe Suite 2.5/bin/naoqi-bin\n[GUIMSG] exe_path = ~/Devel/testenv/guimsg/build-mytoolchain/sdk/bin/\n[WEBSERVER] port = 8080\n[SOCKET] port = 8081\n[PROJECT] html_path = /path/to/current/project/html
" >> .sconf
