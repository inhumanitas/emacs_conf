;; dired
(require 'init-dired)
(define-key ctl-x-map   "d" 'diredp-dired-files)
(define-key ctl-x-4-map "d" 'diredp-dired-files-other-window)
(dired-details-show)
