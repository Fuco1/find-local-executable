;;; find-local-executable.el --- find local executables -*- lexical-binding: t -*-

;; Copyright (C) 2019 Matúš Goljer

;; Author: Matúš Goljer <matus.goljer@gmail.com>
;; Maintainer: Matúš Goljer <matus.goljer@gmail.com>
;; Version: 0.0.1
;; Created: 19th October 2019
;; Package-requires: ((dash "2.10.0"))
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


(defun find-local-executable-nodejs (binary &optional use-global)
  "Find locally installed BINARY.

Return full path to the BINARY or nil if not found.

If USE-GLOBAL is non-nil, try to locate globally installed binary
of the same name."
  (if-let ((root (locate-dominating-file default-directory "node_modules"))
           (executable (concat root "node_modules/.bin/" binary)))
      executable
    (when use-global
      (executable-find binary))))

(eval-when-compile
  (defvar company-flow-executable)
  (defvar lsp-clients-flow-server)
  (defvar flow-minor-default-binary)
  (defvar flycheck-javascript-flow-executable)
  (defvar flycheck-javascript-flow-coverage-executable))

(defun find-local-executable-nodejs-setup-flow ()
  "Setup paths to flow executable for current buffer"
  (let ((executable (find-local-executable-nodejs "flow")))
    (setq-local company-flow-executable executable)
    (setq-local lsp-clients-flow-server executable)
    (setq-local flow-minor-default-binary executable)
    (setq-local flycheck-javascript-flow-executable executable)
    (setq-local flycheck-javascript-flow-coverage-executable executable)))

(provide 'find-local-executable)
;;; find-local-executable.el ends here
