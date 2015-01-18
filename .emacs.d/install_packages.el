;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar packages-for-install
  '(;; Multiple cursors for Emacs.
    multiple-cursors
    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/better-defaults.el line 47 for a description
    ;; of ido
    ido-ubiquitous
    ido-hacks
    ;;
    column-marker
    ;; Dired
    dired-details
    dired+
    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex
    ;; project navigation
    projectile
    ;; git integration
    magit
    yaml-mode
    company
    ;; Jabber support
    jabber
    ;; Notification support
    notify
    ))

(dolist (package packages-for-install)
  (when (not (package-installed-p package))
    (package-install package)))
