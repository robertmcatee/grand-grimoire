# get the disk UUID for sda3
ls -lha /dev/disk/by-uuid | grep sda4

sudo nixos-generate-config --root /mnt

# Edit my config file to include LUKS stuff
sudo nano /mnt/etc/nixos/hardware-configuration.nix
sudo nano /mnt/etc/nixos/configuration.nix

# grub
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = false;
    enableCryptodisk = true;
    device = "/dev/sda";
  };

# luks
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/<UUID OF SDA4!!>";
      preLVM = true;
    };
  };

sudo nixos-install

sudo reboot

# Log in as root and add an account
useradd -c 'Me' -m me
passwd me
