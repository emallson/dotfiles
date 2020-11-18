{:user {:plugins [[jonase/eastwood "0.3.11"]
                  [lein-kibit "0.1.8"]
                  [lein-cljfmt "0.6.7"]
                  [cider/cider-nrepl "0.25.3"]
                  [refactor-nrepl "2.5.0"]]
        :dependencies [[hashp "0.2.0"]
                       [expound "0.8.6"]
                       [orchestra "2020.09.18-1"]]
        :injections [(require 'hashp.core
                              '[orchestra.spec.test :as st]
                              '[expound.alpha :as expound]
                              '[clojure.spec.alpha :as s])
                     (defn explainer []
                       (alter-var-root #'s/*explain-out*
                                       (constantly (expound/custom-printer {:theme :none}))))
                     ;; instrumenting everything breaks error handling on doseform. really annoying
                     (defn instrument
                       "See: https://conan.is/blogging/clojure-spec-tips.html"
                       []
                       (with-out-str (st/instrument)))]}}
