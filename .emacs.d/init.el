(desktop-save-mode 1)

;;Save minibuffer history
(savehist-mode 1)

;; yes = y
(fset 'yes-or-no-p 'y-or-n-p)

;;activate show paren
(show-paren-mode t)
(setq show-paren-style 'expression)

;; tab
(setq default-tab-width 4)

;; show line limit
(require 'column-marker)

(add-hook 'javascript-mode-hook (lambda () (interactive) (column-marker-3 79)))
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-3 79)))

;; No need for ~ files when editing
(setq create-lockfiles nil)

;;; убивать пробелы в конце строк
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;; замена табов пробелами
(add-hook 'before-save-hook '(lambda () (untabify (point-min) (point-max))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "/tmp/emacs/" t)
(add-to-list 'backup-directory-alist (cons ".*" "/tmp/emacs"))

;; comments
(defun toggle-comment-on-line ()
"comment or uncomment current line"
(interactive)
(comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)


;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

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
;; eng => ru
(global-set-key [f9] 'eik/tr)
(global-set-key [f10] 'bookmark-bmenu-list)
(global-set-key [f11] 'ibuffer)

(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; Interactive search key bindings. By default, C-s runs
;; isearch-forward, so this swaps the bindings.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
