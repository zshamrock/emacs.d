;; check the .emacs.d directory to store the packages and the data
(set 'user-emacs-directory "~/.emacs.clojure.meetup.d/")
(set 'debug-on-error t)
;; probably this is the way also to split long one config file into separate sub-files, but need to investigate
(load "~/dev/github/emacs.d/init.el")
(package-initialize)
(initialize-emacs)
