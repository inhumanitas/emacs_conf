;; ido
(require 'ido)
(setq ido-save-directory-list-file (concat (getenv "HOME") "/.emacs.d/ido/ido.last"))
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'ido-hacks)
