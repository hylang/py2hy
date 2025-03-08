"Here we reuse a lot of tests from Hy itself via `pydemo.py`."


(import
  ast
  subprocess
  py2hy
  hyrule [import-path])


(defn test-pydemo [cache tmp-path]

  (setv d (cache.mkdir "hy2py_pydemo"))

  (when (= (len (list (d.iterdir))) 0)

    ; Get the files we need from Hy's Git repository.
    (import urllib.request [urlretrieve])
    (setv url-root "https://raw.githubusercontent.com/hylang/hy/")
    (setv commit "93fbd2030a16d8d8d56f86bd5be48a32a727b302")
    (urlretrieve
      f"{url-root}/{commit}/tests/resources/pydemo.hy"
      (/ d "pydemo.hy"))
    (urlretrieve
      f"{url-root}/{commit}/tests/test_hy2py.py"
      (/ d "test_hy2py.py"))

    ; Call `hy2py` on `pydemo.hy` to get a Python version.
    (.write-text (/ d "pydemo.py") (.
      (subprocess.run
        ["hy2py" (str (/ d "pydemo.hy"))]
        :text True :check True :capture-output True)
      stdout)))

  ; Translate `pydemo.py` back to Hy.
  (setv p (/ tmp-path "output.hy"))
  (p.write-text (py2hy.ast-to-text
    (ast.parse (.read-text (/ d "pydemo.py")) "pydemo")))

  ; Call `assert-stuff` on the result.
  (.assert-stuff (import-path (/ d "test_hy2py.py"))
    :m (import-path p)
    :can-test-async True))
