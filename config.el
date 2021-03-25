;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Steve Sujo"
      user-mail-address "stevesp2013")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
 (setq doom-font (font-spec :family "hasklig" :size 17 :weight 'regular)
       doom-variable-pitch-font (font-spec :family "sans" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-city-lights)
(delq! t custom-theme-load-path)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               ORG-Mode              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/Org_Data")
(setq org-roam-directory "~/Projects/Org_Data/Org-roam")
;; (setq org-agenda-files "~/Projects/Org_Data")
(add-hook 'after-init-hook 'org-roam-mode)

;(use-package org-roam-server
;  :ensure t
;  :config
;  (setq org-roam-server-host "127.0.0.1"
;        org-roam-server-port 8080
;        org-roam-server-authenticate nil
;        org-roam-server-export-inline-images t
;        org-roam-server-serve-files nil
;        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
;        org-roam-server-network-poll t
;        org-roam-server-network-arrows nil
;        org-roam-server-network-label-truncate t
;        org-roam-server-network-label-truncate-length 60
;        org-roam-server-network-label-wrap-length 20))

(after! org
  (setq org-log-done 'time))

                                        ;ORG-Mode;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(custom-set-faces!
  '(doom-modeline-buffer-modified :foreground "orange"))



(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, so only show the modeline when this is not the case"
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)




(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")



(custom-set-faces! '(doom-modeline-evil-insert-state :weight bold :foreground "#339CDB"))





(map! :n [mouse-8] #'better-jumper-jump-backward
      :n [mouse-9] #'better-jumper-jump-forward)




(setq frame-title-format
      '(""
        (:eval
         (if (s-contains-p org-roam-directory (or buffer-file-name ""))
             (replace-regexp-in-string ".*/[0-9]*-?" "🢔 " buffer-file-name)
           "%b"))
        (:eval
         (let ((project-name (projectile-project-name)))
           (unless (string= "-" project-name)
             (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))



(setq fancy-splash-image "~/images/Skull2.png")


;; (defvar fancy-splash-image-template
;;   (expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines.svg" doom-private-dir)
;;   "Default template svg used for the splash image, with substitutions from ")
;; (defvar fancy-splash-image-nil
;;   (expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/transparent-pixel.png" doom-private-dir)
;;   "An image to use at minimum size, usually a transparent pixel")

;; (setq fancy-splash-sizes
;;       `((:height 500 :min-height 50 :padding (0 . 4) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-0.svg" doom-private-dir))
;;         (:height 440 :min-height 42 :padding (1 . 4) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-1.svg" doom-private-dir))
;;         (:height 400 :min-height 38 :padding (1 . 4) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-2.svg" doom-private-dir))
;;         (:height 350 :min-height 36 :padding (1 . 3) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-3.svg" doom-private-dir))
;;         (:height 300 :min-height 34 :padding (1 . 3) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-4.svg" doom-private-dir))
;;         (:height 250 :min-height 32 :padding (1 . 2) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-5.svg" doom-private-dir))
;;         (:height 200 :min-height 30 :padding (1 . 2) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/blackhole-lines-6.svg" doom-private-dir))
;;         (:height 100 :min-height 24 :padding (1 . 2) :template ,(expand-file-name "/home/steve/Downloads/emacs-config-master/misc/splash-images/emacs-e-template.svg" doom-private-dir))
;;         (:height 0   :min-height 0  :padding (0 . 0) :file ,fancy-splash-image-nil)))

;; (defvar fancy-splash-sizes
;;   `((:height 500 :min-height 50 :padding (0 . 2))
;;     (:height 440 :min-height 42 :padding (1 . 4))
;;     (:height 330 :min-height 35 :padding (1 . 3))
;;     (:height 200 :min-height 30 :padding (1 . 2))
;;     (:height 0   :min-height 0  :padding (0 . 0) :file ,fancy-splash-image-nil))
;;   "list of plists with the following properties
;;   :height the height of the image
;;   :min-height minimum `frame-height' for image
;;   :padding `+doom-dashboard-banner-padding' to apply
;;   :template non-default template file
;;   :file file to use instead of template")

;; (defvar fancy-splash-template-colours
;;   '(("$colour1" . keywords) ("$colour2" . type) ("$colour3" . base5) ("$colour4" . base8))
;;   "list of colour-replacement alists of the form (\"$placeholder\" . 'theme-colour) which applied the template")

;; (unless (file-exists-p (expand-file-name "theme-splashes" doom-cache-dir))
;;   (make-directory (expand-file-name "theme-splashes" doom-cache-dir) t))

;; (defun fancy-splash-filename (theme-name height)
;;   (expand-file-name (concat (file-name-as-directory "theme-splashes")
;;                             theme-name
;;                             "-" (number-to-string height) ".svg")
;;                     doom-cache-dir))

;; (defun fancy-splash-clear-cache ()
;;   "Delete all cached fancy splash images"
;;   (interactive)
;;   (delete-directory (expand-file-name "theme-splashes" doom-cache-dir) t)
;;   (message "Cache cleared!"))

;; (defun fancy-splash-generate-image (template height)
;;   "Read TEMPLATE and create an image if HEIGHT with colour substitutions as
;;    described by `fancy-splash-template-colours' for the current theme"
;;   (with-temp-buffer
;;     (insert-file-contents template)
;;     (re-search-forward "$height" nil t)
;;     (replace-match (number-to-string height) nil nil)
;;     (dolist (substitution fancy-splash-template-colours)
;;       (goto-char (point-min))
;;       (while (re-search-forward (car substitution) nil t)
;;         (replace-match (doom-color (cdr substitution)) nil nil)))
;;     (write-region nil nil
;;                   (fancy-splash-filename (symbol-name doom-theme) height) nil nil)))

;; (defun fancy-splash-generate-images ()
;;   "Perform `fancy-splash-generate-image' in bulk"
;;   (dolist (size fancy-splash-sizes)
;;     (unless (plist-get size :file)
;;       (fancy-splash-generate-image (or (plist-get size :file)
;;                                        (plist-get size :template)
;;                                        fancy-splash-image-template)
;;                                    (plist-get size :height)))))

;; (defun ensure-theme-splash-images-exist (&optional height)
;;   (unless (file-exists-p (fancy-splash-filename
;;                           (symbol-name doom-theme)
;;                           (or height
;;                               (plist-get (car fancy-splash-sizes) :height))))
;;     (fancy-splash-generate-images)))

;; (defun get-appropriate-splash ()
;;   (let ((height (frame-height)))
;;     (cl-some (lambda (size) (when (>= height (plist-get size :min-height)) size))
;;              fancy-splash-sizes)))

;; (setq fancy-splash-last-size nil)
;; (setq fancy-splash-last-theme nil)
;; (defun set-appropriate-splash (&rest _)
;;   (let ((appropriate-image (get-appropriate-splash)))
;;     (unless (and (equal appropriate-image fancy-splash-last-size)
;;                  (equal doom-theme fancy-splash-last-theme)))
;;     (unless (plist-get appropriate-image :file)
;;       (ensure-theme-splash-images-exist (plist-get appropriate-image :height)))
;;     (setq fancy-splash-image
;;           (or (plist-get appropriate-image :file)
;;               (fancy-splash-filename (symbol-name doom-theme) (plist-get appropriate-image :height))))
;;     (setq +doom-dashboard-banner-padding (plist-get appropriate-image :padding))
;;     (setq fancy-splash-last-size appropriate-image)
;;     (setq fancy-splash-last-theme doom-theme)
;;     (+doom-dashboard-reload)))

;; (add-hook 'window-size-change-functions #'set-appropriate-splash)
;; (add-hook 'doom-load-theme-hook #'set-appropriate-splash)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! company
  (setq company-minimum-prefix-length 2
        company-quickhelp-delay nil
        company-show-numbers t
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        ))

(use-package! company-lsp
  :after lsp-mode
  :config
  (setq company-transformers nil company-lsp-cache-candidates nil)
  (set-company-backend! 'lsp-mode 'company-lsp)
  )

(after! flycheck
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  (global-flycheck-mode -1)
  )

;; LSP-UI
;;https://github.com/MaskRay/Config
(use-package! lsp-ui
  ;:load-path "~/Dev/Emacs/lsp-ui"
  :commands lsp-ui-mode
  :config
  (setq
   ;; Disable sideline hints
   lsp-ui-sideline-enable nil
   lsp-ui-sideline-ignore-duplicate t
   ;; Disable imenu
   lsp-ui-imenu-enable nil
   ;; Disable ui-doc (already present in minibuffer)
   lsp-ui-doc-enable nil
   lsp-ui-doc-header nil
   lsp-ui-doc-include-signature nil
   lsp-ui-doc-background (doom-color 'base4)
   lsp-ui-doc-border (doom-color 'fg)
   ;; Enable ui-peek
   lsp-ui-peek-enable t
   ;lsp-ui-peek-fontify t
   lsp-ui-peek-always-show t
   lsp-ui-peek-force-fontify nil
   lsp-ui-peek-expand-function (lambda (xs) (mapcar #'car xs))
   ;; Flycheck
   lsp-ui-flycheck-enable t
   ))

  (custom-set-faces
   '(ccls-sem-global-variable-face ((t (:underline t :weight extra-bold))))
   '(lsp-face-highlight-read ((t (:background "sea green"))))
   '(lsp-face-highlight-write ((t (:background "brown4"))))
   ;; '(lsp-ui-peek-peek ((t (:background "sea green"))))
   ;; '(lsp-ui-peek-list ((t (:background "deep sky blue"))))
   '(lsp-ui-peek-highlight ((t (:background "deep sky blue"))))
   '(lsp-ui-sideline-current-symbol ((t (:foreground "grey38" :box nil))))
   '(lsp-ui-sideline-symbol ((t (:foreground "grey30" :box nil)))))

   ;; (map! :after lsp-ui-peek
   ;;       :map lsp-ui-peek-mode-map
   ;;       "h" #'lsp-ui-peek--select-prev-file
   ;;       "j" #'lsp-ui-peek--select-next
   ;;       "k" #'lsp-ui-peek--select-prev
   ;;       "l" #'lsp-ui-peek--select-next-file
   ;;       )

  ;; Slightly modified hydra version of original evil version from:
  ;; https://github.com/MaskRay/Config/blob/master/home/.config/doom/config.el
;  (defhydra +mr/lsp-traverse-hydra (:hint nil)
;  "Traverse references"
;  ("d" lsp-ui-peek-find-definitions "next" :bind nil)
;  ("n" (-let [(i . n) (lsp-ui-find-next-reference)]
;         (if (> n 0) (message "%d/%d" (+ i 1) n))) "next")
;  ("p" (-let [(i . n) (lsp-ui-find-prev-reference)]
;         (if (> n 0) (message "%d/%d" (+ i 1) n))) "prev")
;  ("R" (-let [(i . n) (lsp-ui-find-prev-reference '(:role 8))]
;         (if (> n 0) (message "read %d/%d" (+ i 1) n))) "prev read" :bind nil)
;  ("r" (-let [(i . n) (lsp-ui-find-next-reference '(:role 8))]
;         (if (> n 0) (message "read %d/%d" (+ i 1) n))) "next read" :bind nil)
;  ("W" (-let [(i . n) (lsp-ui-find-prev-reference '(:role 16))]
;         (if (> n 0) (message "write %d/%d" (+ i 1) n))) "prev write" :bind nil)
;  ("w" (-let [(i . n) (lsp-ui-find-next-reference '(:role 16))]
;         (if (> n 0) (message "write %d/%d" (+ i 1) n))) "next write" :bind nil)
;  ("q" nil "stop")
;  )
;)

;; LSP-Mode
(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-auto-guess-root t lsp-eldoc-prefer-signature-help nil)
  (setq lsp-enable-links nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-keep-workspace-alive nil)
  (add-to-list 'lsp-file-watch-ignored "build")
  ;; (setq lsp-project-blacklist '("/CC/"))
  )

;; LSP-Company
(use-package! company-lsp
  ;:load-path "~/Dev/Emacs/company-lsp"
  :after lsp-mode
  :config
  (setq company-transformers nil company-lsp-cache-candidates nil)
  (set-company-backend! 'lsp-mode 'company-lsp)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CCLS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;###autoload
(defvar +ccls-path-mappings [])

;;;###autoload
(defvar +ccls-initial-blacklist [])

;;;###autoload
(defvar +lsp-blacklist nil)

;;;###autoload
(defvar +my-use-eglot 't)

;;;###autoload
(defun +ccls|enable ()
  (when (and buffer-file-name (--all? (not (string-match-p it buffer-file-name)) +lsp-blacklist))
    (require 'ccls)
    (setq-local lsp-ui-sideline-show-symbol nil)
    (when (string-match-p "/llvm" buffer-file-name)
      (setq-local lsp-enable-file-watchers nil))
    (if +my-use-eglot (call-interactively #'eglot) (lsp))))

(defun +my|toggle-eglot ()
  (interactive)
  (setq +my-use-eglot (not +my-use-eglot))
  (message "use: %s" (if +my-use-eglot "eglot" "lsp-mode")))

(defun ccls/callee ()
  (interactive)
  (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
(defun ccls/caller ()
  (interactive)
  (lsp-ui-peek-find-custom "$ccls/call"))
(defun ccls/vars (kind)
  (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
(defun ccls/base (levels)
  (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
(defun ccls/derived (levels)
  (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
(defun ccls/member (kind)
  (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

;; The meaning of :role corresponds to https://github.com/maskray/ccls/blob/master/src/symbol.h

;; References w/ Role::Address bit (e.g. variables explicitly being taken addresses)
(defun ccls/references-address ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 128)))

;; References w/ Role::Dynamic bit (macro expansions)
(defun ccls/references-macro ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 64)))

;; References w/o Role::Call bit (e.g. where functions are taken addresses)
(defun ccls/references-not-call ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :excludeRole 32)))

;; References w/ Role::Read
(defun ccls/references-read ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 8)))

;; References w/ Role::Write
(defun ccls/references-write ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
   (plist-put (lsp--text-document-position-params) :role 16)))

(use-package! ccls
  ;:load-path "~/Dev/Emacs/emacs-ccls"
  :hook ((c-mode-local-vars c++-mode-local-vars objc-mode-local-vars) . +ccls|enable)
  :config
  ;; overlay is slow
  ;; Use https://github.com/emacs-mirror/emacs/commits/feature/noverlay
  (setq ccls-sem-highlight-method 'font-lock)
  (add-hook 'lsp-after-open-hook #'ccls-code-lens-mode)
  (ccls-use-default-rainbow-sem-highlight)
  ;; https://github.com/maskray/ccls/blob/master/src/config.h
  (setq
   ccls-initialization-options
   `(:clang
     (:excludeArgs
      ;; Linux's gcc options. See ccls/wiki
      ["-falign-jumps=1" "-falign-loops=1" "-fconserve-stack" "-fmerge-constants" "-fno-code-hoisting" "-fno-schedule-insns" "-fno-var-tracking-assignments" "-fsched-pressure"
       "-mhard-float" "-mindirect-branch-register" "-mindirect-branch=thunk-inline" "-mpreferred-stack-boundary=2" "-mpreferred-stack-boundary=3" "-mpreferred-stack-boundary=4" "-mrecord-mcount" "-mindirect-branch=thunk-extern" "-mno-fp-ret-in-387" "-mskip-rax-setup"
       "--param=allow-store-data-races=0" "-Wa arch/x86/kernel/macros.s" "-Wa -"]
      :extraArgs []
      :pathMappings ,+ccls-path-mappings)
     :completion
     (:include
      (:blacklist
       ["^/usr/(local/)?include/c\\+\\+/[0-9\\.]+/(bits|tr1|tr2|profile|ext|debug)/"
        "^/usr/(local/)?include/c\\+\\+/v1/"
        ]))
     :index (:initialBlacklist ,+ccls-initial-blacklist :parametersInDeclarations :json-false :trackDependency 1)))

  (after! projectile
   (add-to-list 'projectile-globally-ignored-directories ".ccls-cache"))
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;           Code Formatting;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! c++-mode
  (set-formatter! 'c++-mode 'clang-format)
  )

;;Gramar

(setq langtool-language-tool-jar "/home/steve/Downloads/LanguageTool-5.1/languagetool-commandline.jar")
(require 'langtool)
