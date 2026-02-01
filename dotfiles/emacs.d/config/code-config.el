;; Text Folding
(use-package origami
  :ensure t
  :bind (:map origami-mode-map
              ("<backtab>" . origami-toggle-node)
              ("C-<iso-lefttab>" . origami-toggle-all-nodes)))

;; snippets from autocomplete
(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; Mapear python-ts-mode para usar snippets de python-mode
(with-eval-after-load 'yasnippet
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (add-hook 'python-ts-mode-hook
            (lambda () (yas-activate-extra-mode 'python-mode))))

;; company: autocomplete library
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.2              ; Delay para reduzir CPU
        company-minimum-prefix-length 2)    ; Começa com 2 chars
  (setq-default company-backends '((company-capf company-dabbrev-code company-keywords company-yasnippet)
                                   company-dabbrev
                                   company-files))
  (global-company-mode t)
  ;; Dabbrev para completar palavras em qualquer buffer
  (setq company-dabbrev-downcase nil        ; Não força minúsculas
        company-dabbrev-ignore-case t)      ; Ignora case na busca
  ;; Keywords do Python para autocomplete (estilo Vim)
  (require 'company-keywords)
  (add-to-list 'company-keywords-alist '(python-ts-mode . python-mode)))

;; Garantir backends com eglot
(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq-local company-backends
                          '((company-capf company-keywords company-yasnippet)
                            company-files)))))

;; Tree-sitter
(use-package tree-sitter-langs
  :ensure t)

(use-package treesit-auto
  :ensure t
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(provide 'code-config)
