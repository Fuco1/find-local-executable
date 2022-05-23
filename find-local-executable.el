;;; find-local-executable.el --- find local executables -*- lexical-binding: t -*-

;; Copyright (C) 2019 Matúš Goljer

;; Author: Matúš Goljer <matus.goljer@gmail.com>
;; Maintainer: Matúš Goljer <matus.goljer@gmail.com>
;; Version: 0.0.1
;; Created: 19th October 2019
;; Package-requires: ()
;; Keywords: files, convenience

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defun find-local-executable--vendored
    (vendor-root-dir vendor-bin-dir binary use-global-fallback)
  "Find a vendored binary.

First, detect the project root by looking up the file hierarchy until
VENDOR-ROOT-DIR is found.  Then relative to the root, find
VENDOR-BIN-DIR.

Look up BINARY in this directory.  If it does not exist and
USE-GLOBAL-FALLBACK is non-nil, look for a globally installed
executable with `executable-find'.

Return full path to the executable or nil if not found."
  (let ((local
         (when-let
             ((root (locate-dominating-file default-directory vendor-root-dir))
              (executable (expand-file-name (concat root vendor-bin-dir binary))))
           (and (file-exists-p executable) executable))))
    (if local
        local
      (when use-global-fallback
        (executable-find binary)))))


;;; nodejs

(defun find-local-executable-nodejs (binary &optional use-global-fallback)
  "Find locally installed BINARY.

Return full path to the BINARY or nil if not found.

If USE-GLOBAL-FALLBACK is non-nil, try to locate globally installed
binary of the same name."
  (find-local-executable--vendored
   "node_modules" "node_modules/.bin/" binary use-global-fallback))

(eval-when-compile
  (defvar company-flow-executable)
  (defvar flow-minor-default-binary)
  (defvar flycheck-javascript-flow-coverage-executable)
  (defvar flycheck-javascript-flow-executable)
  (defvar lsp-clients-flow-server))

;;;###autoload
(defun find-local-executable-nodejs-setup-flow ()
  "Setup paths to flow executable for current buffer"
  (interactive)
  (let ((executable (find-local-executable-nodejs "flow")))
    (setq-local company-flow-executable executable)
    (setq-local flow-minor-default-binary executable)
    (setq-local flycheck-javascript-flow-coverage-executable executable)
    (setq-local flycheck-javascript-flow-executable executable)
    (setq-local lsp-clients-flow-server executable)))

(eval-when-compile
  (defvar flycheck-javascript-eslint-executable))

;;;###autoload
(defun find-local-executable-nodejs-setup-eslint ()
  "Setup paths to eslint executable for current buffer"
  (interactive)
  (let ((executable (find-local-executable-nodejs "eslint")))
    (setq-local flycheck-javascript-eslint-executable executable)))


;;; typescript

(defalias 'find-local-executable-typescript 'find-local-executable-nodejs)

(eval-when-compile
  (defvar flycheck-typescript-tslint-executable))

;;;###autoload
(defun find-local-executable-typescript-setup-tslint ()
  "Setup paths to tslint executable for current buffer"
  (interactive)
  (let ((executable (find-local-executable-typescript "tslint")))
    (setq-local flycheck-typescript-tslint-executable executable)))

;;;###autoload
(defun find-local-executable-typescript-setup-prettier ()
  "Setup paths to prettier executable for current buffer"
  (interactive)
  (let ((executable (find-local-executable-typescript "prettier")))
    (setq-local prettier-js-command executable)))


;;; php

(defun find-local-executable-php (binary &optional use-global-fallback)
  "Find locally installed BINARY.

Return full path to the BINARY or nil if not found.

If USE-GLOBAL-FALLBACK is non-nil, try to locate globally installed
binary of the same name."
  (find-local-executable--vendored
   "vendor" "vendor/bin/" binary use-global-fallback))

(eval-when-compile
  (defvar flycheck-php-phpstan-executable))

;;;###autoload
(defun find-local-executable-php-setup-phpstan ()
  "Setup paths to phpstan executable for current buffer"
  (interactive)
  (if-let ((executable (find-local-executable-php "phpstan")))
      (setq-local flycheck-php-phpstan-executable executable)
    (when-let ((executable (find-local-executable-php "phpstan.phar")))
      (setq-local flycheck-php-phpstan-executable executable))))

(eval-when-compile
  (defvar flycheck-php-phpcs-executable))

;;;###autoload
(defun find-local-executable-php-setup-phpcs ()
  "Setup paths to phpcs executable for current buffer"
  (interactive)
  (when-let ((executable (find-local-executable-php "phpcs")))
    (setq-local flycheck-php-phpcs-executable executable)))

(provide 'find-local-executable)
;;; find-local-executable.el ends here
