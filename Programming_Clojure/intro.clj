(def visitors (atom #{}))

(defn hello
  "Takes a name and says hello.
   Also keeps track if you've been here before."
  [name]
  (swap! visitors conj name)
  (str "Hello " name))
