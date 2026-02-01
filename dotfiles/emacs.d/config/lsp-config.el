(use-package mason
  :ensure t
  :config
  (mason-setup))

(mason-setup
  (dolist (pkg '("zuban" "ruff" "marksman" "ltex-ls-plus" "typos-lsp"))
    (unless (mason-installed-p pkg)
      (ignore-errors (mason-install pkg)))))

(defconst my/typos-modes
  '(bash-mode bash-ts-mode
    yaml-mode yaml-ts-mode
    dockerfile-mode dockerfile-ts-mode
    json-mode json-ts-mode
    toml-mode toml-ts-mode
    conf-mode ini-mode))

(use-package eglot
  :ensure t
  :defer t
  :hook ((python-ts-mode . eglot-ensure)
	 (markdown-mode . eglot-ensure)
         (python-ts-mode . (lambda () (set-fill-column 79))))

  :config
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("rass" "python")))
  (add-to-list 'eglot-server-programs
               '((markdown-mode) . ("rass" "markdown")))

  ; only typos
  (add-to-list 'eglot-server-programs
               (cons my/typos-modes '("typos-lsp")))

  (setq-default
   eglot-workspace-configuration
   '(
     :ltex
     (:language "pt-BR" ;["pt-BR" "en-US"]
      :additionalRules (:enablePickyRules t
			:motherTongue "pt-BR")
      :disabledRules (:pt-BR ["PT_SMART_QUOTES" "ELLIPSIS"])
      :completionEnabled t))))

; add 'typos-modes' in eglot-ensure
(dolist (mode my/typos-modes)
  (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))


(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(provide 'lsp-config)
