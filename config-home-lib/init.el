;; load emacs 24+ package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
    (package-initialize)
    (add-to-list 'package-archives 
                 '("melpa" . "https://melpa.org/packages/") t))

;; Bootstrap use-package, from example provided by Richard Thames
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)
(require 'bind-key)

;; Misc Packages
(use-package undo-tree 
  :bind
    ("C-x u" . undo-tree-visualize)
  :config
    (global-undo-tree-mode))
(use-package magit
  :bind
    ("C-x g" . magit-status))
(use-package ox-haunt)

;; Look and Feel
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-set-key [f11] 'toggle-menu-bar-mode-from-frame)
(global-display-line-numbers-mode)
(setq inhibit-startup-message '(t))
(custom-set-faces
 '(default ((t (:family "Liberation Mono"
			:foundry "outline"
			:slant normal
			:weight normal
			:height 100
			:width normal)))))
(use-package solarized-theme)
(setq solarized-use-variable-pitch nil)
(setq solarized-height-minus-1 1.0)
(setq solarized-height-plus-1 1.0)
(setq solarized-height-plus-2 1.0)
(setq solarized-height-plus-3 1.0)
(setq solarized-height-plus-4 1.0)
(load-theme 'solarized-light t)

;; Tab Bar
(use-package tabbar)
(require 'tabbar)
(customize-set-variable 'tabbar-separator '(0.5))
(customize-set-variable 'tabbar-use-images nil)
(tabbar-mode 1)
(setq tabbar-buffer-groups-function
      (lambda ()
        (list "All")))
(define-key global-map [(alt j)] 'tabbar-backward)
(define-key global-map [(alt k)] 'tabbar-forward)
(set-face-attribute
 'tabbar-default nil
 :family "Liberation Mono"
 :box nil)
(set-face-attribute
 'tabbar-unselected nil
 :foreground "#839496"
 :box nil)
(set-face-attribute
 'tabbar-modified nil
 :foreground "#dc322f"
 :box nil
 :inherit 'tabbar-unselected)
(set-face-attribute
 'tabbar-selected nil
 :background "#eee8d5"
 :foreground "#2aa198"
 :box nil)
(set-face-attribute
 'tabbar-selected-modified nil
 :inherit 'tabbar-selected
 :foreground "#b58900"
 :box nil)
(set-face-attribute
 'tabbar-button nil
 :box nil)

;; orgmode
(setq initial-major-mode 'org-mode)
(setq org-startup-indented '(t))
(setq default-directory "/home/robertmcatee/Dropbox/org")
(setq initial-scratch-message "* TODO [#A] New Theme
** New Epic [0/1]
- [ ] New Task"
)

;; Backup Files
;; Move backup files to central location
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)

;; Babel and Geiser
(use-package geiser)
(use-package geiser-guile)
(org-babel-do-load-languages 'org-babel-load-languages '((scheme .t)(python .t)))
