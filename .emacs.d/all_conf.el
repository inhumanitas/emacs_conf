;; fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; colors
(set-background-color "gray90")
(set-foreground-color "black")
(global-hl-line-mode t)
(set-face-background 'hl-line "gray83")

(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Monospace-10"))

;; tool bar
(tool-bar-mode -1)

;; menu bar
(menu-bar-mode -1)

(desktop-save-mode 1)

;;Save minibuffer history
(savehist-mode 1)

;; yes = y
(fset 'yes-or-no-p 'y-or-n-p)

;;activate show paren
(show-paren-mode t)
(setq show-paren-style 'expression)

;; lines and rows number show
(require 'linum)
(linum-mode 1)
(global-linum-mode)
(column-number-mode 1)

;; region deleted by del
(delete-selection-mode 1)

;; tab
(setq default-tab-width 4)
(setq x-select-enable-clipboard t)

;; show line limit
(load (expand-file-name "~/.emacs.d/column-marker.el"))
(require 'column-marker)

(add-hook 'javascript-mode-hook (lambda () (interactive) (column-marker-3 79)))
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-3 79)))


;; after save events

;;; убивать пробелы в конце строк
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;; замена табов пробелами
(add-hook 'before-save-hook '(lambda () (untabify (point-min) (point-max))))


;; language bindings
(setq auto-mode-alist
      (append
       '(
         ( "\\.el$". lisp-mode)
         ( "\\.js$". js-mode)
         ( "\\.emacs". emacs-lisp-mode)
         ( "\\.conf$". conf-mode)
         ( "\\.cpp$". c++-mode)
         ( "\\.py$". python-mode)
         ( "\\.rb$". ruby-mode)
         ( "\\.php$". php-mode)
         ( "\\.conf$". conf-mode)
         ( "\\.cnf$". conf-mode)
         ( "\\.emacs". emacs-lisp-mode)
         ( "\\.js$". espresso-mode)
         ( "\\.xml$". nxml-mode)
         ( "\\.html$". html-mode)
         ( "\\.css$". css-mode)
         ( "\\.prg$". xbase-mode)
         ( "\\.scn$". xbase-mode)
         ( "\\.mac$". xbase-mode)
         ( "\\.f2r$". xbase-mode)
         ( "\\.erl$". erlang-mode)
        )
    )
)

;; global shortcut
(global-set-key [?\C-,] 'previous-buffer)
(global-set-key [?\C-.] 'next-buffer)
(global-set-key [?\C-'] 'toggle-truncate-lines)
(global-set-key [?\C-:] 'kill-this-buffer)
(global-set-key [?\C-ж] 'kill-this-buffer)

(global-set-key [f8] 'linum-mode)
(global-set-key [f11] 'ibuffer)
(global-set-key [f10] 'bookmark-bmenu-list)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; eng => ru
(load (expand-file-name "~/.emacs.d/eik.el"))
(global-set-key [f9] 'eik/tr)
