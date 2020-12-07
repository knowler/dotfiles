(server-start)
(setq user-full-name "Nathan Knowler"
      user-mail-address "nathan@knowler.me")

(setq make-backup-files nil
      auto-save-default nil
      inhibit-startup-message t
      blink-cursor-mode t
      ring-bell-function 'ignore)

(cond
  ((string-equal system-type "darwin")
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))))
(setq frame-title-format '(""))

;; Config
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-hl-line-mode t)
(line-number-mode t)

;;; Keybindings
(cond
 ((string-equal system-type "darwin")
  (setq mac-command-modifier 'meta)))

;; Set custom file
(setq custom-file "~/.emacs.d/custom-file.el")
(load-file custom-file)

;; Package set up
(require 'package)

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))
(unless (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Package config

(leaf iceberg-theme 
  :ensure t
  :config
  (iceberg-theme-create-theme-file)
  (load-theme 'solarized-iceberg-dark t))

(leaf neotree 
  :ensure t
  :bind
  ("C-;" . neotree-show)
  ("C-c C-;" . neotree-toggle))

(leaf lsp-mode 
  :ensure t 
  :commands (lsp lsp-deferred))

(leaf company 
  :ensure t
  ;;:bind (:map company-active-map
	;;      ("C-n" . company-select-next)
	;;      ("C-p" . company-select-prev))
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t))

(leaf company-lsp 
  :ensure t 
  :commands company-lsp)

(leaf magit 
  :ensure t 
  :bind ("C-x g" . magit-status))

(leaf elfeed
  :ensure t
  :config
  (global-set-key (kbd "C-x w") 'elfeed))

(leaf elfeed-org
    :after elfeed
    :ensure t
    :init
    (elfeed-org))

(leaf evil 
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (evil-mode))

(leaf evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(leaf wakatime-mode
  :ensure t
  :init
  (setq wakatime-cli-path "/usr/local/bin/wakatime")
  (global-wakatime-mode))

(set-frame-parameter (selected-frame) 'alpha '(90 88))
(add-to-list 'default-frame-alist '(alpha 90 88))
