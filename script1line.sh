# one liner

sudo apt-get update && sudo apt-get install -y libraspberrypi-dev libraspberrypi0 cmake git build-essential && git clone https://github.com/juj/fbcp.git && cd fbcp && mkdir build && cd build && cmake .. && make && sudo install fbcp /usr/local/bin/fbcp && sudo sed -i '/

\[all\]

/a gpu_mem=128\nhdmi_force_hotplug=1\ndtparam=i2c_arm=on\ndtparam=spi=on\nenable_uart=1\ndtoverlay=tft35a:rotate=270\nhdmi_group=2\nhdmi_mode=87\nhdmi_cvt 480 320 60 6 0 0 0\nhdmi_drive=2\nmax_framebuffers=2' /boot/config.txt && sudo sed -i '/^exit 0/i /usr/local/bin/fbcp &' /etc/rc.local && sudo reboot
