;; Disable menu bar
(menu-bar-mode -1)

;; Emacs UI only customizations
(when (display-graphic-p)
  (tool-bar-mode -1)
  (set-fontset-font t nil "Apple Color Emoji")
  (blink-cursor-mode 0))

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Disable backup
(setq backup-inhibited t)

;; auto close bracket insertion.
(electric-pair-mode 1)

;; Start maximized
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-frame-parameter (selected-frame) 'alpha '(92 92))
(add-to-list 'default-frame-alist '(alpha 92 92))

;; Key bindings OSX
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq ns-alternate-modifier nil)

(global-set-key (kbd "M-<right>") 'move-end-of-line)
(global-set-key (kbd "M-<left>") 'move-beginning-of-line)
(global-set-key (kbd "M-<up>") 'beginning-of-buffer)
(global-set-key (kbd "M-<down>") 'end-of-buffer)
(global-set-key (kbd "C-z") 'undo)

;; Increase font just a tad
(set-face-attribute 'default nil :height 134)

;; Disable auto save
(setq auto-save-default nil)

;; Disable bell
(setq ring-bell-function 'ignore)

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;; Add repos
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

;; Download the ELPA archive description if needed.
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; integration with a Clojure REPL    ;; https://github.com/clojure-emacs/cider
    cider

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; auto-complete for cider
    ac-cider

    ;; flycheck
    flycheck

    ;; clojure syntax checker
    flycheck-clojure

    ;; flycheck status emoji
    flycheck-status-emoji

    ;; jenkins client for emacs
    jenkins

    ;; colorful parenthesis matching
    rainbow-delimiters))

;; Install packages if not already there
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Enhances M-x to allow easier execution of commands. Provides
;; a filterable list of possible commands in the minibuffer
;; http://www.emacswiki.org/emacs/Smex
(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;Enable autocomplete globally
(require 'auto-complete)
(global-auto-complete-mode t)

;; Setting up ac-cider
(require 'ac-cider)
(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
                 '(progn
                    ;; disable ac-quick-help
                    (defun ac-quick-help nil)
                    (add-to-list 'ac-modes 'cider-mode)
                    (add-to-list 'ac-modes 'cider-repl-mode)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; Disable cider help banner
(setq cider-repl-display-help-banner nil)

;; Flycheck clojure setup
(eval-after-load 'flycheck '(flycheck-clojure-setup))
(eval-after-load 'flycheck '(flycheck-status-emoji-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
;;(flycheck-status-emoji-mode 1)

;; Load theme tomorrow-night
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'tomorrow-night t)

;;(setq frame-background-mode 'dark)
;;(load-theme 'solarized t)
;;(enable-theme 'solarized)

;; Function for swapping buffers
(defun swap-buffer ()
  (interactive)
  (cond ((one-window-p) (display-buffer (other-buffer)))
        ((let* ((buffer-a (current-buffer))
                (window-b (cadr (window-list)))
                (buffer-b (window-buffer window-b)))
           (set-window-buffer window-b buffer-a)
           (switch-to-buffer buffer-b)
           (other-window 1)))))

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;; Enable ido mode
(ido-mode t)

;; make cursor a bar
;;(setq-default cursor-type 'hbar)

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Jenkins setup
(setq jenkins-api-token "")
(setq jenkins-url "")
(setq jenkins-username "")

;;; Prolog mode
(setq auto-mode-alist
      (cons (cons "\\.pl" 'prolog-mode)
            auto-mode-alist))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(prolog-program-name
     (quote
       (((getenv "EPROLOG")
         (eval
           (getenv "EPROLOG")))
        (eclipse "eclipse")
        (mercury nil)
        (sicstus "sicstus")
        (swi "/usr/local/bin/swipl")
        (gnu "gprolog")
        (yap "yap")
        (xsb "xsb")
        (t "prolog"))))
  '(prolog-system (quote swi)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
