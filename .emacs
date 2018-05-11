;;; .emacs --- Emacs initialization file -*- lexical-binding: t; -*-
(package-initialize)
(require 'google)
(require 'google-trailing-whitespace)
(require 'google-imports)
(require 'rotate-among-files)
(require 'google-ycmd)
(require 'google3-build)
(require 'google3-build-cleaner)
(setq google-build-system "blaze")
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(require 'google-cc-extras)
(google-cc-extras/bind-default-keys)
;; blaze
(require 'google3-build)
(setq google-build-system "blaze")
(use-package google3-build
  :init
  (setq google3-build-default-extra-arguments
        "--test_output=streamed --nocache_test_results"))

;; Custom packages in load path
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'fill-column-indicator)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (autocutsel clipmon xclip string-inflection multiple-cursors solarized-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "black"))))
 '(company-tooltip-selection ((t (:background "white"))))
 '(font-lock-comment-face ((t (:foreground "yellow")))))

;; Miscellany
(put 'downcase-region 'disabled nil)
(setq column-number-mode t)

;; x copy paste
(require 'xclip)
(xclip-mode 1)

(defun copy-to-x-clipboard ()
  (interactive)
  (if (region-active-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "xsel -ib")
        (message "Yanked region to clipboard!")
        (deactivate-mark))
    (message "No region active; can't yank to clipboard!")))
(global-set-key [f8] 'copy-to-x-clipboard)

;; Show matching parens.
(setq show-paren-delay 0)
(show-paren-mode 1)

;; fill-column-indicator
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
(setq fill-column 80)

(defvar-local company-fci-mode-on-p nil)

;  disable fci on company tooltip
(defun company-turn-off-fci (&rest ignore)
  (when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))

(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))

(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)

;; hooks
(add-hook 'java-mode-hook (lambda ()
                            (setq-local fill-column 100)
                            (turn-off-fci-mode)))
(add-hook 'compilation-mode-hook
          (lambda ()
            (turn-off-fci-mode)
            (setq-local truncate-lines nil)))

(define-globalized-minor-mode global-fci-mode fci-mode
  (lambda () (turn-on-fci-mode) (setq-local fill-column 80)))


;; Backups into a separate directory
(add-to-list 'backup-directory-alist '("." . "~/.saves") :append)
(setq backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; multiple-cursors
(require 'multiple-cursors)

(defun my-previous-window ()
  "Previous window"
  (interactive)
  (other-window -1))

;; key bindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    ; google
    (define-key map (kbd "C-c C-b") 'google3-build)
    (define-key map (kbd "C-c b") 'google3-build-cleaner)
    (define-key map (kbd "C-c C-t") 'google3-test)
    (define-key map (kbd "C-c C-y") 'google3-run)
    (define-key map (kbd "C-c C-r") 'google3-run-test-at-point)
    (define-key map (kbd "C-c C-a") 'google3-build-cleaner)
    (define-key map (kbd "C-c C-p") 'google-piper-browse)
    (define-key map (kbd "C-M-h") 'google-rotate-among-files)
    ; multiple-cursors
    (define-key map (kbd "C-c m") 'mc/edit-lines)
    (define-key map (kbd "M-.") 'mc/mark-next-like-this-word)
    (define-key map (kbd "M-,") 'mc/mark-previous-like-this-word)
    (define-key map (kbd "M-;") 'mc/mark-all-like-this)
    ; string-inflection
    (define-key map (kbd "C-c i") 'string-inflection-all-cycle)
    ; windows
    (define-key map (kbd "C-x p") 'my-previous-window)
    (define-key map (kbd "C-x n") 'other-window)
    ; misc
    (define-key map (kbd "M-;") 'comment-dwim)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)
(put 'upcase-region 'disabled nil)
