;;; d2-emacs --- Edit d2 files on Emacs. -*- lexical-binding: t -*-
;;
;; Package-Requires: ((emacs "24"))
;; Homepage: https://github.com/diasbruno/d2-emacs
;; URL: https://github.com/diasbruno/d2-emacs
;; Version: 1.0
;; Keywords: d2 languages diagrams
;;
;;; Commentary:
;;
;;  d2 as the say in their repository
;;  "A modern diagram scripting language that
;;  turns text to diagrams."
;;
;;  Go to their site, https://d2lang.com/,
;;  to learn more about the project.
;;
;;  This extension starts d2 in watch mode
;;  for the file of the buffer.
;;
;;  The file needs to be created
;;  and the output is the filename with ".svg"
;;  extension.
;;
;;; Code:

(defconst *d2--log-buffer-name* "*d2-log*"
  "Default log buffer's name.")

(defvar *d2--process* nil
  "Current d2 process.")

(defvar *d2--command-path* "d2"
  "Customizable path for the command.")

(defun d2--make-output-file-name (file-name)
  "Make output file for FILE-NAME."
  (string-replace ".d2" ".svg" file-name))

(defun d2-terminate ()
  "Terminate the current d2 process."
  (kill-process *d2--process*))

(defun d2--create-process (command)
  "Create the process using COMMAND."
  (setf *d2--process*
	(make-process :buffer *d2--log-buffer-name*
		      :command command)))

(defun d2--make-command-args (file-name)
  "Make command arguments for FILE-NAME."
  (list *d2--command-path*
	"--watch"
	file-name
	(d2--make-output-file-name file-name)))

(defun d2-start ()
  "Start a d2 server."
  (let* ((file-name (buffer-file-name (current-buffer)))
	 (command (d2--make-command-args file-name)))
    (d2--create-process command)))

(provide 'd2-emacs)
;;; d2-emacs.el ends here
