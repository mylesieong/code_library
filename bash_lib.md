# Bash

## Migration

$md5sum -b {filename}
$sha1sum -b {filename}

### vncsever
$ vncserver :1
$ vncserver -kill :1

### Find a file with regex
$find {search-path} -name "\*.pdf"
$find (search-path} -type f              //指定查找文件類型文件
p.s. default search into sub-directories.

### How to make a batch file
1. touch and edit a file with header #!/bin/bash and your command below
3. chmod +x myfile.sh
4. $./myfile.sh

$sudo rm -R {target_folder}  //Delete a folder with all its content
$sudo chmod u+w {target_file} //Change Read-only to Editable
$sudo chmod a+w -R {filename} //Chmod resursively
$ set //Show all environment variables
$ echo $MAVEN_HOME //Show 1 environment variable

[variableUnzip a tar filename]filename$ sudo tar -xf {file.tar.gz} -C {target direcotry}
$ sudo tar zxvf {filename} 
-x extract
-f 指明後面的參數是文件名
-C change result to follow path
-z 指明是tar.gz類型
-v verbolsely state process$ sudo tar -xf {file.tar.gz} -C {target direcotry}
$ sudo tar zxvf {filename} 
-x extract
-f 指明後面的參數是文件名
-C change result to follow path
-z 指明是tar.gz類型
-v verbolsely state process$ sudo tar -xf {file.tar.gz} -C {target direcotry}
$ sudo tar zxvf {filename} 
-x extract
-f 指明後面的參數是文件名
-C change result to follow path
-z 指明是tar.gz類型
-v verbolsely state process$ sudo tar -xf {file.tar.gz} -C {target direcotry}
$ sudo tar zxvf {filename} 
-x extract
-f 指明後面的參數是文件名
-C change result to follow path
-z 指明是tar.gz類型
-v verbolsely state process$ sudo tar -xf {file.tar.gz} -C {target direcotry}
$ sudo tar zxvf {filename} 
-x extract
-f 指明後面的參數是文件名
-C change result to follow path
-z 指明是tar.gz類型
-v verbolsely state process
[processHistory command]command$ history
$ ! n (n is the history command no.)$ history
$ ! n (n is the history command no.)$ history
$ ! n (n is the history command no.)$ history
$ ! n (n is the history command no.)$ history
$ ! n (n is the history command no.)
[noGrep command]command$ history | grep {searchparameter}
[searchparameterPiping command]command$ echo "String to be writen" > /etc/{some document}
[documentinstall git]gitapt-get install git-all
[allinstall unity]unityapt-get install ubuntu-desktop
[desktopvncsever]desktopvncseverapt-get install vnc4server
[vnc4servervariable]vnc4servervariable/*set*/ JAVA_HOME=~/jdk
/*export*/ export JAVA_HOME/*set*/ JAVA_HOME=~/jdk
/*export*/ export JAVA_HOME/*set*/ JAVA_HOME=~/jdk
/*export*/ export JAVA_HOME/*set*/ JAVA_HOME=~/jdk
/*export*/ export JAVA_HOME
[JAVA_HOMEcreate link]linkln -s -v $CATALINA_HOME/bin/catalina.sh ~/tomcat
-s是造soft link的意思, -v是有什麼講出來的意思ln -s -v $CATALINA_HOME/bin/catalina.sh ~/tomcat
-s是造soft link的意思, -v是有什麼講出來的意思ln -s -v $CATALINA_HOME/bin/catalina.sh ~/tomcat
-s是造soft link的意思, -v是有什麼講出來的意思ln -s -v $CATALINA_HOME/bin/catalina.sh ~/tomcat
-s是造soft link的意思, -v是有什麼講出來的意思
[vStop job]jobCtrl + C
[jobCtrlcheck a port]portnc -v 127.0.0.1 8080
[8080send udp package]packageudp: echo "foobar" | nc -u -w1 localhost 5000
tcp: echo "foobar" | nc 127.0.0.1 5000udp: echo "foobar" | nc -u -w1 localhost 5000
tcp: echo "foobar" | nc 127.0.0.1 5000udp: echo "foobar" | nc -u -w1 localhost 5000
tcp: echo "foobar" | nc 127.0.0.1 5000udp: echo "foobar" | nc -u -w1 localhost 5000
tcp: echo "foobar" | nc 127.0.0.1 5000
[5000open a listen portnc]portncudp: nc -lu localhost 5000
tcp: nc -l 5000udp: nc -lu localhost 5000
tcp: nc -l 5000udp: nc -lu localhost 5000
tcp: nc -l 5000udp: nc -lu localhost 5000
tcp: nc -l 5000
[5000scan ports]portstcp: nc -vnz -w 1 192.168.233.208 1-1000 2000-3000
udp: nc -vnzu 192.168.1.8 1-65535tcp: nc -vnz -w 1 192.168.233.208 1-1000 2000-3000
udp: nc -vnzu 192.168.1.8 1-65535tcp: nc -vnz -w 1 192.168.233.208 1-1000 2000-3000
udp: nc -vnzu 192.168.1.8 1-65535tcp: nc -vnz -w 1 192.168.233.208 1-1000 2000-3000
udp: nc -vnzu 192.168.1.8 1-65535
[65535response in portstcp]portstcpclient: echo "request for anything" | nc 127.0.0.1 5000
server: nc -l 127.0.0.1 5000 < response.htmlclient: echo "request for anything" | nc 127.0.0.1 5000
server: nc -l 127.0.0.1 5000 < response.htmlclient: echo "request for anything" | nc 127.0.0.1 5000
server: nc -l 127.0.0.1 5000 < response.htmlclient: echo "request for anything" | nc 127.0.0.1 5000
server: nc -l 127.0.0.1 5000 < response.html
[htmlresponse in port w HTTP protocol]protocolclient: [browser]>http://139.162.20.124:9000/
client: echo -ne "GET / HTTP/1.0\r\n\r\n" | nc 127.0.0.1 9000
server: while true; do nc -l 9000 < response.html; doneclient: [browser]>http://139.162.20.124:9000/
client: echo -ne "GET / HTTP/1.0\r\n\r\n" | nc 127.0.0.1 9000
server: while true; do nc -l 9000 < response.html; doneclient: [browser]>http://139.162.20.124:9000/
client: echo -ne "GET / HTTP/1.0\r\n\r\n" | nc 127.0.0.1 9000
server: while true; do nc -l 9000 < response.html; doneclient: [browser]>http://139.162.20.124:9000/
client: echo -ne "GET / HTTP/1.0\r\n\r\n" | nc 127.0.0.1 9000
server: while true; do nc -l 9000 < response.html; done
[doneSend HTTP request]requestecho -ne "GET / HTTP/1.0\r\n\r\n" | nc www.google.com 80
[80setup env variableUnzip]variableUnzipIn linux, there is a script call .bashrc in your ~ directory that run on your boot. You can export your env variable in this script. 
[scriptcheck cpu]cpucat /proc/cpuinfo
[cpuinfoscan target]targetThe format of nmap is: $nmap [Scan types] [Options] {target_ip_address}
$namp -sS 127.0.0.1
$nmap -sS 127.*.*.1-255
$nmap -sX -p 20,30,40,8080 127.0.0.1The format of nmap is: $nmap [Scan types] [Options] {target_ip_address}
$namp -sS 127.0.0.1
$nmap -sS 127.*.*.1-255
$nmap -sX -p 20,30,40,8080 127.0.0.1The format of nmap is: $nmap [Scan types] [Options] {target_ip_address}
$namp -sS 127.0.0.1
$nmap -sS 127.*.*.1-255
$nmap -sX -p 20,30,40,8080 127.0.0.1The format of nmap is: $nmap [Scan types] [Options] {target_ip_address}
$namp -sS 127.0.0.1
$nmap -sS 127.*.*.1-255
$nmap -sX -p 20,30,40,8080 127.0.0.1
[127basic ops]opsDelete lines:
> sed '/^u/d' input.txt              //delete lines start with char 'u'Delete lines:
> sed '/^u/d' input.txt              //delete lines start with char 'u'Delete lines:
> sed '/^u/d' input.txt              //delete lines start with char 'u'Delete lines:
> sed '/^u/d' input.txt              //delete lines start with char 'u'
[charClear all comment and save java source to a file with suffix 'Cleaned'Cleaned]Cleanedfor f in $(find *.java -type f); do sed '/*/d' $f > ${f}.Cleaned.java; done
[donerun a cmd at background]backgroundRun a cmd at background:
> {command_body} &
Check the process:
> top
> ps -a
> pstreeRun a cmd at background:
> {command_body} &
Check the process:
> top
> ps -a
> pstreeRun a cmd at background:
> {command_body} &
Check the process:
> top
> ps -a
> pstree
[pstreeIntroduce ICONV to convert encoding and XXD to cat in HEX]HEXConvert from file a to file b: 
> iconv -f ASCII -t UTF-8 < fileA.txt > fileB.txt
Show the encoding option:
> iconv -l 
Show HEX of a file:
> xxd filea.txtConvert from file a to file b: 
> iconv -f ASCII -t UTF-8 < fileA.txt > fileB.txt
Show the encoding option:
> iconv -l 
Show HEX of a file:
> xxd filea.txtConvert from file a to file b: 
> iconv -f ASCII -t UTF-8 < fileA.txt > fileB.txt
Show the encoding option:
> iconv -l 
Show HEX of a file:
> xxd filea.txt
[txtexample]txtexample$ tar cvf wallpaper.tar WallPaper    //package all content in WallPaper folder
$ tar tf wallpaper.tar  //display content in pack
$ tar xvf wallpaper.tar   //extract pack$ tar cvf wallpaper.tar WallPaper    //package all content in WallPaper folder
$ tar tf wallpaper.tar  //display content in pack
$ tar xvf wallpaper.tar   //extract pack$ tar cvf wallpaper.tar WallPaper    //package all content in WallPaper folder
$ tar tf wallpaper.tar  //display content in pack
$ tar xvf wallpaper.tar   //extract pack
[packPackage option]optioncreate a package: cvf
c–create create a new archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVE
display the content: tf
t–list list the contents of an archive
f–file=ARCHIVE use archive file or device ARCHIVE
extract the package: xvf
x–extract, –get extract files from an archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVEcreate a package: cvf
c–create create a new archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVE
display the content: tf
t–list list the contents of an archive
f–file=ARCHIVE use archive file or device ARCHIVE
extract the package: xvf
x–extract, –get extract files from an archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVEcreate a package: cvf
c–create create a new archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVE
display the content: tf
t–list list the contents of an archive
f–file=ARCHIVE use archive file or device ARCHIVE
extract the package: xvf
x–extract, –get extract files from an archive
v–verbose verbosely list files processed
f–file=ARCHIVE use archive file or device ARCHIVE
[ARCHIVEregex]ARCHIVEregex$ find -regex ".*ABC.*"
1. option -iregex is for non capital sensitive 
2. Notice that it’s a path match but not a search (the  -name option for example is a search)$ find -regex ".*ABC.*"
1. option -iregex is for non capital sensitive 
2. Notice that it’s a path match but not a search (the  -name option for example is a search)$ find -regex ".*ABC.*"
1. option -iregex is for non capital sensitive 
2. Notice that it’s a path match but not a search (the  -name option for example is a search)
[searchbasic    ]searchbasicpushd {path} //perform cd and push the path to stack
popd {path} //pop the stack and cd to the poped path
dirs //show your DIRectory Stackpushd {path} //perform cd and push the path to stack
popd {path} //pop the stack and cd to the poped path
dirs //show your DIRectory Stackpushd {path} //perform cd and push the path to stack
popd {path} //pop the stack and cd to the poped path
dirs //show your DIRectory Stack
[Stackreplace : character with \name]nameecho $PATH | sed s/:/\\n/g
[sed找出bash在call哪個vim]vimfor f in $(echo $PATH | sed s/:/\\n/g);
    do find $f -name "vim.exe";
