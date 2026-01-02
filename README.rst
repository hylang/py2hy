py2hy
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

py2hy is a library and command-line interface to translate Python code to `Hy <http://hylang.org>`__ code. As with Hy's built-in ``hy2py``, all style information is discarded, including most comments. The result can be messy, but it works, and it makes a good starting point for a hand translation. You can also use py2hy when still learning Hy, to help figure out how to do something in Hy given an example in Python.

Usage
============================================================

To use the command-line interface, see ``python3 -m py2hy --help``. The programmatic interface comprises two functions, of which see the docstrings:

- ``py2hy.ast_to_models``
- ``py2hy.ast_to_text``

The test suite uses pytest.

To autoformat the output, try the third-party library `beautifhy <https://github.com/atisharma/beautifhy>`__::

    $ python3 -m py2hy mycode.py | beautifhy -

Unimplemented nodes
============================================================

The following features of Python's ``ast`` are not yet implemented, and are unlikely to get implemented unless I find myself wanting them for some reason. I'll accept patches for them, though.

- ``type_comment`` for these node types: ``For``, ``AsyncFor``, ``With``, ``AsyncWith``
- Type aliases: ``TypeAlias``, ``TypeIgnore``, ``TypeVar``, ``ParamSpec``, ``TypeVarTuple``
- ``TryStar``
- Pattern-matching: ``Match``, ``MatchValue``, ``MatchSingleton``, ``MatchSequence``, ``MatchMapping``, ``MatchClass``, ``MatchStar``, ``MatchAs``, ``MatchOr``

Version history
============================================================

Here are the most important user-visible changes in each release.

- 0.2.0 (2025-06-05): ``ast_to_models`` and ``ast_to_text`` got a new parameter ``allow_unimplemented``. An anthill's worth of bugs have been exterminated.
- 0.1.0 (2025-05-08): First release.

License
============================================================

This program is copyright 2026 Kodi B. Arfer.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the `GNU General Public License`_ for more details.

.. _`GNU General Public License`: http://www.gnu.org/licenses/
