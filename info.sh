#! /bin/bash

display_program_name() {
    echo -e "\x1B[36;1m"
    echo " ____   ____   ___ _   _ _____ ___"
    echo "|  _ \ / ___| |_ _| \ | |  ___/ _ \\"
    echo "| |_) | |      | ||  \| | |_ | | | |"
    echo "|  __/| |___   | || |\  |  _|| |_| |"
    echo "|_|    \____| |___|_| \_|_|   \___/"
    echo -e "\x1B[0m"
    sleep 1
    echo
}

sudo_check(){
  if [ "$EUID" -ne 0 ];then 
    >&2 echo -e "\x1B[31;1mPlease run with sudo\x1B[0m"
    exit 1
  fi
}

install_via_apt() {
    echo "Trying to install $1 via apt"
    apt-get --version > /dev/null 2> /dev/null
    if [ $? -eq 0 ]; then
        apt-get install $1 -y > /dev/null 2> /dev/null
        echo "Install success"
        return 0
    fi
    echo "Failed to install"
    return 1
}

install_software() {
    if [ $# -ne 1 ]; then
        echo -e "\x1B[31;1minstall_software: software is required as argument "
        echo -e "!\x1B[0m"
    else
        install_via_apt $1
        if [ $? -eq 1 ]; then
            >&2 echo -e "\x1B[31;1mPlease install $1\x1B[0m"
            exit 2
        fi
    fi
}

check_lscpu() {
    lscpu --version > /dev/null 2> /dev/null
    if [ $? != 0 ]; then
        install_software "lscpu"
    fi
}

lscpu_minimal_output() {
    lscpu | awk -v CPU_THREADS=0 '{
        if ($1 == "CPU(s):" ||
            ($1 == "Model" && $2 == "name:") ||
            ($1 == "CPU" && $3 == "MHz:")) {
            print $0;
        }
        if ($1 == "Thread(s)" && $2 == "per" && $3 == "core:") {
            CPU_THREADS = $4;
        }
        if ($1 == "Core(s)" && $2 == "per" && $3 == "socket:") {
            print $0;
            CPU_THREADS = ($4 * CPU_THREADS);
            print "Total threads : ", CPU_THREADS;
        }
    }'
}

check_dmidecode() {
    dmidecode --version > /dev/null 2> /dev/null
    if [ $? != 0 ]; then
        install_software "dmidecode"
    fi
}

dmidecode_minimal_output() {
    dmidecode 3.3 | awk '{
        if ($1 == "Socket" && $2 == "Designation:" && $4 != "Cache") {
            print $0;
        }
    }'
    dmidecode 3.3 --type memory | awk -v TOTAL_RAM=0 '{
        if ($1 == "Size:") {
                print "\nStick ", TOTAL_RAM, "\n", $0;
                TOTAL_RAM += 1;
        }
        if ($1 == "Type:" || $1 == "Speed:") {
            print $0;
        }
    }
    END {
        print "Total ram stick : ", TOTAL_RAM;
    }'
}

main() {
    display_program_name
    sudo_check
    check_lscpu
    check_dmidecode
    lscpu_minimal_output
    dmidecode_minimal_output
}

main
