"Here we reuse a lot of tests from Hy itself via `pydemo.hy`."


(import
  ast
  subprocess
  py2hy
  hyrule [import-path])
(setv  T True  F False)


(defn test-pydemo [cache tmp-path]

  (setv d (cache.mkdir "hy2py_pydemo"))

  (when (not (.exists (/ d "pydemo.py")))

    ; Get the files we need from Hy's Git repository.
    (import urllib.request [urlretrieve])
    (setv url-root "https://raw.githubusercontent.com/hylang/hy/")
    (setv commit "a938f8d1ea135b410929b79a126b7d1395dffb48")
    (urlretrieve
      f"{url-root}/{commit}/tests/resources/pydemo.hy"
      (/ d "pydemo.hy"))
    (urlretrieve
      f"{url-root}/{commit}/tests/test_hy2py.py"
      (/ d "test_hy2py.py"))

    ; Call `hy2py` on `pydemo.hy` to get a Python version, `pydemo.py`.
    (.write-text (/ d "pydemo.py") (.
      (subprocess.run
        ["hy2py" (str (/ d "pydemo.hy"))]
        :text T :check T :capture-output T)
      stdout)))

  ; Translate `pydemo.py` back to Hy.
  (setv p (/ tmp-path "output.hy"))
  (.write-text p (py2hy.ast-to-text
    (ast.parse (.read-text (/ d "pydemo.py")) "pydemo")))

  ; Call `assert-stuff` on the result.
  (.assert-stuff (import-path (/ d "test_hy2py.py"))
    :m (import-path p)))
