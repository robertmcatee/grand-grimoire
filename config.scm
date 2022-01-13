(use-modules (gnu))
(use-service-modules desktop networking ssh xorg)
;; Import nonfree linux module - as needed
;;(use-modules (nongnu packages linux)
;;             (nongnu system linux-initrd))

(operating-system
;; Import non free linux - as needed
;;  (kernel linux)
;;  (initrd microcode-initrd)
;;  (firmware (list linux-firmware)) 
  (locale "en_US.utf8")
  (timezone "America/Chicago")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "xochimilco")
  (users (cons* (user-account
                  (name "cenzontle")
                  (comment "Cenzontle")
                  (group "users")
                  (home-directory "/home/cenzontle")
                  (supplementary-groups
                    '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))
  (packages
    (append
      (list (specification->package "nss-certs"))
      %base-packages))

  (services  
    (append
      (list (service gnome-desktop-service-type)
            (set-xorg-configuration (xorg-configuration (keyboard-layout keyboard-layout))))
      (modify-services %desktop-services
        (guix-service-type config => (guix-configuration
          (inherit config)
            (substitute-urls
              (append (list "https://substitutes.nonguix.org") %default-substitute-urls))
            (authorized-keys
              (append (list (local-file "./signing-key.pub")) %default-authorized-guix-keys)))))))
;; 1. download signing-key.pub directly from https://substitutes.nonguix.org/signing-key.pub and place in /etc/ folder
;; 2. perform guix pull
;; 3. sudo guix archive --authorize < signing-key.pub
;; 4. sudo guix system reconfigure /etc/config.scm --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
 
 (bootloader
    (bootloader-configuration
      (bootloader grub-bootloader)
      (target "/dev/sda")
      (keyboard-layout keyboard-layout)))
  (mapped-devices
    (list (mapped-device
            (source
              (uuid "0b1883a0-7c70-42fc-823e-0f7615dd26ea"))
            (target "cryptroot")
            (type luks-device-mapping))))
  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4")
             (dependencies mapped-devices))
           %base-file-systems)))
