"Here we test translation of Python code that previously caused
`py2hy` to raise an error, or produced a semantically incorrect
result."


(import
  ast
  py2hy)


(defn 2hy [python-text]
  (get (py2hy.ast-to-models (ast.parse python-text)) 0))


(defn test-return []
  ; https://github.com/hylang/py2hy/issues/3
  (assert (= (2hy "return 1")    '(return 1)))
  (assert (= (2hy "return None") '(return None)))
  (assert (= (2hy "return")      '(return))))


(defn test-chained-assignment []
  ; https://github.com/hylang/py2hy/issues/2

  (setv d {})
  (hy.eval :globals d `(do
    (setv x [0 0 0 0 0])
    (setv accum [])
    (defn f [i]
      (.append accum i) i)
    ~(2hy "x[f(1)] = x[f(2)] = f(3)")))
  (assert (= (:x d) [0 3 3 0 0]))
  (assert (= (:accum d) [3 1 2])))
