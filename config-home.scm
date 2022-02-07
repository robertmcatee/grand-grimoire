(use-modules
 (gnu home)
 (gnu packages)
 (gnu services)
 (guix gexp)
 (gnu home services shells))

(home-environment
 (packages
  (map (compose list specification->package+output)
       (list "git" "syncthing-gtk" "haunt" "remmina" "emacs" "keepassxc" "clementine" "neofetch" "nmap" "guile" "glibc-locales" "nss-certs")))
       ;; glibc-locales must be installed using guix install glic-locales otherwise it won't work
 (services
  (list (service
	 home-bash-service-type
	 (home-bash-configuration
	  ;;(guix-defaults? #f)
	  (environment-variables '(("SSL_CERT_DIR" . "$HOME/.guix-home/profile/etc/ssl/certs")
				   ("SSL_CERT_FILE" . "$HOME/.guix-home/profile/etc/ssl/certs/ca-certificates.crt")
				   ("GIT_SSL_CAINFO" . "$SSL_CERT_FILE")
                                   ("GUIX_LOCPATH" . "$HOME/.guix-profile/lib/locale")))
				   ;;("PS1" . "'\\[\\e[1;31m\\][\\u@\\h \\W]\\[\\e[0m\\]\\$ '")))
	  (aliases '(("lsa" . "ls -la --color=auto")
		     ("emacs" . "TERM=xterm-direct emacs -nw")))
	  (bashrc
	   (list (local-file
		  "/home/robertmcatee/Documents/src/grand-grimoire/config-home-lib/.bashrc"
		  "bashrc")))
	  (bash-profile
	   (list (local-file
		  "/home/robertmcatee/Documents/src/grand-grimoire/config-home-lib/.bash_profile"
		  "bash_profile")))
	  (bash-logout
	   (list (local-file
		  "/home/robertmcatee/Documents/src/grand-grimoire/config-home-lib/.bash_logout"
		  "bash_logout"))))))))
