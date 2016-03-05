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

;; Install ac-cider if not already there
;; Also installs cider
(unless (package-installed-p 'ac-cider)
  (package-install 'ac-cider))

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

;; Enable autocomplete globally
(require 'auto-complete)
(global-auto-complete-mode t)

;; Load solarized theme
(load-theme 'solarized-dark t)

(unless (display-graphic-p)
  (solarized-with-color-variables 'dark
  (custom-theme-set-faces 'solarized-dark
    `(default ((,class (:foreground ,base0 :background ,nil)))))))

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
