(require 'smtpmail)
(require 'mu4e-contrib)

(setq user-full-name "J David Smith")

(defmacro mu4e-make-folder-from-message-function (subdir)
  `(lambda (msg)
     (f-join
      (f-dirname (mu4e-message-field msg :maildir))
      ,subdir)))

(setq mu4e-maildir       "~/Mail/"
      mu4e-drafts-folder "/drafts"
      mu4e-sent-folder   "/emallson@archlinux.us/Sent Mail"
      mu4e-trash-folder  (mu4e-make-folder-from-message-function "Trash"))

(defvar mu4e-account-alist
  '(("emallson@archlinux.us"
     (mu4e-sent-folder "/emallson@archlinux.us/Sent Mail")
     (mu4e-drafts-folder "/emallson@archlinux.us/Drafts")  ; changed from [Gmail].Drafts because these buggers don't get deleted properly
     (user-mail-address "emallson@archlinux.us")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("emallson@atlanis.net"
     (mu4e-sent-folder "/emallson@atlanis.net/Sent")
     (mu4e-drafts-folder "/emallson@atlanis.net/Drafts")
     (user-mail-address "emallson@atlanis.net")
     (smtpmail-default-smtp-server "smtp.atlanis.net")
     (smtpmail-smtp-server "smtp.atlanis.net")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("emallson@cs.uky.edu"
     (mu4e-sent-folder "/emallson@cs.uky.edu/Sent")
     (mu4e-drafts-folder "/emallson@cs.uky.edu/Drafts")
     (user-mail-address "emallson@cs.uky.edu")
     (smtpmail-default-smtp-server "mail.cs.uky.edu")
     (smtpmail-smtp-server "mail.cs.uky.edu")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ("emallson@ufl.edu"
     (mu4e-sent-folder "/emallson@ufl.edu/Sent")
     (mu4e-drafts-folder "/emallson@ufl.edu/Drafts")
     (user-mail-address "emallson@ufl.edu")
     (smtpmail-default-smtp-server "smtp.office365.com")
     (smtpmail-smtp-server "smtp.office365.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))))

(defun mu4e-on-compose-set-account ()
  "Set the account to use when composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat 'car mu4e-account-alist " "))
                             (mapcar 'car mu4e-account-alist)
                             nil t nil nil (caar mu4e-account-alist))))
         (account-vars (cdr (assoc account mu4e-account-alist))))
    (if account-vars
        (mapc (lambda (var)
                (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'mu4e-on-compose-set-account)

(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-maildir-shortcuts
      '(("/emallson@archlinux.us/INBOX" . ?i)
        ("/emallson@archlinux.us/Sent Mail" . ?s)
        ("/emallson@atlanis.net/INBOX" . ?a)
        ("/emallson@cs.uky.edu/INBOX" . ?c)
        ("/emallson@ufl.edu/INBOX" . ?u)))

(setq message-send-mail-function 'smtpmail-send-it)

(add-to-list 'mu4e-bookmarks
             '("flag:flagged" "Flagged" ?f))
(add-to-list 'mu4e-bookmarks
             '("maildir:\"/emallson@archlinux.us/Important\" and flag:unread" "Important & Unread" ?I))
(add-to-list 'mu4e-bookmarks
             '("maildir:\"/emallson@archlinux.us/INBOX\" or maildir:\"/emallson@atlanis.net/INBOX\" or maildir:\"/emallson@cs.uky.edu/INBOX\" or maildir:\"/emallson@ufl.edu/INBOX\"" "Combined Inbox" ?i))

(setq message-kill-buffer-on-exit t)

(add-hook 'mu4e-view-mode-hook 'epa-mail-verify)
(defun epa-quit-info ()
  (let ((window (get-buffer-window epa-info-buffer)))
    (unless (null window)
      (delete-window window))))
(advice-add 'mu4e~view-quit-buffer :after 'epa-quit-info)

(setq mu4e-html2text-command 'mu4e-shr2text)

(provide 'mu4e-config)
