(import
  ast
  pytest
  py2hy)


(defn 2hy [python-text]
  (get (py2hy.ast-to-models (ast.parse python-text)) 0))


(defn test-skip-pass []
  (assert (=
    (2hy "def f(): pass; 2; pass; 3")
    '(defn f [] 2 3))))


(defn test-negative-constants []
  (assert (= (2hy "-2")   '-2))
  (assert (= (2hy "-2.5") '-2.5))
  (assert (= (2hy "-3j")  '-3j)))


(defn test-slice-with-cut []

  (defn check [python-code hy-model]
    ; For paranoia's sake, first check that they actually do the same
    ; thing.
    (assert (=
      (eval python-code (dict :x (list (range 20))))
      (hy.eval hy-model (dict :x (list (range 20))))))
    ; Now check that py2hy produces `hy-model` from the Python.
    (assert (= (2hy python-code) hy-model)))

  (check "x[:]"      '(cut x))
  (check "x[1:]"     '(cut x 1 None))
  (check "x[:3]"     '(cut x 3))
  (check "x[1:3]"    '(cut x 1 3))
  (check "x[1:10:2]" '(cut x 1 10 2))
  (check "x[1::2]"   '(cut x 1 None 2))
  (check "x[:10:2]"  '(cut x None 10 2))
  (check "x[::-2]"   '(cut x None None -2))

  ; Slices in tuple indices can't expressed with `cut`. In real code,
  ; one would use e.g. `hyrule.ncut`.
  (assert (=
    (2hy "x[1:3:, ::-2]")
    '(get x #(
      (hy.I.builtins.slice 1 3 None)
      (hy.I.builtins.slice None None -2))))))


(defn test-translation-errors []

  (defclass C [ast.AST])
  (with [e (pytest.raises NotImplementedError)]
    (py2hy.ast-to-models (C)))
  (assert (. e value args [0] (startswith "Unimplemented `ast` node type:")))

  (with [e (pytest.raises TypeError)]
    (py2hy.ast-to-models 5))
  (assert (. e value args [0] (startswith "Not an `ast` node:"))))
