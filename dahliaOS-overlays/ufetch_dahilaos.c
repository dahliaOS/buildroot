#!/bin/sh
#
# ufetch fork dahila os

## INFO
 
# user is already defined
os='Dahila OS'
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
shell="$(basename "$SHELL")"
de='Pangolin'

## DEFINE COLORS

# probably don't change these
if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
	reset="$(tput sgr0)"
fi

# you can change these
lc="${reset}${bold}${red}"        # labels
nc="${reset}${bold}${white}"        # user and hostname
ic="${reset}"                       # info
c0="${reset}${red}"               # first color

## OUTPUT

cat <<EOF

${c0}                                      #%%%,                             ${nc}OS:${ic}${os}${reset}                                
${c0}                                   ,%%%%%%%%%                           ${lc}KERNEL:${ic}${kernel}${reset}        
${c0}                                 #%%%%%%%%%%%%%*                        ${lc}UPTIME:${ic}${uptime}${reset}         
${c0}                   /%%%%%%%%%%%%%%%%%%%%%%%%%%%%%############           ${lc}SHELL:${ic}${shell}${reset}        
${c0}                   /%%%%%%%%%%%%%%%%%%%%%%%%%%%##############           ${lc}DE:${ic}${de}${reset}        
${c0}                   /%%%%%%%%%%%%%%#*        ./###############                
${c0}                   /%%%%%%%%%%/                   ###########                   
${c0}                   /%%%%%%%%                        *########                   
${c0}                  #%%%%%%%*                           ########,                 
${c0}               ,%%%%%%%%%*                             ##########               
${c0}             #%%%%%%%%%%%                              .###########,            
${c0}           %%%%%%%%%%%%%%                               ############(*          
${c0}             *%%%%%%%%%%%                              .#########((             
${c0}                #%%%%%%%#/                             #######((*               
${c0}                  ,%%%#####                           ######((                  
${c0}                   *########*                       ######(((                   
${c0}                   *###########.                 *#####((((((                   
${c0}                   *###############(*.    .,/#######(((((((((                   
${c0}                   *##############################(((((((((((                   
${c0}                   *############################(((((((((((((                   
${c0}                                 ,###########((                                 
${c0}                                    (#####((*                                   
${c0}                                      ,#((                                      
                                                                      
EOF
