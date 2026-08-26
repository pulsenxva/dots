(setq org-directory "~/org/")
(setq org-agenda-files '("~/org"))

(setq org-startup-indented t)
(setq org-log-done 'time)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "WAIT(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCEL(c)")))

(setq org-agenda-skip-deadline-prewarning-if-scheduled t)

(evil-define-key 'normal org-mode-map
  (kbd "<tab>") #'org-cycle
  (kbd "TAB")   #'org-cycle
  (kbd "S-TAB") #'org-shifttab)

(setq doom-theme 'doom-gruvbox)

(add-to-list 'default-frame-alist '(width . 120))
(add-to-list 'default-frame-alist '(height . 45))
(setq-default tab-width 2)
(after! org
  (setq org-startup-indented nil))
