#!/bin/bash

# Set the main variables
YELLOW="\033[133m"
GREEN="\033[032m"
RESET="\033[0m"
VERSION="0.1"

# Display the logo
displayLogo(){
	echo -e "
-----------------------------------
5hyl0ck Cybersecurity Tools Install
v$VERSION - $YELLOW@5hyl0ck$RESET
-----------------------------------"
}

# Basic requirements
getBasicRequirements(){
	echo -e "[$GREEN+$RESET] This script will install the required tools and dependencies for a lot of offensive security work (mostly web now), please stand by.."
	echo -e "[$GREEN+$RESET] It may take a while, go grab a cup of coffee :)"
	cd "$HOME" || return
	sleep 1

	echo -e "[$GREEN+$RESET] Getting the basics.."
	sudo apt update -y && sudo apt full-upgrade -y
	sudo apt install -y git swig whatweb wireshark cmake gcc g++ build-essential lsb-release file dnsutils lua5.1 alsa-utils nmap fping libpq5 locate ncdu net-tools git openvpn tmux python3-pip p7zip-full ca-certificates curl gnupg-agent software-properties-common net-tools nmap john wfuzz gobuster masscan wireguard nfs-common hydra cewl mlocate libcurl4-openssl-dev libssl-dev jq libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev build-essential libssl-dev libffi-dev python3-dev python3-setuptools libldns-dev rename nano vim ruby ruby-dev python3-pip python3-dnspython ruby-full ruby-railties php binutils gdb strace perl libnet-ssleay-perl openssl libauthen-pam-perl libio-pty-perl libncurses5-dev build-essential zlib1g libpq-dev libpcap-dev libsqlite3-dev awscli
	sudo apt install -y chromium || sudo apt install -y chromium-browser

	echo -e "[$GREEN+$RESET] Installing Docker-ce and adding current user to group.."
	if [[ -e `which docker` ]]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		curl -sSL https://get.docker.com | sh
		sudo pip3 install docker-compose
		sudo usermod -aG docker ${USER}
		echo -e "[$GREEN+$RESET] Done."
	fi

	sudo apt-get autoremove -y
	sudo apt clean
	echo -e "[$GREEN+$RESET] Creating directories.."
	mkdir -p ~/tools
	mkdir -p ~/go
	mkdir -p ~/go/src
	mkdir -p ~/go/bin
	mkdir -p ~/go/pkg
	sudo chmod u+w .
	echo "Don't forget to set up AWS credentials!"
	sleep 5
	echo -e "[$GREEN+$RESET] Done."
	
	echo -e "[$GREEN+$RESET] Installing and setting up Go.."

	if [[ $(go version | grep -o '1.17') == '1.17' ]]; then
		echo -e "[$GREEN+$RESET] Go is already installed, skipping installation"
	elif [[ $(uname --kernel-release | grep -o 'kali') == 'kali' ]]; then
		sudo apt install golang 
	else
		cd /tmp
		wget https://golang.org/dl/go1.17.3.linux-amd64.tar.gz
		sudo tar -C /opt -xzf go1.17.3.linux-amd64.tar.gz
		sudo ln -s /opt/go/bin/go /usr/local/bin/go
		cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

		sleep 1
		if [ $(echo $SHELL | grep -o zsh) == 'zsh' ]; then
			configfile="$HOME"/.zshrc
		else
			configfile="$HOME"/.bashrc
		fi

		echo -e "[$GREEN+$RESET] Adding Golang alias to "$configfile"..."

		if [[ "$(cat "$configfile" | grep '^export GOPATH=')" == "" ]]; then
			echo export GOPATH='$HOME'/go >> "$configfile"
		fi

		if [[ "$(echo $PATH | grep $GOPATH)" == "" ]]; then
			echo export PATH='$PATH:$GOPATH'/bin >> "$configfile"
		fi

		source "$configfile"

		cd "$HOME" || return
		echo -e "[$GREEN+$RESET] Golang has been configured."
}


