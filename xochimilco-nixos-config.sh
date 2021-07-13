sudo nixos-generate-config --root /mnt

# get the disk UUID for sda3
ls -lha /dev/disk/by-uuid

# Edit my config file to include LUKS stuff
sudo nano /mnt/etc/nixos/hardware-configuration.nix
sudo nano /mnt/etc/nixos/configuration.nix

# grub
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    enableCryptodisk = true;
    device = "nodev";
  };

# luks
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/<the uuid of /dev/sda2 in this example>";
      preLVM = true;
    };
  };

sudo nixos-install

sudo reboot

# Log in as root and add an account
useradd -c 'Me' -m me
passwd me
