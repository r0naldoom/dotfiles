;; Evil Mode - Vim keybindings for Emacs

(use-package evil
  :ensure t
  :demand t  ;; Força carregamento imediato
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  ;; Set initial state for some modes
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

;; Evil Collection - Vim bindings for many modes
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

;; Evil Commentary - gcc to comment lines (like vim-commentary)
(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))

;; Evil Surround - cs, ds, ys for surrounding text (like vim-surround)
(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

;; Evil Matchit - % para pular entre tags/parênteses
(use-package evil-matchit
  :ensure t
  :after evil
  :config
  (global-evil-matchit-mode 1))

;; Undo Tree - visualizar histórico de undo
(use-package undo-tree
  :ensure t
  :after evil
  :config
  (global-undo-tree-mode 1)
  (evil-set-undo-system 'undo-tree)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo-tree")))
  (setq undo-tree-auto-save-history t))

;; ============================================================
;; NAVEGAÇÃO VIM-STYLE (] e [)
;; ============================================================

(with-eval-after-load 'evil
  ;; ] b / [ b - next/prev buffer
  (evil-define-key 'normal 'global (kbd "] b") 'next-buffer)
  (evil-define-key 'normal 'global (kbd "[ b") 'previous-buffer)

  ;; ] d / [ d - next/prev error (flycheck)
  (evil-define-key 'normal 'global (kbd "] d") 'flycheck-next-error)
  (evil-define-key 'normal 'global (kbd "[ d") 'flycheck-previous-error)

  ;; ] c / [ c - next/prev git hunk (diff-hl)
  (evil-define-key 'normal 'global (kbd "] c") 'diff-hl-next-hunk)
  (evil-define-key 'normal 'global (kbd "[ c") 'diff-hl-previous-hunk)

  ;; ] t / [ t - next/prev tab
  (evil-define-key 'normal 'global (kbd "] t") 'centaur-tabs-forward)
  (evil-define-key 'normal 'global (kbd "[ t") 'centaur-tabs-backward)

  ;; K - hover docs (eldoc)
  (evil-define-key 'normal 'global (kbd "K") 'eldoc-doc-buffer)

  ;; gd - go to definition (já vem do evil-collection, mas garantir)
  (evil-define-key 'normal 'global (kbd "g d") 'xref-find-definitions)
  (evil-define-key 'normal 'global (kbd "g r") 'xref-find-references))

(provide 'evil-config)
