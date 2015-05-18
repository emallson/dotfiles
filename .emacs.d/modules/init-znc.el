;;; init-znc.el --- Initialization code for znc.el
;;;
;;; Commentary:
;;;
;;; The primary addition provided by this file is the `ZNC-LOAD-SERVERS'
;;; function, which loads server passwords from my .authinfo.gpg file (since
;;; znc.el lacks that capabilitiy.
;;;
;;; Code:

(require 'init-el-get)
(require 'el-get)

(add-to-list 'el-get-sources
             '(:name znc
                     :type git
                     :url "git://github.com/sshirokov/ZNC.el.git"
                     :features znc
                     :compile "znc.el"
                     :after (require 'znc)))

(defun znc-load-servers ()
  "Load passwords for servers from auth sources."
  (interactive)
  (let ((servers '(("atlanis.net" 6464 t
                    ((freenode "emallson"))))))

    (customize-set-variable
     'znc-servers
     (mapcar (lambda (znc-server)
               (nconc (subseq znc-server 0 3)
                      (list (mapcar (lambda (irc-server)
                                      (append irc-server (list (auth-source-pick-first-password
                                                                :host (nth 0 znc-server)
                                                                :port (nth 1 znc-server)
                                                                :user (nth 1 irc-server)))))
                                    (car (last znc-server))))))
             servers))))

(add-to-list 'modules:el-get-packages 'znc)

(provide 'init-znc)
;;; init-znc.el ends here
