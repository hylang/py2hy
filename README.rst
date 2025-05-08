py2hy
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

py2hy is a library and command-line interface to translate Python code to `Hy <http://hylang.org>`__ code. As with Hy's built-in ``hy2py``, all style information is discarded, including most comments. The result is messy, in part since there is no Hy autoformatter (yet?), but it works, and it makes a good starting point for a hand translation. You can also use py2hy when still learning Hy, to help figure out how to do something in Hy given an example in Python.

py2hy is currently unreleased, since it depends on bugfixes in Hy 1.1.0, which is also unreleased.

Usage
============================================================

To use the command-line interface, see ``python3 -m py2hy --help``. The programmatic interface comprises two functions, of which see the docstrings:

- ``py2hy.ast_to_models``
- ``py2hy.ast_to_text``

The test suite uses pytest.

Unimplemented nodes
============================================================

The following features of Python's ``ast`` are not yet implemented, and are unlikely to get implemented unless I find myself wanting them for some reason. I'll accept patches for them, though.

- ``type_comment`` for these node types: ``For``, ``AsyncFor``, ``With``, ``AsyncWith``
- Type aliases: ``TypeAlias``, ``TypeIgnore``, ``TypeVar``, ``ParamSpec``, ``TypeVarTuple``
- ``TryStar``
- Pattern-matching: ``Match``, ``MatchValue``, ``MatchSingleton``, ``MatchSequence``, ``MatchMapping``, ``MatchClass``, ``MatchStar``, ``MatchAs``, ``MatchOr``

License
============================================================

This program is copyright 2025 Kodi B. Arfer.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the `GNU General Public License`_ for more details.

.. _`GNU General Public License`: http://www.gnu.org/licenses/
