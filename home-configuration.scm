(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (gnu home services shells))

(home-environment
  (packages
    (map (compose list specification->package+output)
         (list "neofetch" "emacs" "git")))
  (services
    (list (service
            home-bash-service-type
            (home-bash-configuration
              (aliases
                '(("grep='grep --color" . "auto")
                  ("ll" . "ls -l")
                  ("ls='ls -p --color" . "auto")))
              (bashrc
                (list (local-file
                        "/home/cenzontle/src/guix-config/.bashrc"
                        "bashrc")))
              (bash-profile
                (list (local-file
                        "/home/cenzontle/src/guix-config/.bash_profile"
                        "bash_profile"))))))))
