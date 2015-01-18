;; jabber
(require 'jabber)
;;(require 'jabber-autoloads)

(defun jabber-visit-history (jid)
  "Visit jabber history with JID in a new buffer.
Performs well only for small files. Expect to wait a few seconds
for large histories. Adapted from `jabber-chat-create-buffer'."
  (interactive (list (jabber-read-jid-completing "JID: ")))
  (let ((buffer (generate-new-buffer (format "*-jabber-history-%s-*"
                                             (jabber-jid-displayname jid)))))
    (switch-to-buffer buffer)
    (make-local-variable 'jabber-chat-ewoc)
    (setq jabber-chat-ewoc (ewoc-create #'jabber-chat-pp))
    (mapc 'jabber-chat-insert-backlog-entry
          (nreverse (jabber-history-query nil nil t t "."
                                          (jabber-history-filename jid))))
    (view-mode)))

;; Prevent annoying \"Active processes exist\" query when you quit Emacs.
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (flet ((process-list ())) ad-do-it))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "/tmp/emacs/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "/tmp/emacs/"))))
 '(current-language-environment "UTF-8")
 '(inhibit-startup-screen t)
 '(jabber-account-list (quote (("valiullin@portal.bars-open.ru" (:network-server . "portal.bars-open.ru") (:connection-type . ssl) (:password . "pass_here")))))
;; '(jabber-alert-message-hooks (quote (jabber-message-libnotify jabber-message-echo jabber-message-scroll)))
 '(jabber-alert-presence-hooks nil)
 '(jabber-auto-reconnect t)
 '(jabber-autoaway-verbose t)
 '(jabber-backlog-days 30)
 '(jabber-backlog-number 40)
 '(jabber-default-status "emacs everywhere")
 '(jabber-display-menu t)
 '(jabber-history-enabled t)
 '(jabber-keepalive-interval 200)
 '(jabber-keepalive-timeout 20)
 '(jabber-use-global-history nil))

(defvar libnotify-program "/usr/bin/notify-send")
(defun notify-send (title message)
  (start-process "notify" " notify"
         libnotify-program "--expire-time=4000" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from)))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (notify-send (format "%s" (jabber-jid-displayname from))
             text)))

(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)

;; link appears nicely
(add-hook 'jabber-chat-mode-hook 'goto-address)

(jabber-roster-toggle-binding-display)
(jabber-roster-toggle-offline-display)

(global-set-key "\C-x\C-a" 'jabber-activity-switch-to)

;; '(jabber-default-show "")
;; '(jabber-version-show t)
;; '(jabber-silent-mode t)
'(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
(jabber-connect-all)
(jabber-mode-line-mode)
(setq jabber-mode-line-string (list " " 'jabber-mode-line-presence))


;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
    ;;'(jabber-title-medium ((t (:inherit variable-pitch :weight bold :height 2.0 :width condensed))))
    ;;'(jabber-title-small ((t (:inherit variable-pitch :weight bold :height 1.0 :width condensed))))
;;)
