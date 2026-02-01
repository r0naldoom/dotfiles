;; markdown config
(use-package markdown-mode
  :ensure t
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(custom-set-faces
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.8 :foreground "#A3BE8C" :weight extra-bold))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4 :foreground "#EBCB8B" :weight extra-bold))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.2 :foreground "#D08770" :weight extra-bold))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.15 :foreground "#BF616A" :weight extra-bold))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.11 :foreground "#b48ead" :weight extra-bold))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.06 :foreground "#5e81ac" :weight extra-bold)))))

;; org config
(use-package org
  :ensure t
  :hook ((org-mode . org-indent-mode)  ; Indentação visual (mais limpo)
         (org-mode . (lambda ()
                       ;; Habilita company completion em org-mode
                       (setq-local company-backends
                                   '((company-dabbrev company-yasnippet company-files)))
                       (add-hook 'completion-at-point-functions
                                 'pcomplete-completions-at-point nil t))))
  :config
  ;; TODO keywords - use C-c C-t para mudar estado
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

  ;; Cores para cada estado
  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "#fb4934" :weight bold))
          ("WAITING" . (:foreground "#fabd2f" :weight bold))
          ("DONE" . (:foreground "#b8bb26" :weight bold))
          ("CANCELED" . (:foreground "#928374" :weight bold))))

  ;; Links abrem no mesmo buffer
  (setq org-return-follows-link t)

  ;; Log quando tarefa é concluída
  (setq org-log-done 'time)

  ;; Atalho rápido para TODO
  (setq org-use-fast-todo-selection 'expert))

;; Org-modern - visual moderno para org-mode
(use-package org-modern
  :ensure t
  :after org
  :custom
  ;; Esconde marcadores de formatação (*bold*, /italic/, etc)
  (org-hide-emphasis-markers t)
  ;; Mostra entidades como símbolos (ex: \alpha -> α)
  (org-pretty-entities t)
  ;; Elipsis mais limpo quando fold
  (org-ellipsis " ▾")
  ;; Tags não ficam alinhadas longe
  (org-auto-align-tags nil)
  (org-tags-column 0)
  ;; Edição mais inteligente
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)
  ;; Estilo dos asteriscos/bullets
  (org-modern-star '("◉" "○" "●" "○" "●" "○" "●"))
  ;; Checkboxes bonitos
  (org-modern-checkbox '((?X . "☑") (?- . "◐") (?\s . "☐")))
  ;; TODO keywords com badges
  (org-modern-todo t)
  ;; Prioridades com badges
  (org-modern-priority t)
  ;; Tabelas mais limpas
  (org-modern-table t)
  :config
  ;; Ativa globalmente em todos os buffers org
  (global-org-modern-mode))

;; Olivetti - modo escrita focada (centraliza texto)
(use-package olivetti
  :ensure t
  :hook ((org-mode . olivetti-mode)
         (markdown-mode . olivetti-mode))
  :custom
  ;; Largura do texto (em caracteres) - maior = menos margem
  (olivetti-body-width 120)
  ;; Estilo visual
  (olivetti-style 'fancy))

;; Org-roam - segundo cérebro / Zettelkasten
(use-package org-roam
  :ensure t
  :after org
  :custom
  ;; Diretório das notas
  (org-roam-directory (file-truename "~/Notes"))
  ;; Template para novas notas
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+date: %<%Y-%m-%d>\n")
      :unnarrowed t)))
  :config
  ;; Cria o diretório se não existir
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory t))
  ;; Sincroniza o banco de dados
  (org-roam-db-autosync-mode))

;; Org-roam-ui - grafo visual das notas (abre no browser)
(use-package org-roam-ui
  :ensure t
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)      ; Sincroniza tema com Emacs
  (org-roam-ui-follow t)          ; Segue a nota atual
  (org-roam-ui-update-on-save t)  ; Atualiza ao salvar
  (org-roam-ui-open-on-start nil)); Não abre automaticamente

(provide 'write-config)
