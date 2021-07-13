parted -a optimal /dev/sda unit mib
parted -a optimal /dev/sda mklabel gpt
parted -a optimal /dev/sda mkpart primary 1 3
parted -a optimal /dev/sda name 1 grub
parted -a optimal /dev/sda set 1 bios_grub on
parted -a optimal /dev/sda mkpart primary fat32 3 515
parted -a optimal /dev/sda name 2 boot
parted -a optimal /dev/sda set 2 BOOT on
parted -a optimal /dev/sda mkpart primary fat32 515 16515
parted -a optimal /dev/sda name 3 sagamorehill
parted -a optimal /dev/sda mkpart primary 16515 100%
parted -a optimal /dev/sda name 4 lvm
parted -a optimal /dev/sda set 4 lvm on

modprobe dm-crypt
sudo cryptsetup --type luks1 luksFormat /dev/sda4
sudo cryptsetup luksOpen /dev/sda4 lvm

lvm pvcreate /dev/mapper/lvm
vgcreate vg0 /dev/mapper/lvm

lvcreate -L 32G -n root vg0
lvcreate -L 16G -n tmp vg0
lvcreate -L 16G -n var vg0
lvcreate -L 8G -n varaudit vg0
lvcreate -L 8G -n varlog vg0
lvcreate -L 8G -n vartmp vg0
lvcreate -L 16G -n swap vg0
lvcreate -l 100%FREE -n home vg0

mkfs.vfat -F32 /dev/sda2
mkfs.vfat -F32 /dev/sda3
mkfs.btrfs /dev/mapper/vg0-root
mkfs.btrfs /dev/mapper/vg0-tmp
mkfs.btrfs /dev/mapper/vg0-var
mkfs.btrfs /dev/mapper/vg0-varaudit
mkfs.btrfs /dev/mapper/vg0-varlog
mkfs.btrfs /dev/mapper/vg0-vartmp
mkswap /dev/vg0/swap
mkfs.btrfs /dev/mapper/vg0-home

mkdir /mnt
mount /dev/mapper/vg0-root /mnt

mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

mkdir /mnt/tmp
mount /dev/mapper/vg0-tmp /mnt/tmp

mkdir /mnt/var
mount /dev/mapper/vg0-var /mnt/var

mkdir /mnt/var/audit
mount /dev/mapper/vg0-varaudit /mnt/var/audit

mkdir /mnt/var/log
mount /dev/mapper/vg0-varlog /mnt/var/log

mkdir /mnt/var/tmp
mount /dev/mapper/vg0-vartmp /mnt/var/tmp

mkdir /mnt/home
mount /dev/mapper/vg0-home /mnt/home

mkdir /usr/local
mkdir /usr/local/src
mkdir /usr/local/src/sagamorehill
mount /dev/sda3 /usr/local/src/sagamorehill

swapon /dev/vg0/swap
