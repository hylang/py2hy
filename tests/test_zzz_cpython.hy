"Try translating CPython's own test suite to check for crashes.
N.B. This test takes a while to run (which is why the file is
alphabetically last)."


(import
  shutil)


(defn test-cpython [cache]

  (setv pyv (.removesuffix (hy.I.platform.python-version) ".0"))
  (setv d (cache.mkdir f"test_cpython_{pyv}"))
  (when (= (len (list (d.iterdir))) 0)
    ; Download and extract CPython's tests.
    (hy.I.urllib/request.urlretrieve
      f"https://www.python.org/ftp/python/{pyv}/Python-{pyv}.tgz"
      (/ d f"Python-{pyv}.tgz"))
    (shutil.unpack-archive :filter "data"
      (/ d f"Python-{pyv}.tgz")
      d)
    (shutil.move (/ d f"Python-{pyv}" "Lib" "test") (/ d "t"))
    (.unlink (/ d f"Python-{pyv}.tgz"))
    (shutil.rmtree (/ d f"Python-{pyv}")))

  (setv test-paths (lfor
    [dirpath _ filenames] (.walk (/ d "t"))
    :if (not (= dirpath.stem "encoded_modules"))
    fname filenames
    :if (.endswith fname ".py")
    :if (not (.startswith fname "bad"))
    (/ dirpath fname)))
  (assert (> (len test-paths) 500))

  (for [path test-paths]
    (hy.I.py2hy.ast-to-models :allow-unimplemented True
      (hy.I.ast.parse (.read-text path)))))
