;;; early-init.el --- Performance optimizations (baseado em emacs-solo) -*- lexical-binding: t; -*-

;;; -------------------- PERFORMANCE & HACKS

;; Delay garbage collection durante startup
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Restaura GC sensato depois do boot
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)  ; 100MB
                  gc-cons-percentage 0.1)))

;; Aumenta buffer de leitura (LSP performance)
(setq read-process-output-max (* 1024 1024 4))  ; 4MB

;; Apenas Git como VC backend (mais rápido)
(setq vc-handled-backends '(Git))

;; Não compila nativo na bateria
(when (boundp 'native-comp-async-on-battery-power)
  (setopt native-comp-async-on-battery-power nil))

;; Frame performance
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t)

;; Cache de fontes (evita recomputar)
(setq inhibit-compacting-font-caches t)

;; Desabilita UI antes de carregar (mais rápido)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

;; Sem splash
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Suprime warnings desnecessários
(setq warning-minimum-level :error)
(setq warning-suppress-types '((lexical-binding)))

;; Evita flash branco (ef-melissa-dark background)
(set-face-attribute 'default nil :background "#352718" :foreground "#e8e4b1")

(provide 'early-init)
;;; early-init.el ends here
