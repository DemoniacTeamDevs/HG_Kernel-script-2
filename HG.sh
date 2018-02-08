#
##################################
# Gr2_srk  <gr2.stark@gmail.com> #	
# HB72K    <ghettoxx2@gmail.com> #	
# Script Para Compilar Kernel    #
##################################
#

#!/bin/bash

#Inicio
echo ''
echo "======================"
echo ''
echo " DemoniacTeamCompiler"
echo ''
echo "======================"
echo ''

#LINARIO
echo "***Verificando Linario...***"
echo ''
LIN=~/toolchain
if [ ! -d "$LIN" ]; then
git clone https://github.com/ArchiDroid/Toolchain.git -b linaro-4.9 toolchain
echo "***Se usará Linario existente***"
echo ''
fi

#SOURCE
echo ''
echo '***¿DESEA DESCARGAR SU SOURCE?***'
echo 'Diga si o no'
echo ''
read start
if [ "$start" = si ]; then
echo '***Ingrese la dirección de su source:***'
echo 'Ejemplo: https://github.com/Gr2007/android_kernel_huawei_msm8916-1.git'
echo ''
read SOURCE
echo ''
echo '***Nombre del branch***' 
echo 'Ejemplo: cm-12.1-caf'
echo ''
read branch
git clone $SOURCE -b $branch kernel
elif [ "$start" = no ]; then
echo '***Se tomara la carpeta por defecto***'
echo ''
fi
sleep 1s

#Cuestion
echo ''
echo '***Especifique la config del DEVICE***'
echo 'Ejemplo: wt6737m_35_n_defconfig'
echo ''
read DEVICE
echo ''
echo '<<<<<Edite sus modificaciones>>>>>'
echo 'Con su explorador de archivos edite la source del kernel'
echo ''
sleep 1s 
cd kernel
echo ''
echo '***Desea borrar la compilación anterior?***'
echo "Diga si o no:"
echo ''
read COMP
if [ "$COMP" = si ]; then
echo ''
echo '***Borrando compilaciones Anteriores***'
echo ''
make clean 
elif [ "$COMP" = no ]; then
echo ''
echo "***Escribiste -no-***"
echo '***se continuara con la compilación***'
echo ''
fi

#Compilacion
echo ''
echo '==================================='
echo ''
echo 'Compilando Kernel con toolchain'
echo ''
echo '==================================='
echo ''
echo '***Ingrese numero de nucleos de su Equipo +1***'
echo 'Ejemplo: Si su equipo cuenta con 4 nucleos debe ingresar el numero 5 '
read NUCLEO
make ARCH=arm $DEVICE
make -j$NUCLEO ARCH=arm CROSS_COMPILE=$PWD/toolchain/bin/arm-eabi-
cp arch/arm/boot/zImage '/home/$PWD/Desktop/BUILD'
find . -name '*ko' -exec cp '{}' '/home/$PWD/Desktop/BUILD' \

#FIN
echo ''
echo '========================================='
echo ''
echo 'Compilacion terminada, Felicidades'
echo ''
echo '========================================='
echo ''
sleep 10s
