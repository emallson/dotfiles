{:user {:dependencies [[org.clojure/tools.namespace "0.2.4"]
                       [org.clojars.gjahad/debug-repl "0.3.3"]
                       [im.chit/vinyasa "0.1.8"]
                       [difform "1.1.2"]
                       [compliment "0.1.0"]]
        :plugins [[cider/cider-nrepl "0.6.0"]]
        :injections [(require 'vinyasa.inject)
                     (vinyasa.inject/inject 
                      'clojure.core '>
                      '[[clojure.repl doc source]
                        [clojure.pprint pprint pp]
                        [alex-and-georges.debug-repl debug-repl]
                        [com.georgejahad.difform difform]
                        [vinyasa.pull pull]])]}}
