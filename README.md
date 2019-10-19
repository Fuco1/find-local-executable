# find-local-executable

Find executables installed locally by npm, yarn, composer, stack, pip, gem...

## Motivation

When we use packages like flycheck, company, lsp we often install the
tools locally in a specific version using a package manager.  These
tools often only look for a globally installed executable which might
not be what we want.

## Usage

This package provides a uniform interface for setting up paths to
executables installed locally (meaning not system-wide).

To find the `flow` binary installed by `npm` or `yarn`, use

``` emacs-lisp
(find-local-executable-nodejs "flow")
```

You can substitute `"flow"` with any binray you want.

The general pattern is:

``` emacs-lisp
(defun find-local-executable-PLATFORM (binary &optional use-global))
```

On top of that, we support many popular packages out of the box.  For
example, to set up paths for packages relying on `"flow"` in nodejs,
use:

``` emacs-lisp
(find-local-executable-nodejs-setup-flow)
```

This will configure paths for (among others)

``` emacs-lisp
company-flow-executable
flow-minor-default-binary
flycheck-javascript-flow-coverage-executable
flycheck-javascript-flow-executable
lsp-clients-flow-server
```

The general pattern is

``` emacs-lisp
(defun find-local-executable-PLATFORM-setup-BINARY ())
```

Following is an exhaustive list  of supported platforms.  If you don't
see your favorite platform, please open an issue or even better submit
a pull request!

## Supported platforms

### nodejs [via npm, yarn]

Binary:

``` emacs-lisp
(find-local-executable-nodejs BINARY)
```

Supported binaries:

``` emacs-lisp
(find-local-executable-nodejs-setup-flow)
(find-local-executable-nodejs-setup-eslint)
```

### typescript [via npm, yarn]

Binary:

``` emacs-lisp
(find-local-executable-typescript BINARY)
```

Supported binaries:

``` emacs-lisp
(find-local-executable-typescript-setup-tslint)
```

### php [via composer]

Binary:

``` emacs-lisp
(find-local-executable-php BINARY)
```

Supported binaries:

``` emacs-lisp
(find-local-executable-php-setup-phpstan)
(find-local-executable-php-setup-phpcs)
```