donefor f in $(echo $PATH | sed s/:/\\n/g);
    do find $f -name "vim.exe";
donefor f in $(echo $PATH | sed s/:/\\n/g);
    do find $f -name "vim.exe";
done
[donecut basic]basic* cut can accept data passed from pipe or as parameter
    $ cat abc.txt | cut -d':' -f1-5
    $ cut -d' ' -f1-5 abc.txt
* cut fix length 
    $ cut -c1-5 file.txt
    $ cut -c10- file.txt
* cut by delimiter (1-digit) and select fields with option f
    $ cut -d':' -f5
    $ cut -d':' -f2-6* cut can accept data passed from pipe or as parameter
    $ cat abc.txt | cut -d':' -f1-5
    $ cut -d' ' -f1-5 abc.txt
* cut fix length 
    $ cut -c1-5 file.txt
    $ cut -c10- file.txt
* cut by delimiter (1-digit) and select fields with option f
    $ cut -d':' -f5
    $ cut -d':' -f2-6* cut can accept data passed from pipe or as parameter
    $ cat abc.txt | cut -d':' -f1-5
    $ cut -d' ' -f1-5 abc.txt
* cut fix length 
    $ cut -c1-5 file.txt
    $ cut -c10- file.txt
* cut by delimiter (1-digit) and select fields with option f
    $ cut -d':' -f5
    $ cut -d':' -f2-6
