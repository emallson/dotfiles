{:user {:dependencies [[org.clojure/tools.namespace "0.2.4"]
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [im.chit/vinyasa "0.1.8"]
                       [difform "1.1.2"]]
        :plugins [[cider/cider-nrepl "0.7.0"]
                  [jonase/eastwood "0.1.4"]
                  [lein-bikeshed "0.1.8"]
                  [lein-kibit "0.0.8"]]
        :injections [(require 'vinyasa.inject)
                     (vinyasa.inject/inject
                      'clojure.core '>
                      '[[clojure.repl doc source]
                        [clojure.pprint pprint pp]
                        [alex-and-georges.debug-repl debug-repl]
                        [com.georgejahad.difform difform]
                        [vinyasa.pull pull]])]}}
