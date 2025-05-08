import setuptools
from pathlib import Path

setuptools.setup(
    name = 'py2hy',
    version = '0.1.0',
    author = 'Kodi B. Arfer',
    description = 'Translate Python code to Hy code',
    long_description = Path('README.rst').read_text(),
    long_description_content_type = 'text/x-rst',
    project_urls = {
        'Source Code': 'https://github.com/hylang/py2hy'},
    install_requires = [
        'hy >= 1.1.0',
        'hyrule >= 1'],
    packages = setuptools.find_packages(),
    package_data = dict(py2hy = [
        str(p.relative_to('py2hy'))
        for p in Path('py2hy').rglob('*.hy')]),
    classifiers = [
        'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
        'Operating System :: OS Independent',
        'Programming Language :: Hy'])
