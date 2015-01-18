;; fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; colors
(set-background-color "gray90")
(set-foreground-color "black")

(global-hl-line-mode t)

(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Monospace-10"))

(set-face-background 'hl-line "gray83")

;; Turn off the menu bar at the top of each frame
(menu-bar-mode -1)

;; Turn off the tool bar
(tool-bar-mode -1)

(scroll-bar-mode -1)

(custom-set-faces
 ;;'(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(mode-line ((t (:foreground "#333" :background "#c0dcc0" :box nil))))
 )

;; lines and rows number show
(require 'linum)
(linum-mode 1)
(global-linum-mode)
(column-number-mode 1)

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; These settings relate to how emacs interacts with your operating system
(setq ;; makes killing/yanking interact with the clipboard
 x-select-enable-clipboard t
 ;; I'm actually not sure what this does but it's recommended?
 x-select-enable-primary t
 ;; Save clipboard strings into kill ring before replacing them.
 ;; When one selects something in another program to paste it into Emacs,
 ;; but kills something in Emacs before actually pasting it,
 ;; this selection is gone unless this variable is non-nil
 save-interprogram-paste-before-kill t
 ;; Shows all options when running apropos. For more info,
 ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Apropos.html
 apropos-do-all t
 ;; Mouse yank commands yank at point instead of at click.
 mouse-yank-at-point t)

;; region deleted by del
(delete-selection-mode 1)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)
;; full path in title bar
(setq-default frame-title-format "%b (%f)")
;; don't pop up font menu
(global-set-key (kbd "s-t") '(lambda () (interactive)))
;; no bell
(setq ring-bell-function 'ignore)
