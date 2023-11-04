# basic_ram_and_cpu_info

## Summary

I. [Introduction](#introduction)

II. [Requirements](#requirements)

III. [Run the program](#run-the-program)

IV. [Exit codes](#exit-codes)
1. [Rights](#1---rights)
2. [Script cant install required programs](#2---script-cant-install-required-programs)

## INTRODUCTION

This program will give you all the basics informations of your system
<br>Here is an exemple output :
```
 ____   ____   ___ _   _ _____ ___
|  _ \ / ___| |_ _| \ | |  ___/ _ \
| |_) | |      | ||  \| | |_ | | | |
|  __/| |___   | || |\  |  _|| |_| |
|_|    \____| |___|_| \_|_|   \___/


CPU(s):                             2
Model name:                         Pentium(R) Dual-Core  CPU      E5800  @ 3.20
GHz
Core(s) per socket:                 2
Total threads :  2
CPU max MHz:                        3200.0000
CPU min MHz:                        1200.0000
	Socket Designation: LGA 775

Stick  0 
 	Size: 2 GB
	Type: DDR2
	Speed: 800 MT/s

Stick  1 
 	Size: 2 GB
	Type: DDR2
	Speed: 800 MT/s

Stick  2 
 	Size: 2 GB
	Type: DDR2
	Speed: 800 MT/s

Stick  3 
 	Size: 2 GB
	Type: DDR2
	Speed: 800 MT/s
Total ram stick :  4
```

## REQUIREMENTS

lscpu and dmidecode (version 3.3)

## RUN THE PROGRAM

Please use sudo to run the program

## EXIT CODES

### 1 - Rights 

Please run as sudo

### 2 - Script can't install required programs

Please try to install programs on your distribution
