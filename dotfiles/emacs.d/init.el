;; Config mínima com lsp-mode (alternativa ao eglot)

;; MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Básico
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; lsp-mode
(use-package lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-idle-delay 0.5)
  (lsp-log-io nil)  ;; Desabilita logging
  :config
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("ruff" "server"))
    :major-modes '(python-mode python-ts-mode)
    :server-id 'ruff)))

;; Adiciona mason bin ao PATH
(add-to-list 'exec-path (expand-file-name "~/.emacs.d.bak.20260128/mason/bin"))
(setenv "PATH" (concat (expand-file-name "~/.emacs.d.bak.20260128/mason/bin") ":" (getenv "PATH")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
