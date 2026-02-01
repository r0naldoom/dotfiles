;; Keybindings compatíveis com evil-mode

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Company - navegação com arrows e enter
(with-eval-after-load 'company
  (define-key company-active-map (kbd "<up>") 'company-select-previous)
  (define-key company-active-map (kbd "<down>") 'company-select-next)
  (define-key company-active-map (kbd "RET") 'company-complete-selection)
  (define-key company-active-map (kbd "<return>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<escape>") 'company-abort))

(use-package move-text
  :ensure t)

;; Leader key com SPC (estilo Spacemacs/Doom)
(use-package general
  :ensure t
  :config
  (general-evil-setup)

  ;; SPC como leader key em normal/visual mode
  (general-create-definer my-leader-def
    :keymaps '(normal visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (my-leader-def
    ;; Find/Search (estilo snacks picker)
    "f"  '(:ignore t :which-key "find")
    "ff" '(counsel-find-file :which-key "find file")
    "fg" '(counsel-git-grep :which-key "grep git")
    "fr" '(counsel-recentf :which-key "recent files")
    "fb" '(ivy-switch-buffer :which-key "buffers")
    "fs" '(swiper :which-key "search in buffer")
    "fh" '(counsel-command-history :which-key "command history")
    "fp" '(projectile-find-file :which-key "find in project")

    ;; Save
    "s"  '(:ignore t :which-key "save")
    "ss" '(save-buffer :which-key "save")

    ;; Buffers
    "b"  '(:ignore t :which-key "buffers")
    "bb" '(switch-to-buffer :which-key "switch buffer")
    "bk" '(kill-buffer :which-key "kill buffer")
    "bn" '(next-buffer :which-key "next buffer")
    "bp" '(previous-buffer :which-key "prev buffer")

    ;; Windows
    "w"  '(:ignore t :which-key "windows")
    "wv" '(split-window-right :which-key "split vertical")
    "ws" '(split-window-below :which-key "split horizontal")
    "wc" '(delete-window :which-key "close window")
    "wo" '(delete-other-windows :which-key "close others")
    "ww" '(other-window :which-key "other window")

    ;; Project (projectile)
    "p"  '(:ignore t :which-key "project")
    "pp" '(projectile-switch-project :which-key "switch project")
    "pf" '(projectile-find-file :which-key "find file in project")
    "pg" '(projectile-grep :which-key "grep in project")

    ;; Git
    "g"  '(:ignore t :which-key "git")
    "gg" '(magit-status :which-key "magit status")
    "gb" '(magit-blame :which-key "blame")

    ;; Code/LSP
    "c"  '(:ignore t :which-key "code")
    "ce" '(flycheck-list-errors :which-key "errors")
    "cr" '(eglot-rename :which-key "rename")
    "ca" '(eglot-code-actions :which-key "code actions")
    "cd" '(xref-find-definitions :which-key "go to definition")

    ;; Toggle
    "t"  '(:ignore t :which-key "toggle")
    "tt" '(neotree-toggle :which-key "neotree")
    "tn" '(display-line-numbers-mode :which-key "line numbers")
    "to" '(olivetti-mode :which-key "olivetti (focus)")

    ;; Quit
    "q"  '(:ignore t :which-key "quit")
    "qq" '(evil-quit :which-key "quit")
    "qw" '(evil-save-and-quit :which-key "save and quit")
    "qa" '(evil-quit-all :which-key "quit all")
    "qQ" '(save-buffers-kill-terminal :which-key "quit emacs")

    ;; Eval
    "e"  '(:ignore t :which-key "eval")
    "ee" '(eval-buffer :which-key "eval buffer")
    "er" '(eval-region :which-key "eval region")

    ;; Undo
    "u"  '(undo-tree-visualize :which-key "undo tree")

    ;; LSP extras
    "l"  '(:ignore t :which-key "lsp")
    "lf" '(eglot-format-buffer :which-key "format buffer")
    "lr" '(eglot-rename :which-key "rename")
    "la" '(eglot-code-actions :which-key "code actions")
    "ld" '(xref-find-definitions :which-key "definition")
    "lR" '(xref-find-references :which-key "references")

    ;; Org-mode
    "o"  '(:ignore t :which-key "org")
    "oo" '(org-toggle-checkbox :which-key "toggle checkbox")
    "oa" '(org-agenda :which-key "agenda")
    "oc" '(org-capture :which-key "capture")
    "ol" '(org-store-link :which-key "store link")
    "ot" '(org-todo :which-key "todo state")
    "os" '(org-schedule :which-key "schedule")
    "od" '(org-deadline :which-key "deadline")
    "oi" '(org-insert-link :which-key "insert link")
    "op" '(org-priority :which-key "priority")
    "oq" '(org-set-tags-command :which-key "tags")
    "oe" '(org-export-dispatch :which-key "export")

    ;; Org-roam (notas)
    "n"  '(:ignore t :which-key "notes")
    "nf" '(org-roam-node-find :which-key "find note")
    "ni" '(org-roam-node-insert :which-key "insert link")
    "nn" '(org-roam-capture :which-key "new note")
    "nb" '(org-roam-buffer-toggle :which-key "backlinks")
    "ng" '(org-roam-ui-mode :which-key "graph (browser)")
    "nd" '(:ignore t :which-key "dailies")
    "ndt" '(org-roam-dailies-goto-today :which-key "today")
    "ndd" '(org-roam-dailies-goto-date :which-key "go to date")
    "ndn" '(org-roam-dailies-goto-next-note :which-key "next")
    "ndp" '(org-roam-dailies-goto-previous-note :which-key "previous")))

;; Zoom in/out (funciona em qualquer mode)
(global-set-key (kbd "C-+")
                (lambda ()
                  (interactive)
                  (let ((old-face-attribute (face-attribute 'default :height)))
                    (set-face-attribute 'default nil :height (+ old-face-attribute 5)))))

(global-set-key (kbd "C--")
                (lambda ()
                  (interactive)
                  (let ((old-face-attribute (face-attribute 'default :height)))
                    (set-face-attribute 'default nil :height (- old-face-attribute 5)))))

(provide 'keys)
