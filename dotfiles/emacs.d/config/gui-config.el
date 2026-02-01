;; dead keys
(require 'iso-transl)

;; Remove menus
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq-default message-log-max nil)
(when (get-buffer "*Messages*")
  (kill-buffer "*Messages*"))

;; Show column indicator
(setopt display-fill-column-indicator-column 80)

;; window size
(add-to-list 'default-frame-alist '(height . 30))
(add-to-list 'default-frame-alist '(width . 100))

;; Transparência (Emacs 29+)
;; 100 = opaco, 0 = totalmente transparente
(set-frame-parameter nil 'alpha-background 75)
(add-to-list 'default-frame-alist '(alpha-background . 75))

;; Funções para ajustar transparência interativamente
(defun my/increase-transparency ()
  "Aumenta transparência."
  (interactive)
  (let ((alpha (or (frame-parameter nil 'alpha-background) 100)))
    (set-frame-parameter nil 'alpha-background (max 10 (- alpha 5)))))

(defun my/decrease-transparency ()
  "Diminui transparência (mais opaco)."
  (interactive)
  (let ((alpha (or (frame-parameter nil 'alpha-background) 100)))
    (set-frame-parameter nil 'alpha-background (min 100 (+ alpha 5)))))

;; modes
;; ido-mode desabilitado - usando ivy
;; (ido-mode 1)
;; cua-mode disabled - using evil-mode instead
;; display-time desabilitado (performance)
;; (display-time-mode 1)

;; Font - ajuste conforme sua preferencia
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 140)

;; flex buffer
(defalias 'list-buffers 'ibuffer-other-window)

;; Remove welcome message
(setq inhibit-startup-message t
      initial-buffer-choice  nil
      initial-scratch-message nil
      use-dialog-box nil
      auto-save-default nil
      make-backup-files nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; Update changed buffers
(global-auto-revert-mode t)

(use-package all-the-icons
  :ensure t
  :defer t)                               ; Carrega lazy

;; ef-themes (by Protesilaos)
(use-package ef-themes
  :ensure t
  :config
  (load-theme 'ef-melissa-dark t))

(use-package spaceline
  :ensure t)

(use-package spaceline-config
  :config
  (spaceline-emacs-theme))

;; Side tree
(use-package neotree
  :ensure t
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)
        neo-autorefresh nil)              ; Desabilitado por performance
  :bind ("C-\\" . 'neotree-toggle))

;; Buffer tabs
(global-unset-key (kbd "C-x <prior>"))
(global-unset-key (kbd "C-x <next>"))

(use-package centaur-tabs
  :ensure t
  :defer t                                ; Carrega lazy
  :commands (centaur-tabs-mode centaur-tabs-backward centaur-tabs-forward)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-set-bar 'over
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "*"
        centaur-tabs-set-icons nil        ; Icons desabilitados (performance)
        centaur-tabs-height 28)
  (centaur-tabs-headline-match)
  :bind
  ("C-x <prior>" . centaur-tabs-backward)
  ("C-x <next>" . centaur-tabs-forward)
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  ;; Ativa só depois de carregar
  (after-init . centaur-tabs-mode))

;; Emojify desabilitado - pesado demais
;; (use-package emojify
;;   :ensure t
;;   :hook (after-init . global-emojify-mode))

(provide 'gui-config)
