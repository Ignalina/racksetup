Install rocky 9.1


-----------------------
step1 lang: any  
step2 Network: 10.1.1.10|20|30/24  
Step3 Guided Storage: Use Entire disk but OS disk. Leave 2xdisk empty  
Step4 Profile Setup: Your Server's name=*[1|2|3].*.*    (hostname -s will be used)   
Step5 Minimal install  

Adjust "install_app.sh" with given network/diskdevice name etc and prefered first time installation  

./install_app.sh  (will reboot)  
./install_app.sh X  
./install_app.sh Y  

