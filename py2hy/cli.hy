(import
  sys
  pathlib [Path]
  ast
  py2hy
  hyrule [parse-args])

(defn main [_ #* args]

  (setv p (parse-args
    :prog "py2hy"
    :args args
    :description "Translate Python code to Hy code."
    :spec [
      ["FILE" :nargs "?" :type Path
        :help "Python source file (default: use standard input)"]
      ["-V" "--version"
        :action "version" :version f"py2hy {py2hy.__version__}"]]))

  (print :end "" (py2hy.ast-to-text
    (if p.FILE
      (ast.parse (.read-text p.FILE) p.FILE)
      (ast.parse (.read sys.stdin) "<stdin>")))))