getWebTools(){
	echo -e "[$GREEN+$RESET] Setting up Web Tools \n"
	
	echo -e "[$GREEN+$RESET] Installing shodan.."
	pip3 install -U --user shodan
	echo -e "[$GREEN+$RESET] Done."
	

	: 'Golang tools'
	echo -e "[$GREEN+$RESET] Installing subfinder.."
	go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
	echo -e "[$GREEN+$RESET] Done."
	
	echo -e "[$GREEN+$RESET] Installing cookiemonster .."
	go install github.com/iangcarroll/cookiemonster/cmd/cookiemonster@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing chronos .."
	go install github.com/mhmdiaa/chronos@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing dalfox .."
	go install github.com/hahwul/dalfox/v2@latest
	echo -e "[$GREEN+$RESET] Done."


	echo -e "[$GREEN+$RESET] Installing goverview .."
	GO111MODULE=on go install github.com/j3ssie/goverview@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing smap .."
	go install -v github.com/s0md3v/smap/cmd/smap@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing naabu .."
	go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing cero.."
	GO111MODULE=on go install github.com/glebarez/cero@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing hakip2host.."
	go install github.com/hakluke/hakip2host@latest
	echo -e "[$GREEN+$RESET] Done."


	echo -e "[$GREEN+$RESET] Installing gospider.."
	GO111MODULE=on go install github.com/jaeles-project/gospider@latest
	echo -e "[$GREEN+$RESET] Done."
	
	echo -e "[$GREEN+$RESET] Installing subjack.."
	GO111MODULE=off go get -d github.com/haccer/subjack
	go install github.com/haccer/subjack@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing httprobe.."
	go install github.com/tomnomnom/httprobe@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing assetfinder.."
	go install github.com/tomnomnom/assetfinder@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing gauplus.."
	go install github.com/bp0lr/gauplus@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing unfurl.."
	go install github.com/tomnomnom/unfurl@latest
	echo -e "[$GREEN+$RESET] Done."
	
	echo -e "[$GREEN+$RESET] Installing waybackurls.."
	go install github.com/tomnomnom/waybackurls@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing gf.."
	GO111MODULE=off go get -d github.com/tomnomnom/gf
	go install github.com/tomnomnom/gf@latest
	echo 'source $GOPATH/src/github.com/tomnomnom/gf/gf-completion.bash' >> ~/.bashrc
	cp -r $GOPATH/src/github.com/tomnomnom/gf/examples ~/.gf
	cd ~/tools/ || return
	git clone https://github.com/1ndianl33t/Gf-Patterns
	cp Gf-Patterns/*.json ~/.gf
	git clone https://github.com/dwisiswant0/gf-secrets
	cp gf-secrets/.gf/*.json ~/.gf
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing anew.."
	go install github.com/tomnomnom/anew@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing ffuf.."
	go install github.com/ffuf/ffuf@latest
	echo -e "[$GREEN+$RESET] Done."


	echo -e "[$GREEN+$RESET] Installing gitrob.."
	go install github.com/michenriksen/gitrob@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing authz0 .."
	go install github.com/hahwul/authz0@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing gobuster.."
	go install github.com/OJ/gobuster@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing Amass.."
	GO111MODULE=on go get github.com/OWASP/Amass/v3/...
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing getallURL.."
	go install github.com/lc/gau@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing shuffledns.."
	GO111MODULE=on go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing dnsprobe.."
	GO111MODULE=on go install github.com/projectdiscovery/dnsprobe@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing nuclei.."
	GO111MODULE=on go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
	nuclei -update-templates
	echo -e "[$GREEN+$RESET] Done."

  	echo -e "[$GREEN+$RESET] Installing httpx"
	GO111MODULE=on go install github.com/projectdiscovery/httpx/cmd/httpx@latest
	echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing slackcat"
	go install github.com/dwisiswant0/slackcat@latest
	echo -e "[$GREEN+$RESET] Done."

	: 'Python tools'
	echo -e "[$GREEN+$RESET] Installing Altdns, droopescan, raccoon.."
	python3 -m pip3 install py-altdns droopescan pysqlcipher3 cloudscraper apkleaks parth flask-unsign flask-unsign-wordlist
	pip3 install -U pacu 
	echo -e "[$GREEN+$RESET] Done."

	: 'Ruby tools'
	echo -e "[$GREEN+$RESET] Installing wpscan"
	sudo gem install wpscan
	echo -e "[$GREEN+$RESET] Done."


	echo -e "[$GREEN+$RESET] Installing feroxbuster"
	curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/master/install-nix.sh | bash
	echo -e "[$GREEN+$RESET] Done."

	: 'Github tools'
	cd ~/tools
	echo -e "[$GREEN+$RESET] Installing dirsearch.."
	if [ -e "$HOME"/tools/dirsearch/dirsearch.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/maurosoria/dirsearch.git
		cd dirsearch
		pip3 install -r requirements.txt
		cd "$HOME"/tools/ || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Arjun (HTTP parameter discovery suite).."
	if [ -e "$HOME"/tools/Arjun/arjun.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/s0md3v/Arjun.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing Knockpy (Subdomain bruteforcer).."
	if [ -e "$HOME"/tools/knock/setup.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/guelfoweb/knock.git
		cd knock || return
		pip3 install -r requirements.txt
		echo "alias knockpy='python3 $HOME/tools/knock/knockpy.py'" >> "$HOME"/.bashrc
		echo -e "[$GREEN+$RESET] Done."
	fi
	


	echo -e "[$GREEN+$RESET] Installing Dnsgen .."
	if [ -e "$HOME"/tools/dnsgen/setup.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/ProjectAnte/dnsgen
		cd "$HOME"/tools/dnsgen || return
		pip3 install -r requirements.txt --user
		sudo python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing sublert.."
	if [ -e "$HOME"/tools/sublert/sublert.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/yassineaboukir/sublert.git
		cd "$HOME"/tools/sublert || return
		sudo apt-get install -y libpq-dev dnspython psycopg2 tld termcolor
		pip3 install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing LinkFinder.."
	if [ -e "$HOME"/tools/LinkFinder/linkfinder.py ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/GerbenJavado/LinkFinder.git
		cd "$HOME"/tools/LinkFinder || return
		pip3 install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing interlace.."
	if [ -e /usr/local/bin/interlace ] || [ -e ~/tools/Interlace ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/codingo/Interlace.git
		cd "$HOME"/tools/Interlace
		pip3 install -r requirements.txt
		python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing sqlmap.."
	if [ -e "$HOME"/tools/sqlmap/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/sqlmapproject/sqlmap.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing graphqlmap.."
	if [ -e "$HOME"/tools/GraphQlmap/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/swisskyrepo/GraphQLmap.git
		cd GraphQLmap && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing SSRFmap.."
	if [ -e "$HOME"/tools/SSRFmap/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/swisskyrepo/SSRFmap.git
		cd SSRFmap && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing XSStrike.."
	if [ -e "$HOME"/tools/XSStrike/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/s0md3v/XSStrike.git
		cd XSStrike && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing XSRFProbe.."
	if [ -e "$HOME"/tools/XSRFProbe/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/0xInfection/XSRFProbe.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing RED_HAWK.."
	if [ -e "$HOME"/tools/RED_HAWK/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/Tuhinshubhra/RED_HAWK.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing GitTools.."
	if [ -e "$HOME"/tools/GitTools/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/internetwache/GitTools.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing 403Bypasser.."
	if [ -e "$HOME"/tools/403Bypasser/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/yunemse48/403bypasser.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing jwt_tool.."
	if [ -e "$HOME"/tools/jwt_tool/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/ticarpi/jwt_tool.git
		cd jwt_tool && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e " Installing CSRF PoC Generator"
	if [ -e "$HOME"/tools/csrf-poc-generator ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/merttasci/csrf-poc-generator.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing sherlock.."
	if [ -e "$HOME"/tools/sherlock/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/sherlock-project/sherlock.git
		cd sherlock && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing massdns.."
	if [ -e /usr/local/bin/massdns ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/blechschmidt/massdns.git
		cd "$HOME"/tools/massdns || return
		echo -e "[$GREEN+$RESET] Running make command for massdns.."
		make -j
		sudo cp "$HOME"/tools/massdns/bin/massdns /usr/local/bin/
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing aquatone v1.7.0.."
	arch=`uname -m`
	if [ "$arch" == "x86_64" ]; then
		cd /tmp && wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && unzip aquatone_linux_amd64_1.7.0.zip && chmod +x aquatone && mv aquatone ~/go/bin/ && cd -
	else
		cd /tmp && wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_arm64_1.7.0.zip && unzip aquatone_linux_arm64_1.7.0.zip && chmod +x aquatone && mv aquatone ~/go/bin/ && cd -
	fi
	echo -e "[$GREEN+$RESET] Done."


	echo -e "[$GREEN+$RESET] Installing Sublist3r .."
	if [ -e "$HOME"/tools/Sublist3r/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/aboul3la/Sublist3r.git
		cd Sublist3r && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing googlecertfarm .."
	if [ -e "$HOME"/tools/googlecertfarm/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/rook1337/googlecertfarm
		echo -e "[$GREEN+$RESET] Done."
	fi



	echo -e "[$GREEN+$RESET] Installing hatcloud .."
	if [ -e "$HOME"/tools/HatCloud/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/HatBashBR/HatCloud.git
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] Installing crimeflare .."
	if [ -e "$HOME"/tools/CloudPeler/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/zidansec/CloudPeler.git
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] Installing firewall-bypasser-dns .."
	if [ -e "$HOME"/tools/bypass-firewalls-by-DNS-history/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/vincentcox/bypass-firewalls-by-DNS-history.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing CloudFail .."
	if [ -e "$HOME"/tools/CloudFail/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/m0rtem/CloudFail.git
		cd CloudFail && pip3 install -r requirements.txt && cd -
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] Installing cloudip.sh .."
	if [ -e "$HOME"/tools/cloudip.sh ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		wget https://raw.githubusercontent.com/Top-Hat-Sec/thsosrtl/master/CloudIP/cloudip.sh
		echo -e "[$GREEN+$RESET] Done."
	fi


}

getWordlists(){
	echo -e "[$GREEN+$RESET] Getting Wordlists"
	cd ~/tools

	echo -e "[$GREEN+$RESET] installing SecLists.."
	if [ -e "$HOME"/tools/seclists/ ] || [ -e /usr/share/seclists/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/danielmiessler/SecLists.git seclists
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] installing Fuzzdb.."
	if [ -e "$HOME"/tools/fuzzdb/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/fuzzdb-project/fuzzdb.git
		echo -e "[$GREEN+$RESET] Done."
	fi




	echo -e "[$GREEN+$RESET] installing trufflehog .."
	if [ -e "$HOME"/tools/trufflehog/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/trufflesecurity/trufflehog.git
		cd trufflehog; go install
		echo -e "[$GREEN+$RESET] Done."
	fi




	echo -e "[$GREEN+$RESET] installing combobulator .."
	if [ -e "$HOME"/tools/combobulator/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/apiiro/combobulator.git
		cd combobulator || return 
		pip3 install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] installing CMSmap .."
	if [ -e "$HOME"/tools/CMSmap/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/Dionach/CMSmap
		cd CMSmap; pip3 install .
		echo -e "[$GREEN+$RESET] Done."
	fi



	echo -e "[$GREEN+$RESET] installing wafw00f .."
	if [ -e "$HOME"/tools/wafw00f/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/EnableSecurity/wafw00f.git
		cd wafw00f || return
		python3 setup.py install
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] installing s3cario .."
	if [ -e "$HOME"/tools/s3cario/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/0xspade/s3cario.git
		cd s3cario || return
		pip3 install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] installing MobSF Docker  .."
	docker pull opensecurity/mobile-security-framework-mobsf
	echo -e "[$GREEN+$RESET] Done."



	echo -e "[$GREEN+$RESET] installing APKEnum .."
	if [ -e "$HOME"/tools/APKEnum/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/shivsahni/APKEnum.git
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] installing Diggy .."
	if [ -e "$HOME"/tools/Diggy/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/s0md3v/Diggy.git
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] installing ReconCat .."
	if [ -e "$HOME"/tools/ReconCat/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/daudmalik06/ReconCat.git
		echo -e "[$GREEN+$RESET] Done."
	fi


	echo -e "[$GREEN+$RESET] installing ParamSpider .."
	if [ -e "$HOME"/tools/ParamSpider/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/devanshbatham/ParamSpider.git
		cd ParamSpider || return
		pip3 install -r requirements.txt
		echo -e "[$GREEN+$RESET] Done."
	fi

	echo -e "[$GREEN+$RESET] installing commoncrawl .."
	if [ -e "$HOME"/tools/commoncrawl/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/ghostlulzhacks/commoncrawl.git
	fi


	echo -e "[$GREEN+$RESET] installing JSFScan .."
	if [ -e "$HOME"/tools/JSFScan.sh ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/KathanP19/JSFScan.sh
		cd JSFScan.sh || return
		sudo chmod +x install.sh && ./install.sh
	fi


	echo -e "[$GREEN+$RESET] installing kiterunner .."
	if [ -e "$HOME"/tools/kiterunner ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/assetnote/kiterunner.git
		cd kiterunner || return
		make build
		sudo ln -s $(pwd)/dist/kr /usr/local/bin/kr
	fi

	echo -e "[$GREEN+$RESET] installing nikto .."
	if [ -e "$HOME"/tools/nikto ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/sullo/nikto
		cd nikto || return
	fi


	echo -e "[$GREEN+$RESET] installing parameth .."
	if [ -e "$HOME"/tools/parameth ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/maK-/parameth.git
		cd parameth || return
		pip3 install -u -r requirements.txt
	fi


	echo -e "[$GREEN+$RESET] installing tplmap .."
	if [ -e "$HOME"/tools/tplmap/ ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/epinna/tplmap.git
		cd tplmap || return
		pip3 install -r requirements.txt
	fi


	echo -e "[$GREEN+$RESET] installing Corsy .."
	if [ -e "$HOME"/tools/Corsy ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/s0md3v/Corsy.git
		cd Corsy || return
		pip3 install -r requirements.txt
	fi


	echo -e "[$GREEN+$RESET] installing bfac .."
	if [ -e "$HOME"/tools/bfac ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/mazen160/bfac.git
		cd bfac || return
		pip3 install -r requirements.txt
		sudo python3 setup.py install
	fi


	echo -e "[$GREEN+$RESET] installing smuggler .."
	if [ -e "$HOME"/tools/smuggler ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/defparam/smuggler.git
	fi


	echo -e "[$GREEN+$RESET] installing aem-hacker .."
	if [ -e "$HOME"/tools/aem-hacker ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/0ang3el/aem-hacker
	fi



	echo -e "[$GREEN+$RESET] installing jwt-pwn .."
	if [ -e "$HOME"/tools/jwt-pwn ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/mazen160/jwt-pwn.git
		cd jwt-pwn || return
	fi

	echo -e "[$GREEN+$RESET] installing XSS-Catcher .."
	if [ -e "$HOME"/tools/XSS-Catcher ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/daxAKAhackerman/XSS-Catcher.git
		cd XSS-Catcher || return
		# make start
	fi


}

: 'Github tools'
getPostExploitTools(){
	cd ~/tools

	echo -e "[$GREEN+$RESET] installing LinEnum, PEASS, linux-exploit-suggester and windows-exploit-suggester.."
	git clone https://github.com/rebootuser/LinEnum.git linenum
	git clone https://github.com/carlospolop/PEASS-ng.git peass
	git clone https://github.com/mzet-/linux-exploit-suggester.git
	git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester.git
	echo -e "[$GREEN+$RESET] Done."

}

: 'Other tools'
getGeneralTools(){
	cd ~/tools
	echo -e "[$GREEN+$RESET] Installing masscan.."
	if [ -e /usr/local/bin/masscan ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		cd "$HOME"/tools/ || return
		git clone https://github.com/robertdavidgraham/masscan
		cd "$HOME"/tools/masscan || return
		make -j
		sudo cp bin/masscan /usr/local/bin/masscan
		cd "$HOME"/tools/ || return
		echo -e "[$GREEN+$RESET] Done."
	fi

	# You can manually get this if you see the need for it
	# echo -e "[$GREEN+$RESET] Installing nmap vulners script.."
	# sudo wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse -O /usr/share/nmap/scripts/vulners.nse && sudo nmap --script-updatedb
	# echo -e "[$GREEN+$RESET] Done."

	echo -e "[$GREEN+$RESET] Installing metasploit framework (Seriously, get a cup of coffee or something).."
	if [ -e ~/tools/metasploit-framework/ ] || [ -e /usr/bin/msfconsole ]; then
		echo -e "[$GREEN+$RESET] Already installed."
	else
		git clone https://github.com/rapid7/metasploit-framework.git
		cd metasploit-framework/
		sudo gem update --system
		sudo gem install bundler nokogiri json atomic
		bundle install
		cd ..
		echo -e "[$GREEN+$RESET] Done."
	fi
}

: 'start of main program'
displayLogo
getBasicRequirements
getGeneralTools
getPostExploitTools
getWordlists
getWebTools






