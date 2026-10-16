{ config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        /* userChrome.css - minimal Nothing-style. Palette lives in :root. */

        :root {
          --nt-bg:     #000000;
          --nt-raised: #0d0d0d;
          --nt-hover:  #141414;
          --nt-fg:     #ffffff;
          --nt-dim:    #b3b3b3;
          --nt-line:   #262626;
          --nt-accent: #d71921;
          --nt-font:   "JetBrainsMono Nerd Font", monospace;

          --toolbar-bgcolor: var(--nt-bg) !important;
          --toolbar-color: var(--nt-fg) !important;
          --toolbar-field-background-color: var(--nt-bg) !important;
          --toolbar-field-color: var(--nt-fg) !important;
          --toolbar-field-border-color: var(--nt-line) !important;
          --toolbar-field-focus-background-color: #000000 !important;
          --toolbar-field-focus-color: var(--nt-fg) !important;
          --toolbar-field-focus-border-color: var(--nt-accent) !important;
          --lwt-accent-color: var(--nt-bg) !important;
          --lwt-text-color: var(--nt-fg) !important;
          --chrome-content-separator-color: var(--nt-line) !important;

          --sidebar-background-color: var(--nt-bg) !important;
          --sidebar-text-color: var(--nt-fg) !important;
          --sidebar-border-color: var(--nt-line) !important;

          --arrowpanel-background: var(--nt-bg) !important;
          --arrowpanel-color: var(--nt-fg) !important;
          --arrowpanel-border-color: var(--nt-line) !important;
          --panel-background: var(--nt-bg) !important;
          --panel-color: var(--nt-fg) !important;
          --panel-border-color: var(--nt-line) !important;
          --panel-separator-color: var(--nt-line) !important;
          --panel-description-color: var(--nt-dim) !important;
          --panel-banner-item-background-color: var(--nt-raised) !important;
          --menu-background-color: var(--nt-bg) !important;
          --menu-color: var(--nt-fg) !important;
          --menu-border-color: var(--nt-line) !important;
          --autocomplete-popup-background: var(--nt-bg) !important;
          --autocomplete-popup-color: var(--nt-fg) !important;
          --autocomplete-popup-border-color: var(--nt-line) !important;
          --autocomplete-popup-highlight-background: var(--nt-fg) !important;
          --autocomplete-popup-highlight-color: var(--nt-bg) !important;
          --urlbarView-highlight-background: var(--nt-fg) !important;
          --urlbarView-highlight-color: var(--nt-bg) !important;
          --urlbarView-hover-background: var(--nt-hover) !important;
          --urlbarView-separator-color: var(--nt-line) !important;
          --tooltip-bgcolor: var(--nt-bg) !important;
          --tooltip-color: var(--nt-fg) !important;
          --tooltip-border-color: var(--nt-line) !important;

          --button-bgcolor: var(--nt-raised) !important;
          --button-hover-bgcolor: var(--nt-hover) !important;
          --button-active-bgcolor: var(--nt-line) !important;
          --button-color: var(--nt-fg) !important;
          --toolbarbutton-hover-background: var(--nt-hover) !important;
          --toolbarbutton-active-background: var(--nt-line) !important;
          --toolbarbutton-icon-fill: var(--nt-dim) !important;
          --focus-outline-color: var(--nt-accent) !important;
          --focus-outline: 1px solid var(--nt-accent) !important;
        }

        * {
          border-radius: 0px !important;
          box-shadow: none !important;
          scrollbar-color: #3a3a3a transparent;
        }

        /* Tabs live in Sidebery */
        #TabsToolbar { display: none !important; }

        /* Sidebar: only Sidebery is ever visible */
        #sidebar-panel-header,
        #sidebar-header,
        #sidebar-button,
        #sidebar-main {
          display: none !important;
        }
        #sidebar-box { padding-inline-start: 0px !important; background: var(--nt-bg) !important; border-inline-end: 1px solid var(--nt-line) !important; }
        #sidebar-splitter { width: 1px !important; min-width: 1px !important; background: var(--nt-line) !important; border: none !important; }

        /* Hide any sidebar that is not Sidebery */
        #sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]),
        #sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]) + #sidebar-splitter {
          display: none !important;
        }

        /* Frame */
        #navigator-toolbox { background: var(--nt-bg) !important; border: none !important; }
        #nav-bar { background: var(--nt-bg) !important; border-bottom: 1px solid var(--nt-line) !important; }
        #PersonalToolbar { display: none !important; }
        #browser, #appcontent, #tabbrowser-tabbox, #tabbrowser-tabpanels { background: var(--nt-bg) !important; }
        findbar { background: var(--nt-bg) !important; color: var(--nt-fg) !important; border-top: 1px solid var(--nt-line) !important; }
        .findbar-textbox, findbar input {
          background-color: #000000 !important;
          color: #ffffff !important;
          border: 1px solid #262626 !important;
          outline: none !important;
        }
        .findbar-textbox:focus, findbar input:focus { border-color: #d71921 !important; }
        .findbar-textbox[status="notfound"] { background-color: #000000 !important; color: #d71921 !important; }
        .findbar-container, .findbar-find-status, .findbar-closebutton, findbar label, findbar checkbox { color: #e6e6e6 !important; }
        .findbar-button, findbar .findbar-find-previous, findbar .findbar-find-next {
          background: #0d0d0d !important;
          color: #ffffff !important;
          border: 1px solid #262626 !important;
        }
        .findbar-button:hover:not([disabled]), findbar toolbarbutton:hover:not([disabled]) { background: #141414 !important; }
        .findbar-button[checked], .findbar-button[checked="true"] { background: #ffffff !important; color: #000000 !important; }

        /* URL bar */
        #urlbar-background { background: var(--nt-bg) !important; border: 1px solid var(--nt-line) !important; }
        #urlbar, #urlbar * { font-family: var(--nt-font) !important; font-size: 12px !important; }
        #identity-box, #tracking-protection-icon-container,
        #page-action-buttons, #star-button-box { display: none !important; }

        /* URL bar dropdown */
        #urlbar-results, .urlbarView, .urlbarView-body-inner { background: var(--nt-bg) !important; color: var(--nt-fg) !important; }
        .urlbarView-row[selected] > .urlbarView-row-inner,
        .urlbarView-row:hover > .urlbarView-row-inner { background: var(--nt-fg) !important; color: var(--nt-bg) !important; }
        .urlbarView-row[selected] *, .urlbarView-row:hover * { color: var(--nt-bg) !important; fill: var(--nt-bg) !important; }

        /* Menus, hamburger, extension panel */
        menupopup, panel, .menupopup-arrowscrollbox, #appMenu-popup, .panel-arrowcontent, #unified-extensions-panel {
          background: var(--nt-bg) !important;
          color: var(--nt-fg) !important;
          border: 1px solid var(--nt-line) !important;
        }
        menuitem, menu, .subviewbutton, .panel-subview-body toolbarbutton { color: var(--nt-fg) !important; }
        menuitem[_moz-menuactive="true"], menu[_moz-menuactive="true"],
        .subviewbutton:hover:not([disabled]), .subviewbutton[_moz-menuactive] {
          background: var(--nt-fg) !important;
          color: var(--nt-bg) !important;
        }
        menuitem[_moz-menuactive="true"] *, menu[_moz-menuactive="true"] *,
        .subviewbutton:hover:not([disabled]) * { color: var(--nt-bg) !important; fill: var(--nt-bg) !important; }
        menuseparator, toolbarseparator { border-color: var(--nt-line) !important; background: var(--nt-line) !important; }

        /* Toolbar buttons */
        .toolbarbutton-1 { color: var(--nt-dim) !important; fill: var(--nt-dim) !important; }
        .toolbarbutton-1:hover { color: var(--nt-fg) !important; fill: var(--nt-fg) !important; background: transparent !important; }

        /* Popups */
        panel, menupopup, panelview, #urlbar, #searchbar {
          --panel-background: #000000 !important;
          --panel-color: #ffffff !important;
          --panel-border-color: #262626 !important;
          --panel-separator-color: #262626 !important;
          --panel-description-color: #b3b3b3 !important;
          --arrowpanel-background: #000000 !important;
          --arrowpanel-color: #ffffff !important;
          --arrowpanel-border-color: #262626 !important;
          --arrowpanel-dimmed: #141414 !important;
          --arrowpanel-dimmed-further: #1c1c1c !important;
          --arrowpanel-dimmed-even-further: #262626 !important;
          --button-hover-bgcolor: #141414 !important;
          --button-active-bgcolor: #1c1c1c !important;
          --menu-background-color: #000000 !important;
          --menu-color: #ffffff !important;
        }

        panel::part(content), menupopup::part(content) {
          background: #000000 !important;
          color: #ffffff !important;
          border: 1px solid #262626 !important;
        }

        panelview, .panel-subview-body, .panel-header, .panel-footer,
        #appMenu-mainView, #unified-extensions-view, .unified-extensions-item {
          background: #000000 !important;
          color: #ffffff !important;
        }
        .panel-header, .panel-footer { border-color: #262626 !important; }
        .unified-extensions-item:hover, .unified-extensions-item[_moz-menuactive] { background: #141414 !important; }

        /* Downloads panel */
        #downloadsPanel, #downloadsPanel-mainView, #downloadsListBox, #downloadsFooter, #downloadsHistory,
        #downloadsListBox > richlistitem {
          background: #000000 !important;
          color: #ffffff !important;
        }
        #downloadsListBox > richlistitem:hover,
        #downloadsListBox > richlistitem[selected] { background: #141414 !important; }

        /* Text: white for primary, light grey for secondary */
        panel label, panel description, panelview label, panelview description,
        menupopup label, menupopup description, menu, menuitem,
        .menu-text, .menu-iconic-text, .subviewbutton, .panel-header, .panel-footer,
        #downloadsListBox description, #downloadsListBox label {
          color: #e6e6e6 !important;
        }
        .menu-accel, .menu-accel-container, .panel-description, description.description-deemphasized,
        .downloadDetails, .downloadTarget + .downloadDetails {
          color: #b3b3b3 !important;
        }
        menuitem[disabled="true"], menu[disabled="true"], .subviewbutton[disabled="true"] {
          color: #6b6b6b !important;
        }

        /* URL bar specific tweaks */
        #urlbar {
          --toolbar-field-background-color: #000000 !important;
          --toolbar-field-focus-background-color: #000000 !important;
          --toolbar-field-color: #ffffff !important;
          --toolbar-field-focus-color: #ffffff !important;
          --toolbar-field-border-color: #262626 !important;
          --toolbar-field-focus-border-color: #d71921 !important;
          --urlbar-box-bgcolor: #000000 !important;
          --urlbar-box-hover-bgcolor: #141414 !important;
          --urlbar-box-focus-bgcolor: #000000 !important;
          --urlbar-box-active-bgcolor: #1c1c1c !important;
          --urlbar-box-text-color: #ffffff !important;
          --urlbarView-highlight-background: #ffffff !important;
          --urlbarView-highlight-color: #000000 !important;
          --urlbarView-hover-background: #141414 !important;
          --urlbarView-separator-color: #262626 !important;
        }
        #urlbar[focused] > #urlbar-background,
        #urlbar[open] > #urlbar-background,
        #urlbar[breakout][breakout-extend] > #urlbar-background,
        #urlbar:not([open])[focused] > #urlbar-background,
        #urlbar[focused][breakout][breakout-extend] > #urlbar-background {
          background: #000000 !important;
          border: 1px solid #d71921 !important;
          outline: none !important;
        }
        #urlbar[focused], #urlbar[open],
        #urlbar[focused] > #urlbar-background,
        #urlbar[focused] #urlbar-input-container,
        #urlbar[focused] .urlbar-input-container,
        #urlbar[open] #urlbar-input-container,
        #urlbar[focused] #urlbar-input,
        #searchbar[focused], #searchbar:focus-within {
          background-color: #000000 !important;
          background-image: none !important;
        }
        #urlbar-input, #urlbar .urlbar-input { color: #ffffff !important; caret-color: #d71921 !important; }
        #urlbar-input::placeholder { color: #b3b3b3 !important; opacity: 1 !important; }
        #urlbar-input::selection { background: #ffffff !important; color: #000000 !important; }

        .urlbarView-body-outer, .urlbarView-body-inner, .urlbarView-results,
        .search-one-offs, .search-panel-one-offs-container, .search-panel-one-offs {
          background: #000000 !important;
          color: #ffffff !important;
        }
        .urlbarView-row, .urlbarView-row-inner, .urlbarView-no-wrap {
          background: transparent !important;
          color: #e6e6e6 !important;
        }
        .urlbarView-title { color: #ffffff !important; }
        .urlbarView-url, .urlbarView-action, .urlbarView-secondary,
        .urlbarView-title-separator, .urlbarView-type-icon { color: #b3b3b3 !important; }
        #urlbar-searchmode-switcher, .searchmode-switcher-chicklet, #urlbar-label-box { color: #e6e6e6 !important; }

        #nav-bar-customization-target, #urlbar-container, #nav-bar toolbarspring, #nav-bar toolbarspacer,
        #nav-bar-overflow-button, #nav-bar-start, #nav-bar-end {
          background: #000000 !important;
        }
        .urlbarView, .urlbarView-body-outer, .urlbarView-results { scrollbar-color: #262626 #000000 !important; }

        /* Compact menus */
        :root { --nt-pad-y: 3px; --nt-pad-x: 10px; }

        panel, menupopup, panelview {
          --arrowpanel-padding: 4px !important;
          --arrowpanel-menuitem-padding: var(--nt-pad-y) var(--nt-pad-x) !important;
          --arrowpanel-menuitem-margin: 0 !important;
        }
        menupopup { padding: 2px 0 !important; }
        menuitem, menu {
          padding: var(--nt-pad-y) var(--nt-pad-x) !important;
          margin: 0 !important;
          min-height: 0 !important;
        }
        menuseparator, toolbarseparator { margin: 2px 0 !important; padding: 0 !important; }

        .subviewbutton, .panel-subview-body > toolbarbutton, #appMenu-mainView toolbarbutton {
          padding: var(--nt-pad-y) var(--nt-pad-x) !important;
          margin: 0 !important;
          min-height: 0 !important;
        }
        .panel-subview-body, #appMenu-mainView .panel-subview-body { padding: 2px 0 !important; margin: 0 !important; }
        .panel-header, .panel-footer { min-height: 0 !important; padding: var(--nt-pad-y) var(--nt-pad-x) !important; margin: 0 !important; }

        .unified-extensions-item { padding: 0 !important; margin: 0 !important; }
        .unified-extensions-item-action-button, .unified-extensions-item-menu-button {
          padding-block: var(--nt-pad-y) !important;
          min-height: 0 !important;
        }

        #downloadsListBox > richlistitem { padding: var(--nt-pad-y) var(--nt-pad-x) !important; margin: 0 !important; min-height: 0 !important; }
        .downloadContainer, .downloadMainArea { padding-block: 2px !important; min-height: 0 !important; }

        .urlbarView-row-inner { padding-block: 4px !important; min-height: 0 !important; }
        .urlbarView-row { padding-block: 0 !important; min-height: 0 !important; }

        #urlbar > .urlbar-background {
          background: #000000 !important;
          border: 1px solid #262626 !important;
        }
        #urlbar[focused] > .urlbar-background,
        #urlbar[open] > .urlbar-background,
        #urlbar[breakout][breakout-extend] > .urlbar-background {
          background: #000000 !important;
          border-color: #d71921 !important;
          outline: none !important;
        }
        .urlbar-input-container { background: #000000 !important; }
        .browserContainer, #main-window, body { background: #000000 !important; }
      '';

      userContent = ''
        /* userContent.css - Nothing-style about: pages and new tab. */

        @-moz-document url-prefix("about:") {
        	:root {
        		--nt-bg:     #000000;
        		--nt-box:    #0d0d0d;
        		--nt-hover:  #141414;
        		--nt-fg:     #ffffff;
        		--nt-dim:    #b3b3b3;
        		--nt-line:   #262626;
        		--nt-accent: #d71921;
        	}

        	html, body, #root, .outer-wrapper, .newtab-wrapper {
        		background-color: var(--nt-bg) !important;
        		color: var(--nt-fg) !important;
        	}

        	* {
        		border-radius: 0px !important;
        		scrollbar-color: #3a3a3a transparent;
        	}

        	button:hover, .button:hover {
        		background-color: var(--nt-fg) !important;
        		color: var(--nt-bg) !important;
        	}

        	th {
        		background-color: #141414 !important;
        		color: #ffffff !important;
        		border: 1px solid #262626 !important;
        	}

        	:root { color-scheme: dark !important; accent-color: #ffffff !important; }

        	input:not([type="checkbox"]):not([type="radio"]):not([type="range"]):not([type="button"]):not([type="submit"]),
        	textarea, select {
        		background-color: #000000 !important;
        		color: #ffffff !important;
        		border-color: #262626 !important;
        	}
        	input:focus, textarea:focus, select:focus { border-color: #d71921 !important; outline: none !important; }

        	* {
        		--button-background-color:         #0d0d0d !important;
        		--button-background-color-hover:   #141414 !important;
        		--button-background-color-active:  #1c1c1c !important;
        		--button-text-color:               #ffffff !important;
        		--button-border-color:             #262626 !important;
        		--input-background-color:          #000000 !important;
        		--input-text-color:                #ffffff !important;
        		--input-border-color:              #262626 !important;
        		--input-border-color-hover:        #b3b3b3 !important;
        		--toggle-background-color:         #0d0d0d !important;
        		--toggle-background-color-hover:   #141414 !important;
        		--toggle-border-color:             #b3b3b3 !important;
        		--checkbox-unchecked-bgcolor:      #000000 !important;
        		--checkbox-border-color:           #b3b3b3 !important;
        	}

        	* {
        		--text-color:                          #ffffff !important;
        		--text-color-deemphasized:             #b3b3b3 !important;
        		--color-accent-primary:                #d71921 !important;
        		--color-accent-secondary:              #ffffff !important;
        		--text-color-accent-primary-selected:  #ffffff !important;
        		--background-color-canvas:             #000000 !important;
        		--background-color-box:                #0d0d0d !important;
        		--background-color-box-info:           #0d0d0d !important;
        		--background-color-information:        #141414 !important;
        		--border-color:                        #262626 !important;
        		--border-color-deemphasized:           #262626 !important;
        		--button-background-color-muted:       #141414 !important;
        		--button-text-color-ghost-disabled:    #b3b3b3 !important;
        		--button-border:                       1px solid #262626 !important;
        		--table-background-color:              #0d0d0d !important;
        		--table-border-color:                  #262626 !important;
        		--table-header-background-color:       #141414 !important;
        		--table-row-background-color:          #000000 !important;
        		--table-row-background-color-alternate:#0d0d0d !important;

        		--in-content-page-background:          #000000 !important;
        		--in-content-page-color:               #ffffff !important;
        		--in-content-box-background:           #0d0d0d !important;
        		--in-content-box-border-color:         #262626 !important;
        		--in-content-border-color:             #262626 !important;
        		--in-content-accent-color:             #d71921 !important;
        		--in-content-primary-button-background:#d71921 !important;
        		--in-content-primary-button-text-color:#ffffff !important;

        		--link-color: #ffffff !important;
        		--link-color-hover: #cccccc !important;
        		--link-color-active: #ffffff !important;
        		--link-color-visited: #b3b3b3 !important;
        	}

        	* {
        		--color-blue-0:#ffffff !important;--color-blue-10:#ffffff !important;--color-blue-20:#ffffff !important;--color-blue-30:#ffffff !important;--color-blue-40:#ffffff !important;
        		--color-blue-50:#ffffff !important;--color-blue-60:#ffffff !important;--color-blue-70:#ffffff !important;--color-blue-80:#ffffff !important;--color-blue-90:#ffffff !important;
        		--color-cyan-0:#ffffff !important;--color-cyan-10:#ffffff !important;--color-cyan-20:#ffffff !important;--color-cyan-30:#ffffff !important;--color-cyan-40:#ffffff !important;
        		--color-cyan-50:#ffffff !important;--color-cyan-60:#ffffff !important;--color-cyan-70:#ffffff !important;--color-cyan-80:#ffffff !important;--color-cyan-90:#ffffff !important;
        		--color-green-0:#ffffff !important;--color-green-10:#ffffff !important;--color-green-20:#ffffff !important;--color-green-30:#ffffff !important;--color-green-40:#ffffff !important;
        		--color-green-50:#ffffff !important;--color-green-60:#ffffff !important;--color-green-70:#ffffff !important;--color-green-80:#ffffff !important;--color-green-90:#ffffff !important;
        		--color-orange-0:#ffffff !important;--color-orange-10:#ffffff !important;--color-orange-20:#ffffff !important;--color-orange-30:#ffffff !important;--color-orange-40:#ffffff !important;
        		--color-orange-50:#ffffff !important;--color-orange-60:#ffffff !important;--color-orange-70:#ffffff !important;--color-orange-80:#ffffff !important;--color-orange-90:#ffffff !important;
        		--color-pink-0:#ffffff !important;--color-pink-10:#ffffff !important;--color-pink-20:#ffffff !important;--color-pink-30:#ffffff !important;--color-pink-40:#ffffff !important;
        		--color-pink-50:#ffffff !important;--color-pink-60:#ffffff !important;--color-pink-70:#ffffff !important;--color-pink-80:#ffffff !important;--color-pink-90:#ffffff !important;
        		--color-purple-0:#ffffff !important;--color-purple-10:#ffffff !important;--color-purple-20:#ffffff !important;--color-purple-30:#ffffff !important;--color-purple-40:#ffffff !important;
        		--color-purple-50:#ffffff !important;--color-purple-60:#ffffff !important;--color-purple-70:#ffffff !important;--color-purple-80:#ffffff !important;--color-purple-90:#ffffff !important;
        		--color-violet-0:#ffffff !important;--color-violet-10:#ffffff !important;--color-violet-20:#ffffff !important;--color-violet-30:#ffffff !important;--color-violet-40:#ffffff !important;
        		--color-violet-50:#ffffff !important;--color-violet-60:#ffffff !important;--color-violet-70:#ffffff !important;--color-violet-80:#ffffff !important;--color-violet-90:#ffffff !important;
        		--color-violet-desaturated-0:#ffffff !important;--color-violet-desaturated-10:#ffffff !important;--color-violet-desaturated-20:#ffffff !important;--color-violet-desaturated-30:#ffffff !important;--color-violet-desaturated-40:#ffffff !important;
        		--color-violet-desaturated-50:#ffffff !important;--color-violet-desaturated-60:#ffffff !important;--color-violet-desaturated-70:#ffffff !important;--color-violet-desaturated-80:#ffffff !important;--color-violet-desaturated-90:#ffffff !important;
        		--color-yellow-0:#ffffff !important;--color-yellow-10:#ffffff !important;--color-yellow-20:#ffffff !important;--color-yellow-30:#ffffff !important;--color-yellow-40:#ffffff !important;
        		--color-yellow-50:#ffffff !important;--color-yellow-60:#ffffff !important;--color-yellow-70:#ffffff !important;--color-yellow-80:#ffffff !important;--color-yellow-90:#ffffff !important;
        		--color-red-0:#d71921 !important;--color-red-10:#d71921 !important;--color-red-20:#d71921 !important;--color-red-30:#d71921 !important;--color-red-40:#d71921 !important;
        		--color-red-50:#d71921 !important;--color-red-60:#d71921 !important;--color-red-70:#d71921 !important;--color-red-80:#d71921 !important;--color-red-90:#d71921 !important;
        	}

        	* {
        		--color-gray-0:#ffffff !important;  --color-gray-05:#f1f1f1 !important; --color-gray-10:#e3e3e3 !important;
        		--color-gray-15:#d4d4d4 !important; --color-gray-20:#c6c6c6 !important; --color-gray-25:#b8b8b8 !important;
        		--color-gray-30:#aaaaaa !important; --color-gray-35:#9c9c9c !important; --color-gray-40:#8e8e8e !important;
        		--color-gray-45:#808080 !important; --color-gray-50:#717171 !important; --color-gray-55:#636363 !important;
        		--color-gray-60:#555555 !important; --color-gray-65:#474747 !important; --color-gray-70:#393939 !important;
        		--color-gray-75:#2a2a2a !important; --color-gray-80:#1c1c1c !important; --color-gray-85:#0e0e0e !important;
        		--color-gray-90:#000000 !important;
        	}

        	.search-handoff-button, .search-inner-wrapper input, .fake-editable,
        	.top-site-outer .tile, .top-site-outer .tile .icon-wrapper, .top-site-button,
        	.context-menu, .context-menu-list {
        		background-color: #0d0d0d !important;
        		color: #ffffff !important;
        		border-color: #262626 !important;
        	}
        	.search-handoff-button:hover, .search-handoff-button:focus,
        	.search-inner-wrapper input:focus,
        	.top-site-outer:hover .tile, .top-site-outer:focus .tile {
        		background-color: #000000 !important;
        		border-color: #d71921 !important;
        		outline: none !important;
        	}

        	* {
        		--newtab-background-color: #000000 !important;
        		--newtab-background-color-secondary: #0d0d0d !important;
        		--newtab-text-primary-color: #ffffff !important;
        		--newtab-text-secondary-color: #b3b3b3 !important;
        		--newtab-border-color: #262626 !important;
        		--newtab-element-hover-color: #141414 !important;
        		--newtab-element-active-color: #1c1c1c !important;
        		--newtab-textbox-background-color: #0d0d0d !important;
        		--newtab-textbox-border: #262626 !important;
        		--newtab-textbox-focus-color: #d71921 !important;
        		--newtab-textbox-focus-boxshadow: none !important;
        		--newtab-primary-action-background: #d71921 !important;
        		--newtab-search-border-color: #262626 !important;
        		--newtab-search-dropdown-color: #000000 !important;
        		--newtab-search-dropdown-header-color: #0d0d0d !important;
        		--newtab-contextmenu-background-color: #000000 !important;
        		--newtab-card-background-color: #0d0d0d !important;
        		--newtab-card-hairline: #222222 !important;
        	}
        }

        /* Sidebery sidebar */
        @-moz-document regexp("moz-extension://[^/]+/sidebar/.*") {
        	#root.root {
        		--border: #000000 !important;
        		--ctx-menu-bg: #000000 !important;
        		--ctx-menu-separator: #000000 !important;
        		--popup-bg: #000000 !important;
        		--tabs-activated-bg: #000000 !important;
        		--toolbar-field-border-color: #000000 !important;
        		--toolbar-field-focus-border-color: #d71921 !important;
        		--frame-bg: #000000 !important;

        		--tabs-height: 32px !important;
        		--tabs-inner-gap: 8px !important;
        		--tabs-margin: 0px !important;
        		--tabs-font: 12px "JetBrainsMono Nerd Font", monospace !important;
        		--tabs-count-font: 12px "JetBrainsMono Nerd Font", monospace !important;
        		--general-margin: 0px !important;
        		--general-border-radius: 0px !important;
        		--active-el-shadow: none !important;
        	}

        	#root.root, .Sidebar, .NavigationBar, .PanelView { background: #000000 !important; }

        	.Tab .body { background: transparent !important; border: none !important; border-radius: 0px !important; }
        	.Tab:hover .body { background: #141414 !important; }

        	.Tab[data-active="true"] .body {
        		background: #000000 !important;
        		border: none !important;
        		border-left: 2px solid #d71921 !important;
        		border-radius: 0px !important;
        	}

        	.NavigationBar .main-items .nav-item[data-class="panel"] .name-box { border-width: 1px !important; }
        	.NavigationBar .nav-item[data-active="true"] { border: 1px solid #d71921 !important; }
        }
      '';
    };
  };
}
