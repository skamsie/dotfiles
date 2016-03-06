;; Disable menu bar
(menu-bar-mode -1)

;; Highlights matching parenthesis
(show-paren-mode 1)

;; Disable backup
(setq backup-inhibited t)


;; Make emacs osx friendly
(setq mac-command-modifier 'super)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(global-set-key (kbd "s-<left>") 'move-beginning-of-line)
(global-set-key (kbd "C-z") 'undo)

;; Increase font just a tad
(set-face-attribute 'default nil :height 130)

;; Disable auto save
(setq auto-save-default nil)

;; Disable bell
(setq ring-bell-function 'ignore)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

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

;; Download the ELPA archive description if needed.
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex
  
    ;; auto-complete for cider
    ac-cider

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
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

;; Disable cider help banner
(setq cider-repl-display-help-banner nil)

;; Load and set solarized theme dark
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(setq frame-background-mode 'dark)
(load-theme 'solarized t)
(enable-theme 'solarized)

;; auto close bracket insertion.
(electric-pair-mode 1) 

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

;; ido 
(ido-mode t)

;; make cursor a bar
(setq-default cursor-type 'bar) 

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
 
 ;; unbind alt key
(setq ns-alternate-modifier nil)

;; Turn on recent file mode so that you can more easily switch to
;; recently edited files when you first start emacs
(setq recentf-save-file (concat user-emacs-directory ".recentf"))
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 40)
