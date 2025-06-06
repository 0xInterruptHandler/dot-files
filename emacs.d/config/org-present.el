;; config/org-present.el

(use-package visual-fill-column
  :hook (org-present-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t))

(use-package org-present
  :after org
  :hook
  ((org-present-mode . my/org-present-start)
   (org-present-mode-quit . my/org-present-end)
   (org-present-after-navigate-functions . my/org-present-prepare-slide))
  :config
  (defun my/org-present-prepare-slide (buffer-name heading)
    (org-overview)
    (org-show-entry)
    (org-show-children))

  (defun my/org-present-start ()
    ;; Habilitar centrado visual
    (visual-fill-column-mode 1)
    (setq-local face-remapping-alist
                '((default (:height 1.5) variable-pitch)
                  (header-line (:height 4.0) variable-pitch)
                  (org-document-title (:height 1.75) org-document-title)
                  (org-code (:height 1.55) org-code)
                  (org-verbatim (:height 1.55) org-verbatim)
                  (org-block (:height 1.25) org-block)
                  (org-block-begin-line (:height 0.7) org-block)))
    (setq header-line-format " ")
    (org-display-inline-images)
    (visual-line-mode 1))

  (defun my/org-present-end ()
    (setq-local face-remapping-alist '((default variable-pitch default)))
    (setq header-line-format nil)
    (org-remove-inline-images)
    (visual-fill-column-mode 0)
    (visual-line-mode 0)))

