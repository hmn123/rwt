[ "$(id -u)" -ne 2000 ] && echo "No shell permissions." && exit 1

echo ""
echo "**************************************"
echo "*   RiProG Open Source @ RiOpSo   *"
echo "**************************************"
echo "*      Muhammad Rizki @ RiProG      *"
echo "**************************************"
echo ""

sleep 2

echo "Removing Angle Setting"

sleep 2

angle_remove() {
settings delete global angle_debug_package
settings delete global angle_gl_driver_selection_pkgs
settings delete global angle_gl_driver_selection_values
}

angle_remove > /dev/null 2>&1 

sleep 2

echo "Angle Setting Removed"

sleep 2

echo "Changes applied in next reboot"