[f2word count]countwc is a pipe command, its used to count file's word/line/byte count:
$ cat file.txt | wc -l  //count by lines
$ cat file.txt | wc -m //count by char
$ cat file.txt | wc -c //count by byteswc is a pipe command, its used to count file's word/line/byte count:
$ cat file.txt | wc -l  //count by lines
$ cat file.txt | wc -m //count by char
$ cat file.txt | wc -c //count by byteswc is a pipe command, its used to count file's word/line/byte count:
$ cat file.txt | wc -l  //count by lines
$ cat file.txt | wc -m //count by char
$ cat file.txt | wc -c //count by bytes
[bytesshasum x sha1sum]sha1sumCommand shasum is the extense version of sha1sum. Use below shasum syntax to perform sha1sum:
$ shasum -a 1 {file}
$ shasum -a 512 {file}   // perform SHA512 algorithmCommand shasum is the extense version of sha1sum. Use below shasum syntax to perform sha1sum:
$ shasum -a 1 {file}
$ shasum -a 512 {file}   // perform SHA512 algorithmCommand shasum is the extense version of sha1sum. Use below shasum syntax to perform sha1sum:
$ shasum -a 1 {file}
$ shasum -a 512 {file}   // perform SHA512 algorithm
[algorithmbasic curl]curl$ curl 127.0.0.1:8080/date-dummy   //use default GET for url
[urlCheck ssh fail atttemp on host]host$ grep sshd.*Failed /var/log/auth.log      //not only ssh login attemps, sudo attemp and other authoritzation related log 
[logAdduser to host]host$ adduser new_user_name
[new_user_nameUpdate public key of a host]hostUpdate file: ~/.ssh/known_hosts
* if a public key from a known host is updated, simply delete the old known_host entryUpdate file: ~/.ssh/known_hosts
* if a public key from a known host is updated, simply delete the old known_host entryUpdate file: ~/.ssh/known_hosts
* if a public key from a known host is updated, simply delete the old known_host entry
[entryHow to use hydra to crack a ssh]ssh1. Use nmap to find out whether ssh is on host and the possible username: $nmap -sS -A ip_address
2. Prepare a wordlist.txt (potential password) support the atk
3. Use THC-hydra the tool to hack the target ssh: $ hydra -user {username} -list {path_to_wordlist} {target_ip} ssh
ref: youtube/chris haralson: How to crack an SSH password1. Use nmap to find out whether ssh is on host and the possible username: $nmap -sS -A ip_address
2. Prepare a wordlist.txt (potential password) support the atk
3. Use THC-hydra the tool to hack the target ssh: $ hydra -user {username} -list {path_to_wordlist} {target_ip} ssh
ref: youtube/chris haralson: How to crack an SSH password1. Use nmap to find out whether ssh is on host and the possible username: $nmap -sS -A ip_address
2. Prepare a wordlist.txt (potential password) support the atk
3. Use THC-hydra the tool to hack the target ssh: $ hydra -user {username} -list {path_to_wordlist} {target_ip} ssh
ref: youtube/chris haralson: How to crack an SSH password
[passwordIntro]passwordIntrofcrackzip is an util to crack encrypted zip file. 
[fileBasic]fileBasic$ ssh -v myles@hostname //v for verbose
[verboseTrouble-shoot "Connection reset by xxx.xxx.xxx.xxx" after a certain idle time at client side]sideref: https://www.bjornjohansen.no/ssh-timeout
A. PREVENT SSH TIMEOUT ON THE CLIENT SIDE
Edit your local SSH config file in ~/.ssh/config and add the following line:
` ServerAliveInterval 120
(This will send a “null packet” every 120 seconds on your SSH connections to keep them alive.)

B. PREVENT SSH TIMEOUT ON THE SERVER SIDE
If you’re a server admin, you can add the following to your SSH daemon config in /etc/ssh/sshd_config on your servers to prevent the clients to time out – so they don’t have to modify their local SSH config:
` ClientAliveInterval 120
` ClientAliveCountMax 720
This will make the server send the clients a “null packet” every 120 seconds and not disconnect them until the client have been inactive for 720 intervals (120 seconds * 720 = 86400 seconds = 24 hours).ref: https://www.bjornjohansen.no/ssh-timeout
A. PREVENT SSH TIMEOUT ON THE CLIENT SIDE
Edit your local SSH config file in ~/.ssh/config and add the following line:
` ServerAliveInterval 120
(This will send a “null packet” every 120 seconds on your SSH connections to keep them alive.)

