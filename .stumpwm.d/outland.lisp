(ql:quickload :cl-ppcre)
(defcommand display-battery-status () ()
  (multiple-value-bind (match groups)
      (cl-ppcre:scan-to-strings "(\\d{1,2}%), (\\d{2}:\\d{2}:\\d{2})" 
                                (run-shell-command "acpi" t))
    (message "~a remaining (Approx ~a)"(elt groups 0) (elt groups 1))))
(define-key *root-map* (kbd "P") "display-battery-status")
