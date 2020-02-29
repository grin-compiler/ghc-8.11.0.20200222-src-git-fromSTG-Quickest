extlinks = {
    'ghc-ticket': ('https://gitlab.haskell.org/ghc/ghc/issues/%s', '#'),
    'ghc-wiki': ('https://gitlab.haskell.org/ghc/ghc/wikis/%s', '#'),
}

libs_base_uri = '../libraries'

# N.B. If you add a package to this list be sure to also add a corresponding
# LIBRARY_VERSION macro call to configure.ac.
lib_versions = {
    'base': '4.14.0.0',
    'ghc-prim': '0.6.1',
    'template-haskell': '',
    'ghc-compact': '0.1.0.0',
    'ghc': '8.11.0.20200222',
    'parallel': '@LIBRARY_parallel_VERSION@',
    'Cabal': '3.3.0.0',
    'array': '0.5.4.0',
}

version = '8.11.0.20200222'

llvm_version = '9'
