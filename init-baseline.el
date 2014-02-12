;; can do the talk during the next Clojure meetup about Emacs Started Guide (just from clean install, without any starter kit, which is nice to use, but good to know at least how can you do everything yourself if you need

(require 'package) ;; enable package-archives variable

;; add melpa repository, can use Ctrl-h v package-archives
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
;; '(custom-enabled-themes (quote (zenburn))) ;; alternative to (load-theme 'nzenburn t) in initialize-emacs()
 '(custom-safe-themes (quote ("8bb1e9a22e9e9d405ca9bdf20b91301eba12c0b9778413ba7600e48d2d3ad1fb" default)))
;; configure theme here
 '(menu-bar-mode nil) ;; disable menu bar
 '(tool-bar-mode nil) ;; disable tool bar
 '(scroll-bar-mode nil) ;; no scrolling
 '(inhibit-startup-message t) ;; no startup screen (still can be accessible by C-h C-a 
 ;; this is also an alias to inhibit-startup-screen
 '(calendar-week-start-day 1) ;; start week from Monday
) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-initialize)

;; another alternative is to use (package-initialize)
(add-hook 'after-init-hook 'initialize-emacs)

(defun initialize-emacs ()
  (install-missing-packages)
  
  ;;
  (require 'hlinum)
  (global-linum-mode)
  (hlinum-activate)
  ;; there is also possible to load theme from custom settings
  (load-theme 'zenburn t)
  ;; enable fullscreen-mode
  (fullscreen-mode)
  ;; use Shift+(Up/Down/Right/Left) to navigate between windows
  (windmove-default-keybindings)
  ;; nyan mode :)
  (nyan-mode)
  ;; type y or n for prompt instead of yes or no
  (defalias 'yes-or-no-p 'y-or-n-p)
  ;; how to add custom shortcut for the action
  (global-set-key (kbd "<f9>") 'calendar)

  ;; configure duplicate thing
  (require 'duplicate-thing)
  (global-set-key (kbd "M-c") 'duplicate-thing)
  (global-set-key (kbd "C-z") 'undo)
  (global-set-key (kbd "C-x C-b") 'switch-to-buffer)

  ;; do we need to require package any time we want to use it? 
  ;; why for some packages it works fine, but another we need to "require"?
  (require 'auto-complete)

  ;; highlight open/closed parens
  (show-paren-mode)

  ;; give helm a try (I have used ido for a while, interesting to compare with the helm)
  (helm-mode)

  (configure-hooks)
)

(defun install-missing-packages ()
  "Install not installed packages from the list.
See: http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name"
  (setq packages '(hlinum 
		   zenburn-theme 
		   fullscreen-mode 
		   nyan-mode 
		   rainbow-delimiters
		   smartparens
		   cider
		   duplicate-thing
		   auto-complete
		   helm
		   magit
		   projectile
		   zencoding-mode))

  ;; fetch the list of the packages available
  (when (not package-archive-contents)
    (package-refresh-contents))

  ;; install missing packages
  (dolist (package packages)
    (unless (package-installed-p package)
               (package-install package))
    )
)  

;; configure hooks
(defun configure-hooks ()
  "Configure hooks for different Emacs major(?) modes"
    ;; emacs lisp hooks
    (setq elisp-hooks '(rainbow-delimiters-mode
			smartparens-strict-mode
		        auto-complete-mode))

    (setq clojure-hooks (append elisp-hooks '(projectile-mode)))
    
    (setq cider-hooks '(cider-turn-on-eldoc-mode))
    (setq sgml-hooks '(zencoding-mode))

    (apply-hooks 'emacs-lisp-mode-hook elisp-hooks)
    (apply-hooks 'clojure-mode-hook clojure-hooks)
    (apply-hooks 'cider-mode-hook cider-hooks)
    (apply-hooks 'sgml-mode-hook sgml-hooks)

    ;; undefine the key C-j for zencoding-expand-line, use C-j for enter
    (eval-after-load 'zencoding-mode
      '(define-key zencoding-mode-keymap (kbd "C-j") nil))
)

(defun apply-hooks (mode hooks)
  "Apply hooks for the mode"
  (print (concat "Applying hooks for the " (substring (symbol-name mode) 0 -5) "..."))
  (dolist (hook hooks)
    (add-hook mode hook))
)

;; TODO:
;; - try cedet and ebc mode
;; - configure sandbox-ed emacs to experiment with plugins without mess the current stable setup
;; - configure hooks for cider mode
;; - auto indentation (C-j or RET can be rebound)
;; - try ibuffer (what is it?)
;; - learn about dired (navigation specific)
;; - activate projectile
;; - comment the whole block/form
;; - configure clojure-mode-hook
;; - activate auto-complete
;; - configure ido or another suggestion manager (like helm, for example)

;; Can present:
;;  - working with packages
;;  - working with git
;;  - nrepl interaction (but goes outside of the topic, the actual topic is about Emacs itself)
;; new useful shortcut C-h w (M-x where-is) shows the key shortcut for the command
