local M = {
  theme = {},
}

function M.setup()
  local base16 = require("globals.colors")
  local lush = require("lush")
  local hsl = lush.hsl

  -- Map our colors into hsl objects that are easier to lighten/darken
  local colors = {}
  for k, v in pairs(base16) do
    colors[k] = hsl(v)
  end

  colors.foreground = colors.lightest_gray
  colors.background = colors.black.darken(20)

  -- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
  -- support an annotation like the following. Consult your server documentation.
  ---@diagnostic disable: undefined-global
  local theme = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
      Background({ bg = colors.background }), -- normal background color
      ColorColumn({ bg = colors.darker_gray }), -- Columns set with "colorcolumn"
      Conceal({ fg = colors.light_gray }), -- Placeholder characters substituted for concealed text (see "conceallevel")
      Cursor({ fg = colors.black, bg = colors.foreground }), -- Character under the cursor
      lCursor({ Cursor }), -- Character under the cursor when |language-mapping| is used (see "guicursor")
      CursorIM({ Cursor }), -- Like Cursor, but used when in IME mode |CursorIM|
      TermCursor({ Cursor }), -- Cursor in a focused terminal
      TermCursorNC({ Cursor }), -- Cursor in an unfocused terminal
      CursorLine({ bg = colors.darker_gray }), -- Screen-line at the cursor, when "cursorline" is set. Low-priority if foreground (ctermfg OR guifg) is not set.
      CursorColumn({ CursorLine }), -- Screen-column at the cursor, when "cursorcolumn" is set.
      Directory({ fg = colors.blue }), -- Directory names (and other special names in listings)
      Added({ fg = colors.green }), -- diff mode: Added line
      Removed({ fg = colors.red }), -- diff mode: Removed line
      Changed({ fg = colors.orange }), -- diff mode: Changed line
      DiffAdd({ Added }), -- Diff mode: Added line |diff.txt|
      DiffChange({ Changed }), -- Diff mode: Changed line |diff.txt|
      DiffDelete({ Removed }), -- Diff mode: Deleted line |diff.txt|
      DiffText({ fg = colors.background, bg = colors.green }), -- Diff mode: Changed text within a changed line |diff.txt|
      NonText({ fg = colors.gray }), -- "@" at the end of the window, characters from "showbreak" and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn"t fit at the end of the line). See also |hl-EndOfBuffer|.
      ErrorMsg({ fg = colors.red }), -- Error messages on the command line
      VertSplit({ fg = colors.background, bg = colors.background }), -- Column separating vertically split windows
      Folded({ fg = colors.lightest_gray, bg = colors.darker_gray }), -- Line used for closed folds
      LineNr({ fg = colors.light_gray }), -- Line number for ":number" and ":#" commands, and when "number" or "relativenumber" option is set.
      LineNrAbove({ LineNr }), -- Line number for when the "relativenumber" option is set, above the cursor line
      LineNrBelow({ LineNr }), -- Line number for when the "relativenumber" option is set, below the cursor line
      CursorLineNr({ gui = "bold" }), -- Like LineNr when "cursorline" or "relativenumber" is set for the cursor line.
      MatchParen({ bg = colors.gray }), -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
      ModeMsg({ fg = colors.green }), -- "showmode" message (e.g., "-- INSERT -- ")
      MsgArea({ bg = colors.background }), -- Area for messages and cmdline
      MsgSeparator({ bg = colors.gray }), -- Separator for scrolled messages, `msgsep` flag of "display"
      NormalFloat({ bg = colors.black }), -- Normal text in floating windows.
      FloatBorder({ fg = colors.gray, bg = colors.black }), -- Border of floating windows.
      FloatBorderCmp({ FloatBorder }), -- Border of floating windows.
      FloatBorderDocs({ FloatBorder }), -- Border of floating windows.
      TelescopeBorder({ FloatBorder }), -- Border of floating windows.
      FloatShadow({ bg = colors.background }), -- Shadow of floating windows.
      FloatShadowThrough({ FloatShadow }), -- Shadow of floating windows.
      Title({ fg = colors.blue }), -- Titles for output from ":set all", ":autocmd" etc.
      FloatTitle({ Title }), -- Title of floating windows.
      Normal({ fg = colors.foreground }), -- Normal text
      NormalNC({ Normal }), -- normal text in non-current windows
      Pmenu({ NormalFloat }), -- Popup menu: Normal item.
      PmenuBorder({ FloatBorder }), -- Popup menu: Border.
      PmenuSbar({ bg = colors.dark_gray }), -- Popup menu: Scrollbar.
      PmenuSel({ fg = colors.black, bg = colors.foreground }), -- Popup menu: Selected item.
      PmenuThumb({ bg = colors.white }), -- Popup menu: Thumb of the scrollbar.
      CmpPmenu({ Pmenu }),
      Question({ fg = colors.yellow }), -- |hit-enter| prompt and yes/no questions
      QuickFixLine({ Background }), -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
      Search({ fg = colors.black, bg = colors.yellow }), -- Last search pattern highlighting (see "hlsearch"). Also used for similar items that need to stand out.
      IncSearch({ Search }), -- "incsearch" highlighting; also used for the text replaced with ":s///c"
      Substitute({ Search }), -- |:substitute| replacement text highlighting
      CurSearch({ Search, bg = colors.blue }), -- Highlighting a search pattern under the cursor (see "hlsearch")
      SpecialKey({ NonText }), -- Unprintable characters: text displayed differently from what it really is. But not "listchars" whitespace. |hl-Whitespace|
      StatusLine({ Background }), -- Status line of current window
      StatusLineNC({ StatusLine }), -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
      TabLine({ StatusLine }), -- Tab pages line, not active tab page label
      TabLineFill({ TabLine }), -- Tab pages line, where there are no labels
      TabLineSel({ fg = colors.foreground, bg = colors.black }), -- Active tab page label
      Visual({ bg = colors.dark_gray }), -- Visual mode selection
      VisualNOS({ Visual }), -- Visual mode selection when vim is "Not Owning the Selection".
      WarningMsg({ fg = colors.yellow }), -- Warning messages
      Whitespace({ NonText }), -- "nbsp", "space", "tab" and "trail" in "listchars"
      Winseparator({ fg = colors.background, bg = colors.background }), -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
      WildMenu({ Search }), -- Current match in "wildmenu" completion
      WinBar({ TabLine }), -- Window bar of current window
      WinBarNC({ TabLine }), -- Window bar of not-current windows
      Comment({ NonText }), -- Any comment
      Constant({ fg = colors.orange }), -- (*) Any constant
      String({ fg = colors.green }), --   A string constant: "this is a string"
      Character({ Constant }), --   A character constant: "c", "\n"
      Number({ Constant }), --   A number constant: 234, 0xff
      Boolean({ Constant }), --   A boolean constant: TRUE, false
      Exception({ fg = colors.red }), --   Exception name
      Define({ fg = colors.purple }), --   Preprocessor #define
      Delimiter({ fg = colors.magenta }), --   Character that needs attention
      Float({ Constant }), --   A floating point constant: 2.3e10
      Identifier({ Normal }), -- (*) Any variable name
      Function({ fg = colors.blue }), --   Function name (also: methods for classes)
      Method({ Function }), --   Method
      Statement({ fg = colors.purple }), -- (*) Any statement
      PreProc({ Identifier }), -- (*) Generic Preprocessor
      Type({ fg = colors.yellow }), -- (*) int, long, char, etc.
      Structure({ Type }),
      Typedef({ Type }), --  A typedef
      Struct({ Type }), --  struct, union, enum, etc.
      Special({ fg = colors.cyan }), -- (*) Any special symbol
      SpecialChar({ fg = colors.purple }), --   Special character in a constant
      Error({ fg = colors.red }), -- Any erroneous construct
      LspInlayHint({ NonText }), -- Used for virtual text "hints"
      DiagnosticError({ fg = colors.red }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticWarn({ fg = colors.yellow }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticInfo({ fg = colors.blue }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticHint({ fg = colors.purple }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticOk({ fg = colors.green }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticUnderlineError({ gui = "undercurl" }), -- Used to underline "Error" diagnostics.
      DiagnosticUnderlineWarn({ gui = "undercurl" }), -- Used to underline "Warn" diagnostics.
      DiagnosticUnderlineInfo({ gui = "undercurl" }), -- Used to underline "Info" diagnostics.
      DiagnosticUnderlineHint({ gui = "undercurl" }), -- Used to underline "Hint" diagnostics.
      DiagnosticUnderlineOk({ gui = "undercurl" }), -- Used to underline "Ok" diagnostics.
      sym("@string.special")({ Statement }), -- SpecialChar
      sym("@variable")({ g = colors.lighter_gray }), -- Identifier
      sym("@keyword.return")({ fg = colors.red }), -- Return keyword
      sym("@text.strong")({ gui = "bold" }), -- Strong text
      sym("@text.emphasis")({ gui = "italic" }), -- Emphasized text
      sym("@text.strike")({ gui = "strikethrough" }), -- Strike-through text
      sym("@lsp.type.variable")({ fg = colors.lighter_gray }), -- LSP variable type
      sym("@lsp.mod.defaultLibrary")({ Special }), -- LSP default library
      sym("@lsp.mod.deprecated")({ fg = colors.red }), -- LSP deprecated module
      sym("@markup.strong")({ gui = "bold" }), -- Strong text
      sym("@markup.italic")({ gui = "italic" }), -- Italic text
      sym("@markup.strikethrough")({ gui = "strikethrough" }), -- Strike-through text
      sym("@markup.underline")({ gui = "underline" }), -- Underlined text
      AlphaHeader({ Title }),
      AlphaFooter({ fg = colors.yellow }),
      DevIcon({ fg = colors.foreground }),
      DevIconDefault({ DevIcon }),
      DevIconLua({ fg = colors.blue }),
      DevIconMarkdown({ DevIconDefault }),
      DevIconLog({ DevIconDefault }),
      DevIconConfiguration({ fg = colors.green }),
      DevIconFolder({ fg = colors.blue }),
      DevIconZsh({ fg = colors.green }),
      DevIconRasi({ fg = colors.green }),
      DevIconReadme({ DevIconDefault }),
      DevIconMustache({ fg = colors.green }),
      DevIconConfig({ fg = colors.green }),
      DevIconConf({ fg = colors.green }),
      DevIconIni({ fg = colors.green }),
      DevIconShell({ fg = colors.red }),
      DevIconSh({ fg = colors.red }),
      DevIconTerminal({ fg = colors.red }),
      DevIcon7z({ fg = colors.orange }),
      DevIconZip({ fg = colors.orange }),
      DevIconi3({ fg = colors.blue }),
      DevIconDb({ DevIconDefault }),
      DevIconEx({ fg = colors.purple }),
      DevIconGo({ fg = colors.cyan }),
      DevIconGz({ fg = colors.orange }),
      DevIconBin({ fg = colors.blue }),
      DevIconWaveformAudioFile = { fg = colors.yellow },
      DevIconMPEGAudioLayerIII({ fg = colors.yellow }),
      DevIconCss({ fg = colors.blue }),
      DevIconScss({ fg = colors.blue }),
      DevIconCsv({ fg = colors.green }),
      DevIconTmux({ fg = colors.green }),
      DevIconZshrc({ fg = colors.green }),
      DevIconTxt({ DevIconDefault }),
      DevIconPrettierConfig({ fg = colors.green }),
      DevIconNotebook({ fg = colors.green }),
      DevIconDoc({ fg = colors.blue }),
      DevIconDockerfile({ fg = colors.blue }),
      DevIconDot({ fg = colors.yellow }),
      DevIconEnv({ fg = colors.yellow }),
      DevIconGif({ fg = colors.purple }),
      DevIconJpg({ fg = colors.purple }),
      DevIconJpegXl({ fg = colors.purple }),
      DevIconSvg({ fg = colors.purple }),
      DevIconPng({ fg = colors.purple }),
      DevIconJpeg({ fg = colors.purple }),
      DevIconWebp({ fg = colors.purple }),
      DevIconSolidity({ fg = colors.green }),
      DevIconFavicon({ fg = colors.purple }),
      DevIconHtml({ fg = colors.orange }),
      DevIconPdf({ fg = colors.orange }),
      DevIconIco({ DevIconDefault }),
      DevIconImg({ DevIconDefault }),
      DevIconImage({ DevIconDefault }),
      DevIconInfo({ fg = colors.gray }),
      DevIconArch({ fg = colors.blue }),
      DevIconAlpine({ fg = colors.blue }),
      DevIconAppleScript({ fg = colors.blue }),
      DevIconApple({ fg = colors.blue }),
      DevIconDebian({ fg = colors.blue }),
      DevIconBash({ fg = colors.green }),
      DevIconBashrc({ fg = colors.green }),
      DevIconBashProfile({ fg = colors.green }),
      DevIconEpub({ fg = colors.orange }),
      DevIconEbook({ fg = colors.orange }),
      DevIconMobim({ fg = colors.orange }),
      DevIconGIMP({ fg = colors.purple }),
      DevIconPackageJson({ fg = colors.green }),
      DevIconJson({ fg = colors.green }),
      DevIconYml({ fg = colors.green }),
      DevIconToml({ fg = colors.green }),
      DevIconJson5({ fg = colors.green }),
      DevIconJsonc({ fg = colors.green }),
      DevIconAstro({ fg = colors.red }),
      DevIconCMake({ fg = colors.gray }),
      DevIconCrystal({ fg = colors.red }),
      DevIconGemfile({ fg = colors.red }),
      DevIconRakefile({ fg = colors.red }),
      DevIconBrewfile({ fg = colors.red }),
      DevIconRb({ fg = colors.red }),
      DevIconErb({ fg = colors.red }),
      DevIconGemspec({ fg = colors.red }),
      DevIconConfigRu({ fg = colors.purple }),
      DevIconGraphQL({ fg = colors.purple }),
      DevIconDownload({ DevIconDefault }),
      DevIconEslintrc({ fg = colors.cyan }),
      DevIconJavascriptReactSpec({ fg = colors.cyan }),
      DevIconJavascriptReactTest({ fg = colors.cyan }),
      DevIconJs({ fg = colors.cyan }),
      DevIconJsx({ fg = colors.cyan }),
      DevIconCjs({ fg = colors.cyan }),
      DevIconGDScript({ fg = colors.cyan }),
      DevIconEndeavour({ fg = colors.purple }),
      DevIconGitCommit({ fg = colors.orange }),
      DevIconGitlabCI({ fg = colors.orange }),
      DevIconGitLogo({ fg = colors.orange }),
      DevIconGitConfig({ fg = colors.orange }),
      DevIconGitIgnore({ fg = colors.orange }),
      DevIconGitAttributes({ fg = colors.orange }),
      NeoTreeNormal({ Background }),
      NeoTreeNormalNC({ Background }),
      NeoTreeNormalEndOfBuffer({ Background }),
      NeoTreeDimText({ NonText }),
      NeoTreeFadeText1({ NonText }),
      NeoTreeFadeText2({ fg = colors.dark_gray }),
      NeoTreeWinSeparator({ Winseparator }),
      NeoTreeModified({ fg = colors.yellow }),
      NeoTreeGitAdded({ Added }),
      NeoTreeGitConflict({ Removed }),
      NeoTreeGitUnstaged({ fg = colors.yellow }),
      NeoTreeGitUntracked({ fg = colors.yellow }),
      NeoTreeTab({ TabLine }),
      NeoTreeTabActive({ TabLine, bg = colors.black }),
      NeoTreeTabInactive({ TabLine }),
      NeoTreeSeparator({ fg = colors.background, bg = colors.background }),
      BufferLineBackground({ Background }),
      BufferLineSeparator({ fg = colors.background, bg = colors.background }),
      BufferLineTabSeparator({ BufferLineSeparator }),
      BufferLineFill({ TabLine }),
      BufferLineTab({ TabLine }),
      BufferLineBuffer({ TabLine }),
      BufferLineBufferSelected({ fg = colors.foreground }),
      BufferLineBufferTabSelected({ BufferLineBufferSelected }),
      BufferLineCloseButton({ fg = colors.foreground }),
      BufferLineCloseButtonVisible({ BufferLineCloseButton }),
      BufferLineCloseButtonSelected({ BufferLineCloseButton }),
      BufferLineBufferVisible({ fg = colors.foreground }),
      BufferLineDevIconDefault({ DevIcon, bg = colors.background }),
      BufferLineDevIconYml({ DevIconYml, bg = colors.background }),
      BufferLineDevIconRb({ DevIconRb, bg = colors.background }),
      BufferLineDevIconRakefile({ DevIconRakefile, bg = colors.background }),
      BufferLineDevIconDockerfile({ DevIconDockerfile, bg = colors.background }),
      BufferLineDevIconYaml({ DevIconYml, bg = colors.background }),
      BufferLineDevIconJs({ DevIconJs, bg = colors.background }),
      BufferLineDevIconJsx({ DevIconJsx, bg = colors.background }),
      BufferLineDevIconJson({ DevIconJson, bg = colors.background }),
      BufferLineDevIconCsv({ DevIconCsv, bg = colors.background }),
      BufferLineDevIconReadme({ DevIconReadme, bg = colors.background }),
      IlluminatedWordText({ bg = colors.darker_gray }),
      IlluminatedWordRead({ IlluminatedWordText }),
      IlluminatedWordWrite({ IlluminatedWordText }),
      NeotestPassed({ fg = colors.green }),
      NeotestFailed({ fg = colors.red }),
      NeotestSkipped({ fg = colors.orange }),
      NeotestRunning({ fg = colors.yellow }),
      NeotestNamespace({ fg = colors.purple }),
      NeotestFile({ fg = colors.blue }),
      NeotestDirectory({ fg = colors.blue }),
      NeoTestIndent({ NonText }),
      SatelliteBar({ bg = colors.dark_gray }),
      SatelliteBackground({ Background }),
      TelescopeTitle({ Title }),
      TelescopeMatching({ fg = colors.yellow }),
      TelescoeBorder({ fg = colors.magenta }),
      TelescopeMultiSelection({ bg = colors.darker_gray, gui = "bold" }),
      TelescopeSelection({ bg = colors.darker_gray, gui = "bold" }),
      barbecue_normal({ bg = colors.background }),
      DapStoppedLine({ CursorLine }),
      NotifyBackground({ NormalFloat }),
      NotifyBody({ Normal }),
      NotifyERRORBorder({ fg = colors.red }),
      NotifyWARNBorder({ fg = colors.yellow }),
      NotifyINFOBorder({ fg = colors.blue }),
      NotifyHINTBorder({ fg = colors.purple }),
      NotifyOKBorder({ fg = colors.green }),
      NotifyERRORBody({ NotifyBody }),
      NotifyWARNBody({ NotifyBody }),
      NotifyINFOBody({ NotifyBody }),
      NotifyHINTBody({ NotifyBody }),
      NotifyOKBody({ NotifyBody }),
      NotifyERRORTitle({ fg = colors.red }),
      NotifyWARNTitle({ fg = colors.yellow }),
      NotifyINFOTitle({ fg = colors.blue }),
      NotifyHINTTitle({ fg = colors.purple }),
      NotifyOKTitle({ fg = colors.green }),
      NotifyERRORIcon({ fg = colors.red }),
      NotifyWARNIcon({ fg = colors.yellow }),
      NotifyINFOIcon({ fg = colors.blue }),
      NotifyHINTIcon({ fg = colors.purple }),
      NotifyOKIcon({ fg = colors.green }),
      GitSignsAdd({ fg = colors.green }), -- Diff mode: Added line |diff.txt
      GitSignsAddNr({ fg = colors.green }), -- Diff mode: Added line |diff.txt
      GitSignsChange({ fg = colors.orange }), -- Diff mode: Changed line |diff.txt
      GitSignsChangeNr({ fg = colors.orange }), -- Diff mode: Changed line |diff.txt
      GitSignsDelete({ fg = colors.red }), -- Diff mode: Deleted line |diff.txt
      GitSignsDeleteNr({ fg = colors.red }), -- Diff mode: Deleted line |diff.txt
      MiniClueBorder({ FloatBorder }),
      MiniClueDescGroup({ DiagnosticWarn }),
      MiniClueDescSingle({ NormalFloat }),
      MiniClueNextKey({ DiagnosticHint }),
      MiniClueNextKeyWithPostkeys({ DiagnosticError }),
      MiniClueSeparator({ DiagnosticInfo }),
      MiniClueTitle({ Title }),
      SnacksIndent({ NonText }),
      SnacksIndentScope({ fg = colors.foreground }),
      SnacksIndentChunk({ SnacksIndentScope }),
      SnacksIndent1({ SnacksIndentScope }),
      SnacksIndent2({ SnacksIndentScope }),
      SnacksIndent3({ SnacksIndentScope }),
      SnacksIndent4({ SnacksIndentScope }),
      SnacksIndent5({ SnacksIndentScope }),
      SnacksIndent6({ SnacksIndentScope }),
      SnacksIndent7({ SnacksIndentScope }),
      SnacksIndent8({ SnacksIndentScope }),
      MiniIndentscopeSymbol({ fg = colors.light_gray.lighten(20) }),
      MiniIndentscopeSymbolOff({ fg = colors.red }),
      MiniSurround({ IncSearch }),
      LazyButton({ bg = colors.darker_gray }),
      LazyButtonActive({ bg = colors.dark_gray }),
      LazyDimmed({ Comment }),
      LazyH1({ bg = colors.dark_gray }),
      NoiceCmdlinePopupBorder({ fg = colors.blue }),
      NoiceConfirmBorder({ fg = colors.purple }),
      TroubleCount({ fg = colors.green, gui = "bold" }),
      TroubleFoldIcon({ fg = colors.lighter_Gray }),
      TroubleIndent({ fg = colors.dark_gray }),
      TroubleLocation({ fg = colors.light_gray }),
      TroubleSignError({ DiagnosticError }),
      TroubleSignHint({ DiagnosticHint }),
      TroubleSignInformation({ DiagnosticInfo }),
      TroubleSignOther({ DiagnosticInfo }),
      TroubleSignWarning({ DiagnosticWarn }),
      TroubleText({ fg = colors.lighter_gray }),
      TroubleTextError({ TroubleText }),
      TroubleTextHint({ TroubleText }),
      TroubleTextInformation({ TroubleText }),
      TroubleTextWarning({ TroubleText }),
      CmpItemAbbr({ fg = colors.lighter_gray }),
      CmpItemAbbrDeprecated({ fg = colors.gray }),
      CmpItemAbbrMatch({ fg = colors.yellow }),
      CmpItemAbbrMatchFuzzy({ fg = colors.yellow }),
      CmpItemKind({ fg = colors.magenta, bg = colors.darker_gray }),
      CmpItemMenu({ fg = colors.lighter_gray, bg = colors.darker_gray }),
      CmpItemKindClass({ Type }),
      CmpItemKindColor({ Special }),
      CmpItemKindConstant({ Constant }),
      CmpItemKindConstructor({ Type }),
      CmpItemKindEnum({ Structure }),
      CmpItemKindEnumMember({ Structure }),
      CmpItemKindEvent({ Exception }),
      CmpItemKindField({ Structure }),
      CmpItemKindFile({ link = "Tag" }),
      CmpItemKindFolder({ Directory }),
      CmpItemKindFunction({ Function }),
      CmpItemKindInterface({ Structure }),
      CmpItemKindKeyword({ Identifier }),
      CmpItemKindMethod({ Method }),
      CmpItemKindModule({ Structure }),
      CmpItemKindOperator({ link = "Operator" }),
      CmpItemKindProperty({ Structure }),
      CmpItemKindReference({ link = "Tag" }),
      CmpItemKindSnippet({ Special }),
      CmpItemKindStruct({ Structure }),
      CmpItemKindText({ Statement }),
      CmpItemKindTypeParameter({ Type }),
      CmpItemKindUnit({ Special }),
      CmpItemKindValue({ Identifier }),
      CmpItemKindVariable({ Delimiter }),
      IndentBlanklineChar({ fg = colors.dark_gray, gui = "nocombine" }),
      IndentBlanklineContextChar({ fg = colors.magenta, gui = "nocombine" }),
      IndentBlanklineContextStart({
        sp = colors.magenta,
        gui = "underline,nocombine",
      }),
      IndentBlanklineIndent1({ fg = colors.green }),
      IndentBlanklineIndent2({ fg = colors.blue }),
      IndentBlanklineIndent3({ fg = colors.yellow }),
      IndentBlanklineIndent4({ fg = colors.orange }),
      IndentBlanklineIndent5({ fg = colors.purple }),
      IndentBlanklineIndent6({ fg = colors.red }),
      IndentBlanklineIndent7({ fg = colors.cyan }),
      IndentBlanklineIndent8({ fg = colors.magenta }),
      DapUIScope({ Title }),
      DapUIType({ Type }),
      DapUIModifiedValue({ fg = colors.purple, gui = "bold" }),
      DapUIDecoration({ Title }),
      DapUIThread({ String }),
      DapUIStoppedThread({ Title }),
      DapUISource({ Directory }),
      DapUILineNumber({ Title }),
      DapUIFloatBorder({ FloatBorder }),
      DapUIWatchesEmpty({ ErrorMsg }),
      DapUIWatchesValue({ String }),
      DapUIWatchesError({ DiagnosticError }),
      DapUIBreakpointsPath({ Directory }),
      DapUIBreakpointsInfo({ DiagnosticInfo }),
      DapUIBreakpointsCurrentLine({ fg = colors.green, gui = "bold" }),
      DapUIBreakpointsDisabledLine({ Comment }),
      MasonError({ ErrorMsg }),
      MasonHeader({ fg = colors.black, bg = colors.blue }),
      MasonHeaderSecondary({ fg = colors.black, bg = colors.magenta }),
      MasonHeading({ gui = "bold" }),
      MasonHighlight({ fg = colors.magenta }),
      MasonHighlightBlock({ fg = colors.black, bg = colors.magenta }),
      MasonHighlightBlockBold({ MasonHeaderSecondary }),
      MasonHighlightBlockBoldSecondary({ MasonHeader }),
      MasonHighlightBlockSecondary({ fg = colors.black, bg = colors.blue }),
      MasonLink({ MasonHighlight }),
      MasonMuted({ Comment }),
      MasonMutedBlock({ fg = colors.black, bg = colors.gray }),
      MasonMutedBlockBold({ MasonMutedBlock, gui = "bold" }),
    }
  end)

  -- Return our parsed theme for extension or use elsewhere.
  M.theme = theme
end

return M
