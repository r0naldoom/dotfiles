;; Project organization
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)
  (setq projectile-project-search-path '("~/git/" "~/projects/")
        projectile-switch-project-action 'neotree-projectile-action
        projectile-indexing-method 'alien
        projectile-use-git-grep 1))

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-items '((recents . 5)
                          (projects . 5)
                          (bookmarks . 5)
                          (agenda . 5))
        dashboard-banner-logo-title "Welcome to Emacs!"
        dashboard-startup-banner 'logo
        dashboard-set-file-icons t
        dashboard-icon-type 'all-the-icons
        dashboard-projects-backend 'projectile
        dashboard-set-init-info nil
        dashboard-center-content t)

  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-item-names '(("Recent Files:" . "Arquivos recentes:")
                               ("Projects:" . "Projetos")
                               ("Agenda for the coming week:" . "Agenda:"))))

;; recentf exclusions
(add-to-list 'recentf-exclude
             (recentf-expand-file-name "~/.elfeed/*"))
(add-to-list 'recentf-exclude
             (recentf-expand-file-name "~/.emacs.d/*"))

(provide 'dashboard-config)
