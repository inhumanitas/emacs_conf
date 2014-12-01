(require 'python)
(require 'python-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Show leading and trailing whitespaces in some modes.
(mapc (lambda (hook)
        (add-hook hook (lambda ()
                         (setq show-trailing-whitespace t))))
      '(text-mode-hook
        emacs-lisp-mode-hook
        python-mode-hook
        js2-mode-hook
        css-mode-hook
        ))

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; Enable Python mode for imenu:

(defvar py-mode-map python-mode-map)
(add-hook 'python-mode-hook
  (lambda ()
    (setq imenu-create-index-function 'python-imenu-create-index)))

(require 'anything)
(when (require 'anything-show-completion nil t)
     (use-anything-show-completion 'anything-ipython-complete
                                   '(length initial-pattern)))


(defun annotate-pdb ()
  (interactive)
  (highlight-regexp "import ipdb")
  (highlight-regexp "import pdb")
  (highlight-regexp "ipdb.set_trace()")
  (highlight-regexp "pdb.set_trace()")
)

(add-hook 'python-mode-hook 'annotate-pdb)
(defun python-add-breakpoint ()
  (interactive)
  (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()")
)

(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)
(setq py-shell-name "ipython")
;; Load pylint and flake8 addition:

(require 'python-pylint)
(require 'python-flake8)

(require 'flymake)
(setq flymake-no-changes-timeout 3)

(when (load "flymake" t)
  (load "flymake-cursor")
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ;; uncomment either flake8 oder pyflakes
      ;; (list "flake8" (list local-file))
      (list "pyflakes" (list local-file))
      ))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py$" flymake-pyflakes-init)))

(add-hook 'python-mode-hook
          (lambda ()
           ; Activate flymake unless buffer is a tmp buffer for the interpreter
            (if (not (eq buffer-file-name nil))
                (progn
                  (flymake-mode t)
                  (local-set-key (kbd "M-n") 'flymake-goto-next-error)
                  (local-set-key (kbd "M-p") 'flymake-goto-prev-error)))))


;; Complexity

;; pycomplexity adds green, yellow or red markes left beside a function to visualize it's complexity in Python mode.
;;(setq aa-vendor-dir (expand-file-name "web_bb" "/home/valiullin/work/"))
;;(add-to-list 'load-path (expand-file-name "pycomplexity" aa-vendor-dir))
;;(require 'linum)
;;(require 'pycomplexity)
;;(setq pycomplexity-python "python")
;;(add-hook 'python-mode-hook
;;          (function (lambda ()
;;                      (pycomplexity-mode)
;;                      (linum-mode))))

;; Django

;; For Django pony-mode does all the magic. pony-mode is available on MELPA.

;;(require 'pony-mode)

;; However, there's an annoying issue when editing templates. As long as it isn't fixed we add an workaround:

;;(defun pony-indent ()
;;  "Indent current line as Jinja code"
;;  (interactive)
;;  (beginning-of-line)
;;  (let ((indent (pony-calculate-indent)))
;;    (if (< indent 0)
;;        (setq indent 0))
;;    (indent-line-to indent)))