B. PREVENT SSH TIMEOUT ON THE SERVER SIDE
If you’re a server admin, you can add the following to your SSH daemon config in /etc/ssh/sshd_config on your servers to prevent the clients to time out – so they don’t have to modify their local SSH config:
` ClientAliveInterval 120
` ClientAliveCountMax 720
This will make the server send the clients a “null packet” every 120 seconds and not disconnect them until the client have been inactive for 720 intervals (120 seconds * 720 = 86400 seconds = 24 hours).
[hoursIntro]hoursIntroNcrack is an sibling project of nmap as another cracking tool like hydra, but it seems not working well when I try to apply it on my linode sshd (no login attemp when check auth.log on host)
$ ncrack --user myles {target_ip}:{port}
source code on github.comNcrack is an sibling project of nmap as another cracking tool like hydra, but it seems not working well when I try to apply it on my linode sshd (no login attemp when check auth.log on host)
$ ncrack --user myles {target_ip}:{port}
source code on github.com
[comSetup Hosts and its benefic]beneficSetup hosts in file /etc/hosts. So that when in ping or ssh or other util, you can use the host alias directly like: $ ssh myles@myleslinode
[myleslinodelast command]command# 3 ways to find command history
* sudo !! (aka the fuck)
* fc -l -10
* history# 3 ways to find command history
* sudo !! (aka the fuck)
* fc -l -10
* history
[historySource management]management# Config of apt-get
There is config file of source provider address: /etc/apt/source.list, you can add your address if you are sure that the software you want to donwload is not available in public standard mirror. 
# Unmet Error
It is possible that adding new source address to this config file will cause **unmet** error when installing packages. This error message is like: Install xxx : Depends libxxx (version xxx) but version xxx is to be installed. To solve this problem, remove source address that caused error and run below statement to resume:
* apt-get clean
* apt-get autoclean
* apt-get update# Config of apt-get
There is config file of source provider address: /etc/apt/source.list, you can add your address if you are sure that the software you want to donwload is not available in public standard mirror. 
# Unmet Error
It is possible that adding new source address to this config file will cause **unmet** error when installing packages. This error message is like: Install xxx : Depends libxxx (version xxx) but version xxx is to be installed. To solve this problem, remove source address that caused error and run below statement to resume:
* apt-get clean
* apt-get autoclean
* apt-get update
[updateBasic]updateBasic# What is rfkill
RF-kill is like an software level hardware switch. Say switch on/off the bluetooth/wireless service or others.
# Basic command
` sudo rfkill list all`
` sudo rfkill unblock all`# What is rfkill
RF-kill is like an software level hardware switch. Say switch on/off the bluetooth/wireless service or others.
# Basic command
` sudo rfkill list all`
` sudo rfkill unblock all`
[allList PCI Hardware]Hardware# What is lspci
List PCI command list all hardware that is detected on PCI at hardware level (which means a hardware that appeared on lspci doesn’t mean it's driver is installed and can perform)
# Common usage
` lspci | grep -I network`  //show the network card
` lspci | grep -I ethernet`  //show the ethernet port# What is lspci
List PCI command list all hardware that is detected on PCI at hardware level (which means a hardware that appeared on lspci doesn’t mean it's driver is installed and can perform)
# Common usage
` lspci | grep -I network`  //show the network card
` lspci | grep -I ethernet`  //show the ethernet port
[portA 輸入法 framework]framework# What is ibus
IBUS is a 輸入法 framework, it support chinese 倉頡, but make sure the system language installs chinese tradition at the first hand. Its on ubuntu but so far I only use the GUI of ibus. Ctrl-space to turn on an input method.# What is ibus
IBUS is a 輸入法 framework, it support chinese 倉頡, but make sure the system language installs chinese tradition at the first hand. Its on ubuntu but so far I only use the GUI of ibus. Ctrl-space to turn on an input method.
[methodPractice]methodPractice# Basic flow
* Download tarball: `wget {url} `
* Extract to /usr/local/src: `cd /usr/local/src; tar -zxvf ntp1.0.0.tar.gz`
* Config the make file: `cd ntp1.0.0/; ./configure --prefix=/usr/local/ntp`
* Make: `make clean; make; make check; make install`
* Link bin: can choose to build soft to /usr/local/bin or to add XXX_HOME and export XXX_HOME/bin to $PATH
* Link man: do something to MANPATH
# The Problem of arrangement
Consider a plan that set standard to install, bin putting and uninstall. If install without a clear domain, then its almost not possible to uninstall it later.# Basic flow
* Download tarball: `wget {url} `
* Extract to /usr/local/src: `cd /usr/local/src; tar -zxvf ntp1.0.0.tar.gz`
* Config the make file: `cd ntp1.0.0/; ./configure --prefix=/usr/local/ntp`
* Make: `make clean; make; make check; make install`
* Link bin: can choose to build soft to /usr/local/bin or to add XXX_HOME and export XXX_HOME/bin to $PATH
* Link man: do something to MANPATH
# The Problem of arrangement
Consider a plan that set standard to install, bin putting and uninstall. If install without a clear domain, then its almost not possible to uninstall it later.
[laterConcept]laterConcept# How to upgrade software wo patch
In the old tarball, use make to uninstall. Then download the new tarball, configure and make again. And still there can be a miss configure between 2 version (like when making the newer version, you forget to set some old setting)
# How patch help the upgrade
Use patch to update the source code, so that you dont need to configure the makefile again (keep the old config), but still need to make again or the software binaries will still not be updated/# How to upgrade software wo patch
In the old tarball, use make to uninstall. Then download the new tarball, configure and make again. And still there can be a miss configure between 2 version (like when making the newer version, you forget to set some old setting)
# How patch help the upgrade
Use patch to update the source code, so that you dont need to configure the makefile again (keep the old config), but still need to make again or the software binaries will still not be updated/
[updated# Advance option]option# Zip otpion
Use z in option to switch on the zip feature: `tar -czvf foo.tar.gz bar/`
> the f option must place before the file name!
# Ignore certain folder
`tar --exclude='.git' --exclude='target/' -czvf foo.tar.gz bar/`
> Make sure the exclude declare first
> This will exclude folder in that name among all levels of directory
# Ignore version controls
`tar --exclude-vcs ...`# Zip otpion
Use z in option to switch on the zip feature: `tar -czvf foo.tar.gz bar/`
> the f option must place before the file name!
# Ignore certain folder
`tar --exclude='.git' --exclude='target/' -czvf foo.tar.gz bar/`
> Make sure the exclude declare first
> This will exclude folder in that name among all levels of directory
# Ignore version controls
`tar --exclude-vcs ...`
[vcs# Basic Opts]Opts# What is pgp/ gpg
It is an util that implement RSA encryption and decryption methodology
# Installation
apt-cyg/ apt-get install gnupg 
# Operation flow - Create my key-pack and export my public key 
    * gpg --gen-key  //gpg will ask you a name and it will be regarded as the key id in the local key db
    * gpg --list-key
    * gpg --output "myles_public_key.asc" --export "mykey" //"mykey" is the key id in local key databse
# Operation flow - Decrypt file that is encrypted by others with my public key
    * gpg --decrypt-files "file_encrypt_with_my_public_key" //gpg will find a key in db that can decrypt
# Operation flow - Import other's public key and use it to encrypt file 
    * gpg --import {public_key_from_other.sac}
    * gpg --list-key  //In here learnt the key id of the newly imported key
    * gpg --recipient "their_keyid" --output "outputfilename.gpg" --encrypt "file_to_be_encrypted"
# Issue - trust someone's public key without asking when performing the encryptino
When gpg encrypt a file with an external public key, it will ask the user to trust it or not, with adding --trust-model always option at the head of the command, it will stop asking for user's validation:
`gpg --trust-model always --recipient "HKSP" --output e.gpg --encrypt UTF-8-demo.txt`# What is pgp/ gpg
It is an util that implement RSA encryption and decryption methodology
# Installation
apt-cyg/ apt-get install gnupg 
# Operation flow - Create my key-pack and export my public key 
    * gpg --gen-key  //gpg will ask you a name and it will be regarded as the key id in the local key db
    * gpg --list-key
    * gpg --output "myles_public_key.asc" --export "mykey" //"mykey" is the key id in local key databse
# Operation flow - Decrypt file that is encrypted by others with my public key
    * gpg --decrypt-files "file_encrypt_with_my_public_key" //gpg will find a key in db that can decrypt
# Operation flow - Import other's public key and use it to encrypt file 
    * gpg --import {public_key_from_other.sac}
    * gpg --list-key  //In here learnt the key id of the newly imported key
    * gpg --recipient "their_keyid" --output "outputfilename.gpg" --encrypt "file_to_be_encrypted"
# Issue - trust someone's public key without asking when performing the encryptino
When gpg encrypt a file with an external public key, it will ask the user to trust it or not, with adding --trust-model always option at the head of the command, it will stop asking for user's validation:
`gpg --trust-model always --recipient "HKSP" --output e.gpg --encrypt UTF-8-demo.txt`
[txtparameter style]styleps aux    //this is BSD style
ps -elf    //this is UNIX Style
grep --color    //this is GNU styleps aux    //this is BSD style
ps -elf    //this is UNIX Style
grep --color    //this is GNU style
[styleWatch a command repeatly]repeatlywatch -n 2 tree    // repeatly update tree command result to stdout by 2 second interval
[intervalList a directory with selected depth]depthtree -L 2   //list the directory with depth 2












## Handy tools
* du -sh .` `du -sh *   //Size of folder
* df    //Size of file system
* tar (--exclude='.git') -czvf foobar.tar.gz  //Tar compress file
* tar -xzvf foobar.tar.gz   //Tar uncompress file
* grep -nrw . -e "[0-9]{3}" --color -i  //full-text search with color highline and ignoring cases
* find . -maxdepth 2 -name build.gradle  //find files at a depth
* tree . -L 3

## Conflict of line-end
* If using cygwin on windows you will encounter errors like:
    * Invalid expression ^M
    * Invalid '\r' 
* Run `dos2unix` on files
* Turn git global config `core.autocrlf` to false

## Trouble shooting "command not found"
* Scenes: gradle daemon in jenkins server cannot reach root path | script cannot find `java` command | in any shell command not found
* Root cause: the PATH that passes to the worker object doesn't contain the cmd. If you can get correct PATH on testing env but not on production env, then they have diff PATH
* Case: When running a script, in script for example `java` can be not able to found because the path is somehow not passed to the script. We can create a link toward the target command to make it work: In ~/usr/bin, run `ln -s -f $JRE_HOME/bin/java`

## General command
* Check last cmd result: echo $?
* Make cmd result 0 even it goes wrong: rm folder/ || true


