(load "~/.sbcl/site/cl-mpd/mpd.asd")
(asdf:operate 'asdf:load-op 'mpd)

(defun mpd-make-connection () (mpd:mpd-make-connection "localhost" 6600))
 
;(in-package :stumpwm)

(defparameter *mpd-pause-state* 0)
(defcommand mpd-play-pause-toggle () ()
  (let ((*mpd* (mpd-make-connection)))
    (setq *mpd-pause-state* (mod (+ *mpd-pause-state* 1) 2))
    (mpd:mpd-send-pause-command *mpd* *mpd-pause-state*)))

(defcommand mpd-stop () ()
  (let ((*mpd* (mpd-make-connection)))
    (setq *mpd-pause-state* 0)
    (mpd:mpd-send-stop-command *mpd*)))

(defcommand mpd-next () ()
  (let ((*mpd* (mpd-make-connection)))
    (mpd:mpd-send-next-command *mpd*)))

(defcommand mpd-prev () ()
  (let ((*mpd* (mpd-make-connection)))
    (mpd:mpd-send-prev-command *mpd*)))

(define-key *top-map* (kbd "XF86AudioPlay") "mpd-play-pause-toggle")
(define-key *top-map* (kbd "XF86AudioStop") "mpd-stop")
(define-key *top-map* (kbd "XF86AudioNext") "mpd-next")
(define-key *top-map* (kbd "XF86AudioPrev") "mpd-prev")

; note: use mpd:mpd-get-return-elements to get return status - use with mpd:mpd-send-currentsong-command to get current song info.
