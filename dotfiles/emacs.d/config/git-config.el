(require 'package)

(use-package with-editor
  :ensure t)

(use-package magit
  :ensure t)

;; Show diff inline
(use-package diff-hl
  :ensure t)

(provide 'git-config)
