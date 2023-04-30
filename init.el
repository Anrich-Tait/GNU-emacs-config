(setq inhibit-startup-message t)

;;(load-theme 'doom-dracula t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'auto-fill-mode)

;; Set up the visible bell (flash when you reach the end of a buffer)
(setq visible-bell t)

(set-face-attribute 'default nil :font "SFMono" :height 120) ;;set fonts


;; Make ESC quit prompts (so if you enter a command wrong just spam 'esc'
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources (chooses which websites you can download packages from)
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                                              ("org" . "https://orgmode.org/elpa/")
                                              ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package) ;;installs the package that installs all the other packages
(setq use-package-always-ensure t)

;; PACKAGE IVY--------------------------For nice completion------------------------------------------------
(use-package ivy
  :diminish
  :bind (("C-s" . swiper) ;; lets you search for keywords in a file
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;;DOOM MODELINE-------------------add fancy bar at the bottom--------------------------------------------------------
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom (
	   ;; If non-nil, cause imenu to see `doom-modeline' declarations.
	   ;; This is done by adjusting `lisp-imenu-generic-expression' to
	   ;; include support for finding `doom-modeline-def-*' forms.
	   ;; Must be set before loading doom-modeline.
	   (setq doom-modeline-support-imenu t)

	   ;; How tall the mode-line should be. It's only respected in GUI.
	   ;; If the actual char height is larger, it respects the actual height.
	   (setq doom-modeline-height 25)

	   ;; How wide the mode-line bar should be. It's only respected in GUI.
	   (setq doom-modeline-bar-width 4)

	   ;; Whether to use hud instead of default bar. It's only respected in GUI.
	   (setq doom-modeline-hud nil)


	   ;; If `window-width' is smaller than the limit, some information won't be
	   ;; displayed. It can be an integer or a float number. `nil' means no limit."
	   (setq doom-modeline-window-width-limit 85)

	   ;; How to detect the project root.
	   ;; nil means to use `default-directory'.
	   ;; The project management packages have some issues on detecting project root.
	   ;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
	   ;; to hanle sub-projects.
	   ;; You can specify one if you encounter the issue.
	   (setq doom-modeline-project-detection 'auto)

	   ;; Determines the style used by `doom-modeline-buffer-file-name'.
	   
	   ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
	   ;;   auto => emacs/l/comint.el (in a project) or comint.el
	   ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
	   ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
	   ;;   truncate-with-project => emacs/l/comint.el
	   ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
	   ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
	   ;;   truncate-all => ~/P/F/e/l/comint.el
	   ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
	   ;;   relative-from-project => emacs/lisp/comint.el
	   ;;   relative-to-project => lisp/comint.el
	   ;;   file-name => comint.el
	   ;;   buffer-name => comint.el<2> (uniquify buffer name)
	   ;;
	   ;; If you are experiencing the laggy issue, especially while editing remote files
	   ;; with tramp, please try `file-name' style.
	   ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
	   (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

	   ;; Whether display icons in the mode-line.
	   ;; While using the server mode in GUI, should set the value explicitly.
	   (setq doom-modeline-icon t)

	   ;; Whether display the icon for `major-mode'. It respects `doom-modeline-icon'.
	   (setq doom-modeline-major-mode-icon t)

	   ;; Whether display the colorful icon for `major-mode'.
	   ;; It respects `all-the-icons-color-icons'.
	   (setq doom-modeline-major-mode-color-icon t)

	   ;; Whether display the icon for the buffer state. It respects `doom-modeline-icon'.
	   (setq doom-modeline-buffer-state-icon t)

	   ;; Whether display the modification icon for the buffer.
	   ;; It respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
	   (setq doom-modeline-buffer-modification-icon t)

	   ;; Whether display the time icon. It respects variable `doom-modeline-icon'.
	   (setq doom-modeline-time-icon t)

	   ;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
	   (setq doom-modeline-unicode-fallback nil)

	   ;; Whether display the buffer name.
	   (setq doom-modeline-buffer-name t)

	   ;; Whether highlight the modified buffer name.
	   (setq doom-modeline-highlight-modified-buffer-name t)

	   ;; Whether display the minor modes in the mode-line.
	   (setq doom-modeline-minor-modes nil)

	   ;; If non-nil, a word count will be added to the selection-info modeline segment.
	   (setq doom-modeline-enable-word-count nil)

	   ;; Major modes in which to display word count continuously.
	   ;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
	   ;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
	   ;; remove the modes from `doom-modeline-continuous-word-count-modes'.
	   (setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

	   ;; Whether display the buffer encoding.
	   (setq doom-modeline-buffer-encoding t)

	   ;; Whether display the indentation information.
	   (setq doom-modeline-indent-info nil)

	   ;; If non-nil, only display one number for checker information if applicable.
	   (setq doom-modeline-checker-simple-format t)

	   ;; The maximum number displayed for notifications.
	   (setq doom-modeline-number-limit 99)

	   ;; The maximum displayed length of the branch name of version control.
	   (setq doom-modeline-vcs-max-length 12)

	   ;; Whether display the workspace name. Non-nil to display in the mode-line.
	   (setq doom-modeline-workspace-name t)

	   ;; Whether display the perspective name. Non-nil to display in the mode-line.
	   (setq doom-modeline-persp-name t)

	   ;; If non nil the default perspective name is displayed in the mode-line.
	   (setq doom-modeline-display-default-persp-name nil)

	   ;; If non nil the perspective name is displayed alongside a folder icon.
	   (setq doom-modeline-persp-icon t)

	   ;; Whether display the `lsp' state. Non-nil to display in the mode-line.
	   (setq doom-modeline-lsp t)

	   ;; Whether display the GitHub notifications. It requires `ghub' package.
	   (setq doom-modeline-github nil)

	   ;; The interval of checking GitHub.
	   (setq doom-modeline-github-interval (* 30 60))

	   ;; Whether display the modal state.
	   ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
	   (setq doom-modeline-modal t)

	   ;; Whether display the modal state icon.
	   ;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
	   (setq doom-modeline-modal-icon t)

	   ;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
	   (setq doom-modeline-mu4e nil)
	   ;; also enable the start of mu4e-alert
	   (mu4e-alert-enable-mode-line-display)

	   ;; Whether display the gnus notifications.
	   (setq doom-modeline-gnus t)

	   ;; Whether gnus should automatically be updated and how often (set to 0 or smaller than 0 to disable)
	   (setq doom-modeline-gnus-timer 2)

	   ;; Wheter groups should be excludede when gnus automatically being updated.
	   (setq doom-modeline-gnus-excluded-groups '("dummy.group"))

	   ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
	   (setq doom-modeline-irc t)

	   ;; Function to stylize the irc buffer names.
	   (setq doom-modeline-irc-stylize 'identity)

	   ;; Whether display the battery status. It respects `display-battery-mode'.
	   (setq doom-modeline-battery f)

	   ;; Whether display the time. It respects `display-time-mode'.
	   (setq doom-modeline-time f)

	   ;; Whether display the misc segment on all mode lines.
	   ;; If nil, display only if the mode line is active.
	   (setq doom-modeline-display-misc-in-all-mode-lines t)

	   ;; Whether display the environment version.
	   (setq doom-modeline-env-version t)
	   ;; Or for individual languages
	   (setq doom-modeline-env-enable-python t)
	   (setq doom-modeline-env-enable-ruby t)
	   (setq doom-modeline-env-enable-perl t)
	   (setq doom-modeline-env-enable-go t)
	   (setq doom-modeline-env-enable-elixir t)
	   (setq doom-modeline-env-enable-rust t)

	   ;; Change the executables to use for the language version string
	   (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
	   (setq doom-modeline-env-ruby-executable "ruby")
	   (setq doom-modeline-env-perl-executable "perl")
	   (setq doom-modeline-env-go-executable "go")
	   (setq doom-modeline-env-elixir-executable "iex")
	   (setq doom-modeline-env-rust-executable "rustc")

	   ;; What to display as the version while a new one is being loaded
	   (setq doom-modeline-env-load-string "...")

	   ;; By default, almost all segments are displayed only in the active window. To
	   ;; display such segments in all windows, specify e.g.
	   (setq doom-modeline-always-visible-segments '(mu4e irc))

	   ;; Hooks that run before/after the modeline version string is updated
	   (setq doom-modeline-before-update-env-hook nil)
	   (setq doom-modeline-after-update-env-hook nil)))

;; ADD LINE NUMBERS------------------------------------------------------------------------------------
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
		         term-mode-hook
		         eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "42f2e68ab2f7d812bca764a78097a8dc890efb7e45cab58180968c7b346f603f" "ae442f0541b4238a29b05697c423ecd6d4b2300995c34d3ebabfb99f219691bb" "3e00289b73bac18bc5fbc26660a02a14c32ee3cae8499878c6ba7aab95ccddc6" "bfc0b9c3de0382e452a878a1fb4726e1302bf9da20e69d6ec1cd1d5d82f61e3d" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" "fe1c13d75398b1c8fd7fdd1241a55c286b86c3e4ce513c4292d01383de152cb7" default))
 '(helm-minibuffer-history-key "M-p")
 '(org-agenda-files nil)
 '(package-selected-packages
   '(samantha-os-theme modus-themes autothemer latex-preview-pane auctex indent-guide dashboard sublimity writeroom-mode zen-mode dired-hide-dotfiles dired-open all-the-icons-dired dired-single vterm eterm-256color eglot company-box lsp-ivy lsp-treemacs lsp-ui company typescript-mode lsp-mode visual-fill-column org-bullets evil-magit magit counsel-projectile beacon projectile hydra general doom-themes all-the-icons helpful counsel ivy-rich which-key rainbow-delimiters use-package ivy dracula-theme doom-modeline command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; RAINBOW DELIMITERS------------------------------------------------------------------------------------
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; WHICH KEY-----------------------------------------------------------------------------------------------
(use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode
    :config
    (setq which-key-idle-delay 1))
;; Use C-h to use package or C-x

;; IVY RICH----------------------------------------------------------------------------------------------
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;;COUNSEL------------------------------------------------------------------------------------------------
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

;; HELPFUL-----------------------------------------------------------------------------------------------
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; NOTE: The first time you load your configuration on a new machine, you'll
;; need to run the following command interactively so that mode line icons
;; display correctly:
;;
;; M-x all-the-icons-install-fonts
(use-package all-the-icons)

;; KEYBINDINGS + GENERAL EL
(use-package general
  :config
  (general-create-definer noot/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (noot/leader-keys
    "t" '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

;; EVIL MODE
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; HYDRA
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(noot/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

;; Projectile--------------------------------------------------------------------------------------
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; BEACON--------------------------------------
(use-package beacon)
(beacon-mode 1)

;; MAGIT----------------------------------------------------------------------------------------------
(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; ORG MODE------------------------------------------------------------------------------------------

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
	'("/home/anricht/Projects/Org/Tasks.org"
	  "~/Projects/Org/Projects.org"
	  ;;"~/Projects/Code/emacs-from-scratch/OrgFiles/Birthdays.org"
	  ))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Projects/Org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (efs/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (C t)))

(setq org-confirm-babel-evaluate nil)

;; LANGUAGES------------------------------------------------------------------------------------
(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy)

;; Typescript mode
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

;; C/C++ mode---------------------------------------------------------------------
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; Python mode


;; COMPLETIONS WITH COMPANY MODE
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

;; TERMINAL STUFF-----------------------------------------------------------------------------------------
(use-package term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

;;DIRED
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; Auto update packages--------------------------------------------------------------
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe))
  (auto-package-update-at-time "09:00")

;; ZEN MODE--------------------------------------------------------------------------------
(use-package writeroom-mode)


;;Sublimity (TODO)
;;(use-package sublimity
;;  :custom
;;  (setq sublimity-scroll-weight 10
;;      sublimity-scroll-drift-length 5))
;;(require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map) ;; experimental
;;(require 'sublimity-attractive)
;;(sublimity-mode 1)
;;(setq sublimity-map-size 20)
;;(setq sublimity-map-fraction 0.3)
;;(setq sublimity-map-text-scale -7)

;; DASHBOARD-------------------------------------------------------------------------------
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  ;; Set the title
(setq dashboard-banner-logo-title "Welcome to Noot Emacs!")
;; Set the banner
(setq dashboard-startup-banner 'official)
;; Value can be
;; - nil to display no banner
;; - 'official which displays the official emacs logo
;; - 'logo which displays an alternative emacs logo
;; - 1, 2 or 3 which displays one of the text banners
;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")

;; Content is not centered by default. To center, set
(setq dashboard-center-content nil)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents  . 5)
                        ;;(bookmarks . 5)
                        (projects . 5)
                        ;;(agenda . 5)
			))

;;To add icons to the widget headings and their items:
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;;To show navigator below the banner:
(setq dashboard-set-navigator t)

;;To show info about the packages loaded and the init time:
(setq dashboard-set-init-info t)

;;Also, the message can be customized like this:
(setq dashboard-init-info "Checkout my GitHub: https://github.com/Anrich-Tait")

;;A randomly selected footnote will be displayed. To disable it:
(setq dashboard-set-footer t)

(setq dashboard-footer-messages '("The only easy day was yesterday."))
(setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                   :height 1.1
                                                   :v-adjust -0.05
                                                   :face
						   'font-lock-keyword-face))

;; To use it with counsel-projectile:
(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)
;;To display today’s agenda items on the dashboard, add agenda to dashboard-items:
(add-to-list 'dashboard-items '(agenda) t)

;;To show agenda for the upcoming seven days set the variable dashboard-week-agenda to t.
(setq dashboard-week-agenda t)

;;By default org-agenda entries are filter by time, only showing those task with DEADLINE, SCHEDULE-TIME or TIMESTAMP . To show all agenda entries (except DONE)
(setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
)

;; INDENT GUIDE
(require 'indent-guide)
(indent-guide-global-mode)

;; LATEX STUFF-------------------------------------------------------
(use-package tex
  :ensure auctex)

