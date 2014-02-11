;; check the .emacs.d directory to store the packages and the data
(set 'user-emacs-directory "~/.emacs.clojure.meetup.d/")
(set 'debug-on-error t)
(load "~/dev/github/emacs.d/init-baseline.el")
(package-initialize)
(initialize-emacs)
