;;; nixos-env.el --- Loading NixOS Environments in Emacs
;;;
;;; Commentary:
;;;
;;; Code:

(defun nixos-env-list ()
  "List available Nix environments."
  (let ((raw-output (with-temp-buffer
                      (shell-command "nix-env -q | grep env- | gawk 'match($0, /env-(.+)/, m) { print m[1]; }'" t)
                      (buffer-string))))
    (split-string raw-output)))

(defun nixos-env-apply (env-name &optional globalp)
  "Apply a the Nix environment named `ENV-NAME' (globally if `GLOBALP')."
  (interactive
   (list (completing-read "Environment: " (nixos-env-list))
         current-prefix-arg))
  (unless globalp
    (make-local-variable 'process-environment)
    (make-local-variable 'exec-path))
  (setq process-environment
        (with-temp-buffer
          (shell-command (concat "load-env-" env-name " env | grep -v 'http_proxy'") t)
          (rest (split-string (buffer-string) "\n" t))))
  (setq exec-path
        (split-string (getenv "PATH") ":" t)))

(provide 'nixos-env)

;;; nixos-env.el ends here
