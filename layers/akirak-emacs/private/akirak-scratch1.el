;; I am not using these functions
(defun akirak/scratch-kill-buffer-query-function ()
  (if (and (not buffer-file-name)
           (bound-and-true-p akirak/is-scratch-buffer)
           (buffer-modified-p))
      (y-or-n-p "Kill this modified buffer? ")
      t))

(add-to-list 'kill-buffer-query-functions 'akirak/scratch-kill-buffer-query-function)

(defun akirak/window-new-same-mode ()
  "Create a scratch buffer of the same mode in a window split below."
  (interactive)
  (let ((current-mode major-mode)
        (buf (generate-new-buffer "new")))
    (split-window-below-and-focus)
    (switch-to-buffer buf)
    (funcall current-mode)
    (setq-local akirak/is-scratch-buffer t)))

(defun akirak/window-new-with-name ()
  "Create a scratch buffer with a file name in a window split below."
  (interactive)
  (let* ((bufname (read-from-minibuffer "Name of a new buffer: "))
         (mjm (cl-loop for (r . m) in auto-mode-alist
                       when (string-match r bufname)
                       return m))
         (buf (generate-new-buffer bufname)))
    (split-window-below-and-focus)
    (switch-to-buffer buf)
    (with-current-buffer buf
      (funcall mjm)
      (setq-local akirak/is-scratch-buffer t)
      )))

(provide 'akirak-scratch1)
