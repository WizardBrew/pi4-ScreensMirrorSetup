# 🧙‍♂️ WizardCloud 3.5" LCD Setup Script

#!/bin/bash

# 📦 Step 1: Install dependencies
sudo apt-get update
sudo apt-get install -y libraspberrypi-dev libraspberrypi0 cmake git build-essential

# 🧠 Step 2: Clone and build fbcp
git clone https://github.com/juj/fbcp.git
cd fbcp
mkdir build && cd build
cmake ..
make
sudo install fbcp /usr/local/bin/fbcp

# ⚙️ Step 3: Configure /boot/config.txt
echo "🔧 Updating /boot/config.txt..."
sudo sed -i '/

\[all\]

/a \
gpu_mem=128\n\
hdmi_force_hotplug=1\n\
dtparam=i2c_arm=on\n\
dtparam=spi=on\n\
enable_uart=1\n\
dtoverlay=tft35a:rotate=270\n\
hdmi_group=2\n\
hdmi_mode=87\n\
hdmi_cvt 480 320 60 6 0 0 0\n\
hdmi_drive=2\n\
max_framebuffers=2' /boot/config.txt

# 🚀 Step 4: Auto-start fbcp on boot
echo "🔁 Adding fbcp to /etc/rc.local..."
if ! grep -q "fbcp &" /etc/rc.local; then
  sudo sed -i '/^exit 0/i /usr/local/bin/fbcp &' /etc/rc.local
fi

# 🔁 Step 5: Reboot to apply changes
echo "✅ Setup complete. Rebooting..."
sudo reboot


# 🧪 Optional: Test Framebuffer Directly
sudo dd if=/dev/fb0 of=/dev/fb1 bs=1M

sudo apt-get install fbi
sudo fbi -T 1 -d /dev/fb1 --noverbose -a /usr/share/plymouth/themes/pix/splash.png

