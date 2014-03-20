;; hide-windows.lisp
;; Adds support for 'hiding' windows from the being raised by (run-or-raise)

(in-package :stumpwm)

(define-window-slot "hidden")

(defun run-or-raise (cmd props &optional (all-groups *run-or-raise-all-groups*) (all-screens *run-or-raise-all-screens*))
  "Redef of builtin run-or-raise that adds support for window hiding."
  (labels
      ;; Raise the window win and select its frame.  For now, it
      ;; does not select the screen.
      ((goto-win (win)
         (let* ((group (window-group win))
                (frame (window-frame win))
                (old-frame (tile-group-current-frame group)))
           (focus-all win)
           (unless (eq frame old-frame)
             (show-frame-indicator group)))))
    (let* ((matches (remove-if #'window-hidden (find-matching-windows props all-groups all-screens)))
           ;; other-matches is list of matches "after" the current
           ;; win, if current win matches. getting 2nd element means
           ;; skipping over the current win, to cycle through matches
           (other-matches (member (current-window) matches))
           (win (if (> (length other-matches) 1)
                    (second other-matches)
                    (first matches))))
      (if win
          (if (eq (type-of (window-group win)) 'float-group)
              (group-focus-window (window-group win) win)
              (goto-win win))
          (run-shell-command cmd)))))

(defcommand toggle-hide-window () ()
  (setf (window-hidden (current-window)) (not (window-hidden (current-window)))))
