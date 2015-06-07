(el-get-bundle! rust-mode
  (setq racer-rust-src-path "~/Code/racer/rust/src")
  (add-to-list 'load-path "~/Code/racer/editors/emacs")
  (eval-after-load "rust-mode" '(require 'racer)))
