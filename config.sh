[ "$(id -u)" -ne 2000 ] && echo "No shell permissions." && exit 1

package_list=$(cmd package list packages -3 | cut -f 2 -d ":")
angle_apply() {
angle_pkg_filter=" module.angle.controller"
angle_driver_filter="angle"
while IFS= read -r list || [[ -n "$list" ]]; do
angle_pkg_filter+=","$list
angle_driver_filter+=","angle
done < ${0%/*}/list.txt
settings put global angle_debug_package org.chromium.angle
settings put global angle_gl_driver_selection_pkgs "$angle_pkg_filter"
settings put global angle_gl_driver_selection_values "$angle_driver_filter"
}


echo ""
echo "**************************************"
echo "*   RiProG Open Source @ RiOpSo   *"
echo "**************************************"
echo "*      Muhammad Rizki @ RiProG      *"
echo "**************************************"
echo ""

sleep 2

function show_menu() {
    echo ""
    echo -e "\033[1mANGLE Controller\033[0m"
    echo ""
    echo "Select app to use ANGLE renderer:"
    echo ""
    count=1
    for package in $package_list; do
        status=$(cat ${0%/*}/list.txt | grep "$package")
        if [[ ! $status ]]; then
            echo -e "\033[31m$count. $package\033[0m"
        else
            echo -e "\033[32m$count. $package\033[0m"
        fi
        ((count++))
    done
    echo "$count. exit"
}

function add_remove_angle() {
    status=$(cat ${0%/*}/list.txt | grep "$1")
    if [[ $status ]]; then
        sed -i "/$1/d" ${0%/*}/list.txt
    else
        echo "$1" >> ${0%/*}/list.txt
    fi
}

while true; do
    show_menu
    echo ""
    echo -n "Select number: "
    read choice
    if [ "$choice" == $(($count)) ]; then
        angle_apply > /dev/null 2>&1 
        sleep 2
        echo ""
        echo "Changes apllied in next reboot"
        echo ""
        exit 0
    elif [ "$choice" -ge 1 ] && [ "$choice" -lt $(($count)) ]; then
        package=$(echo $package_list | cut -d ' ' -f $choice)
        add_remove_angle $package
    else
        echo "invalid select"
    fi
    echo
done