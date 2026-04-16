;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Your Name"
      user-mail-address "your.email@example.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Org-roam settings
(setq org-roam-directory (expand-file-name "roam/" org-directory)
      org-journal-dir (expand-file-name "journal/" org-directory))

;; Org-mode appearance settings
(after! org
  (setq org-hide-emphasis-markers t
        org-hide-leading-stars t
        org-startup-indented t
        org-pretty-entities t
        org-pretty-entities-include-sub-superscripts t
        org-adapt-indentation nil
        org-special-ctrl-a/e t
        org-special-ctrl-k t
        org-loop-over-headlines-in-active-region 'start-level
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t))

;; TODO states configuration
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(p)" "|" "DONE(d)" "CANCELLED(c)")))

;; Deadlines and scheduling settings
(setq org-deadline-warning-days 7
      org-scheduled-delay-days 0
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t)

;; Capture templates
(setq org-capture-templates
      '(("t" "Task" entry
         (file+headline "~/org/tasks.org" "Tasks")
         "* TODO %?\nDEADLINE: %^t\n")

        ("h" "Homework" entry
         (file+headline "~/org/courses.org" "homework")
         "* TODO %^{Course name|4150|4480|5460} %^{Assignment name}\nDEADLINE: %^t\n")

        ("l" "Lecture" entry
         (file+headline "~/org/courses.org" "schedule")
         "* TODO %^{Course name} lecture\nSCHEDULED: %^t\n:PROPERTIES:\n:Location: %^{Location|web L101|web L102}\n:END:\n")

        ("p" "Course properties" entry
         (file+headline "~/org/courses.org" "properties")
         "* %^{Course name}\n:PROPERTIES:\n:teacher: %^{Teacher}\n:textbook: %^{Textbook}\n:location: %^{Location}\n:website: %^{Website}\n:END:\n")

        ("n" "Note" entry
         (file+headline "~/org/notes.org" "Notes")
         "* %^{Title}\n%?")))

;; Org-roam configuration
(after! org-roam
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+date: %U\n")
           :unnarrowed t)
          ("c" "course" plain "* ${title}\n** Properties\n:PROPERTIES:\n:teacher: \n:textbook: \n:location: \n:website: \n:END:\n** Notes\n** Homework\n** Schedule\n%?"
           :target (file+head "courses/${slug}.org"
                              "#+title: ${title}\n#+filetags: :course:\n")
           :unnarrowed t))))

;; Journal settings
(after! org-journal
  (setq org-journal-enable-agenda-integration t
        org-journal-date-format "%A, %d %B %Y"
        org-journal-file-format "%Y-%m-%d.org"))

;; Agenda configuration
(setq org-agenda-files (list org-directory)
      org-agenda-start-with-log-mode t
      org-agenda-start-day "+0"
      org-agenda-span 14)

;; Keybindings for org-mode
(map! :map org-mode-map
      :localleader
      :desc "Insert link" "l l" #'org-insert-link
      :desc "Insert deadline" "d d" #'org-deadline
      :desc "Insert schedule" "s s" #'org-schedule
      :desc "Mark TODO" "t t" #'org-todo
      :desc "Mark DONE" "t d" (λ! (org-todo "DONE"))
      :desc "Properties" "p p" #'org-set-property
      :desc "Capture" "c" #'org-capture)

;; Your existing settings
(setq compile-command "g++ -std=c++20 -O2 -Wall -Wextra main.cpp -o main && ./main")
(map! :leader
      :desc "Toggle vterm"
      "t t" #'+vterm/toggle)
