;;; init-python.el --- Initialization for python programming
;;; Commentary:
;;;
;;; The folks on #emacs guided me towards elpy with jedi. Let's see how this goes.
;;;
;;; Code:

(require 'el-get)
;; (add-to-list 'modules:el-get-packages 'elpy)
(el-get-bundle elpy (elpy-enable))
(provide 'init-python)
;;; init-python.el ends here
