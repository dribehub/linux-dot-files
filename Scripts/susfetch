#!/bin/bash

# used jp2a to make ascii art https://github.com/cslarsen/jp2a
# copied neofetch https://github.com/dylanaraps/neofetch

userhost="$USER@$HOSTNAME"		# username@hostname 

echo
echo -e "             .'.. .',, .        \033[1m$userhost\033[0m"
echo -n "            .;xOOOOOkdo:,'      "

for i in $(seq 1 ${#userhost})	# print hypens the same length as userhost
do
echo -n -e "\033[1m-\033[0m"
done

echo -e "\n           .;XXK0OO00KNNO''.    \033[1mOS\033[0m: SusOS $(uname -m)"													# susOS
echo -e "          ..0l.;loxxxl;:XK,.    \033[1mKernel\033[0m: SusKernel $(uname -r | cut -f1 -d"-")"							# kernel
echo -e "          .kNk..;cc:;,';XN0..   \033[1mUptime\033[0m: $(uptime -p | sed 's/up //')"									# uptime
echo -e "          cXNNNOxddxk0NNNNNl.   \033[1mShell\033[0m: $SHELL"															# shell
echo -e "         .KNNNNNNNNNNNNNNNNx.   \033[1mDE/WM\033[0m: $XDG_CURRENT_DESKTOP"												# de/wm
echo -e "         cNNNNNNNNNNNNNNNNN0.   \033[1mTerminal\033[0m: $(ps -p $(ps -o ppid= -p $PPID) -o comm=)"						# terminal
echo -e "         ONNNNNNNNNNNNNNNNNK.   \033[1mCPU\033[0m: $(cat /proc/cpuinfo | grep "model name" | uniq | sed 's/.*: //')"	# cpu
echo -e "        'XNNNNNNNNNNNNNNNNNX'   \033[1mGPU\033[0m: $(lspci | grep VGA | sed 's/.*: //')"								# gpu
read ramtotal ramused <<< $(free -h --si | grep Mem | sed 's/.*Mem://')															# ram
echo -e "        lNNNNNNNNNNNNNNNNNNN,   \033[1mMemory\033[0m: $(echo $ramused | cut -f1 -d" ") / $ramtotal"

echo -e "       .ONNNx,      'ONNNNNN: "
echo -e "      .,XNNK.        'XNNNNNc "
echo -e " .;ccc,kNNNN:        ,XNNNNN:   \033[40m    \033[41m    \033[42m    \033[43m    \033[44m    \033[45m    \033[46m    \033[47m    \033[0m"
echo -e " '0XNNNNNXKk.     ...oNNNNNN;   \033[100m    \033[101m    \033[102m    \033[103m    \033[104m    \033[105m    \033[106m    \033[107m    \033[0m"
echo -e "               .'kKXXNNNNNN0. "
echo -e "                 ,kO00Oxd,    "

#             .'.. .',, .      
#            .;xOOOOOkdo:,'    
#           .;XXK0OO00KNNO''.  
#          ..0l.;loxxxl;:XK,.  
#          .kNk..;cc:;,';XN0.. 
#          cXNNNOxddxk0NNNNNl. 
#         .KNNNNNNNNNNNNNNNNx. 
#         cNNNNNNNNNNNNNNNNN0. 
#         ONNNNNNNNNNNNNNNNNK. 
#        'XNNNNNNNNNNNNNNNNNX' 
#        lNNNNNNNNNNNNNNNNNNN, 
#       .ONNNx,      'ONNNNNN: 
#      .,XNNK.        'XNNNNNc 
# .;ccc,kNNNN:        ,XNNNNN: 
# '0XNNNNNXKk.     ...oNNNNNN; 
#               .'kKXXNNNNNN0. 
#                 ,kO00Oxd,
