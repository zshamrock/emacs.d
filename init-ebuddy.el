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
 '(custom-safe-themes (quote ("8bb1e9a22e9e9d405ca9bdf20b91301eba12c0b9778413ba7600e48d2d3ad1fb" default)))
;; configure theme here
 '(menu-bar-mode nil) ;; disable menu bar
 '(tool-bar-mode nil) ;; disable tool bar
 '(scroll-bar-mode nil) ;; no scrolling
 '(inhibit-startup-message t) ;; no startup screen (still can be accessible by C-h C-a 
 ;; this is also an alias to inhibit-startup-screen
) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; another alternative is to use (package-initialize)
(add-hook 'after-init-hook 'initialize-emacs)

(defun initialize-emacs ()  
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
)

;; Can present:
;;  - working with packages
;;  - working with git
;;  - nrepl interaction (but goes outside of the topic, the actual topic is about Emacs itself)
;; new useful shortcut C-h w (M-x where-is) shows the key shortcut for the command
