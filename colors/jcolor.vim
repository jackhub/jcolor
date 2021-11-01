" -----------------------------------------------------------------------------
" Name:         jcolor
" Description:  High Contrast & Vivid Color Scheme based on Monokai Pro
" Author:       Sainnhepark <sainnhe@gmail.com>
" Website:      https://github.com/sainnhe/jcolor/
" License:      MIT
" -----------------------------------------------------------------------------

" Initialization: {{{
let s:configuration = jcolor#get_configuration()
let s:palette = jcolor#get_palette(s:configuration.style)
let s:path = expand('<sfile>:p') " the path of this script
let s:last_modified = 'Fri Aug  6 11:26:03 AM UTC 2021'
let g:jcolor_loaded_file_types = []

if !(exists('g:colors_name') && g:colors_name ==# 'jcolor' && s:configuration.better_performance)
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'jcolor'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif
" }}}
" Common Highlight Groups: {{{
" UI: {{{
if s:configuration.transparent_background
  call jcolor#highlight('Normal', s:palette.fg, s:palette.none)
  call jcolor#highlight('Terminal', s:palette.fg, s:palette.none)
  if s:configuration.show_eob
    call jcolor#highlight('EndOfBuffer', s:palette.bg4, s:palette.none)
  else
    call jcolor#highlight('EndOfBuffer', s:palette.bg0, s:palette.none)
  endif
  call jcolor#highlight('Folded', s:palette.grey, s:palette.none)
  call jcolor#highlight('ToolbarLine', s:palette.fg, s:palette.none)
  call jcolor#highlight('FoldColumn', s:palette.grey2, s:palette.none)
else
  call jcolor#highlight('Normal', s:palette.fg, s:palette.bg0)
  call jcolor#highlight('Terminal', s:palette.fg, s:palette.bg0)
  if s:configuration.show_eob
    call jcolor#highlight('EndOfBuffer', s:palette.bg4, s:palette.bg0)
  else
    call jcolor#highlight('EndOfBuffer', s:palette.bg0, s:palette.bg0)
  endif
  call jcolor#highlight('Folded', s:palette.grey, s:palette.bg1)
  call jcolor#highlight('ToolbarLine', s:palette.fg, s:palette.bg2)
  call jcolor#highlight('FoldColumn', s:palette.grey2, s:palette.none)
endif
call jcolor#highlight('SignColumn', s:palette.fg, s:palette.none)
call jcolor#highlight('IncSearch', s:palette.bg0, s:palette.bg_red)
call jcolor#highlight('Search', s:palette.bg0, s:palette.bg_green)
call jcolor#highlight('MsgArea', s:palette.fg, s:palette.bg0)
call jcolor#highlight('ColorColumn', s:palette.none, s:palette.bg01)
call jcolor#highlight('Conceal', s:palette.grey2, s:palette.none)
if s:configuration.cursor ==# 'auto'
  call jcolor#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
else
  call jcolor#highlight('Cursor', s:palette.bg0, s:palette[s:configuration.cursor])
endif
highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
if &diff
  call jcolor#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call jcolor#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
else
  call jcolor#highlight('CursorLine', s:palette.none, s:palette.bg1)
  call jcolor#highlight('CursorColumn', s:palette.none, s:palette.bg1)
endif
call jcolor#highlight('LineNr', s:palette.grey2, s:palette.none)
if &diff
  call jcolor#highlight('CursorLineNr', s:palette.fg, s:palette.none, 'underline')
else
  call jcolor#highlight('CursorLineNr', s:palette.fg, s:palette.none)
endif
call jcolor#highlight('DiffAdd', s:palette.none, s:palette.diff_green)
call jcolor#highlight('DiffChange', s:palette.none, s:palette.diff_blue)
call jcolor#highlight('DiffDelete', s:palette.none, s:palette.diff_red)
call jcolor#highlight('DiffText', s:palette.bg0, s:palette.blue)
call jcolor#highlight('Directory', s:palette.green, s:palette.none)
call jcolor#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call jcolor#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call jcolor#highlight('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('MatchParen', s:palette.none, s:palette.bg4)
call jcolor#highlight('NonText', s:palette.bg4, s:palette.none)
call jcolor#highlight('Whitespace', s:palette.bg4, s:palette.none)
call jcolor#highlight('SpecialKey', s:palette.bg4, s:palette.none)
call jcolor#highlight('Pmenu', s:palette.fg, s:palette.bg2)
call jcolor#highlight('PmenuSbar', s:palette.none, s:palette.bg2)
if s:configuration.menu_selection_background ==# 'blue'
  call jcolor#highlight('PmenuSel', s:palette.bg0, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
  call jcolor#highlight('PmenuSel', s:palette.bg0, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call jcolor#highlight('PmenuSel', s:palette.bg0, s:palette.bg_red)
endif
highlight! link WildMenu PmenuSel
call jcolor#highlight('PmenuThumb', s:palette.none, s:palette.grey)
call jcolor#highlight('NormalFloat', s:palette.fg, s:palette.bg2)
call jcolor#highlight('Question', s:palette.yellow, s:palette.none)
call jcolor#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
call jcolor#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
call jcolor#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
call jcolor#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
call jcolor#highlight('StatusLine', s:palette.fg, s:palette.bg3)
call jcolor#highlight('StatusLineTerm', s:palette.fg, s:palette.bg3)
call jcolor#highlight('StatusLineNC', s:palette.grey, s:palette.bg1)
call jcolor#highlight('StatusLineTermNC', s:palette.grey, s:palette.bg1)
call jcolor#highlight('TabLine', s:palette.fg, s:palette.bg01)
call jcolor#highlight('TabLineFill', s:palette.grey, s:palette.bg01)
call jcolor#highlight('TabLineSel', s:palette.green, s:palette.bg4, 'bold')
call jcolor#highlight('VertSplit', s:palette.black, s:palette.none)
call jcolor#highlight('Visual', s:palette.none, s:palette.bg3)
call jcolor#highlight('VisualNOS', s:palette.none, s:palette.bg3, 'underline')
call jcolor#highlight('QuickFixLine', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('Debug', s:palette.yellow, s:palette.none)
call jcolor#highlight('debugPC', s:palette.bg0, s:palette.green)
call jcolor#highlight('debugBreakpoint', s:palette.bg0, s:palette.red)
call jcolor#highlight('ToolbarButton', s:palette.bg0, s:palette.bg_blue)
if has('nvim')
  call jcolor#highlight('Substitute', s:palette.bg0, s:palette.yellow)
  highlight! link LspDiagnosticsFloatingError ErrorFloat
  highlight! link LspDiagnosticsFloatingWarning WarningFloat
  highlight! link LspDiagnosticsFloatingInformation InfoFloat
  highlight! link LspDiagnosticsFloatingHint HintFloat
  highlight! link LspDiagnosticsDefaultError ErrorText
  highlight! link LspDiagnosticsDefaultWarning WarningText
  highlight! link LspDiagnosticsDefaultInformation InfoText
  highlight! link LspDiagnosticsDefaultHint HintText
  highlight! link LspDiagnosticsVirtualTextError VirtualTextError
  highlight! link LspDiagnosticsVirtualTextWarning VirtualTextWarning
  highlight! link LspDiagnosticsVirtualTextInformation VirtualTextInfo
  highlight! link LspDiagnosticsVirtualTextHint VirtualTextHint
  highlight! link LspDiagnosticsUnderlineError ErrorText
  highlight! link LspDiagnosticsUnderlineWarning WarningText
  highlight! link LspDiagnosticsUnderlineInformation InfoText
  highlight! link LspDiagnosticsUnderlineHint HintText
  highlight! link LspDiagnosticsSignError RedSign
  highlight! link LspDiagnosticsSignWarning YellowSign
  highlight! link LspDiagnosticsSignInformation BlueSign
  highlight! link LspDiagnosticsSignHint GreenSign
  highlight! link LspReferenceText CurrentWord
  highlight! link LspReferenceRead CurrentWord
  highlight! link LspReferenceWrite CurrentWord
  highlight! link TermCursor Cursor
  highlight! link healthError Red
  highlight! link healthSuccess Green
  highlight! link healthWarning Yellow
endif
" }}}
" Xcode: {{{
call jcolor#highlight('xPlainText', s:palette.fg, s:palette.none)
call jcolor#highlight('xComments', s:palette.grey, s:palette.none)
call jcolor#highlight('xCommentsKeywords', s:palette.grey2, s:palette.none, 'bold')
call jcolor#highlight('xStrings', s:palette.red2, s:palette.none)
call jcolor#highlight('xCharactersNumbers', s:palette.yellow, s:palette.none)
call jcolor#highlight('xKeywords', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('xPreprocessor', s:palette.orange, s:palette.none)
call jcolor#highlight('xURLs', s:palette.blue3, s:palette.none)
call jcolor#highlight('xAttributes', s:palette.orange2, s:palette.none)
call jcolor#highlight('xDeclarations', s:palette.blue4, s:palette.none)
call jcolor#highlight('xFunctions', s:palette.green, s:palette.none)
call jcolor#highlight('xType', s:palette.blue, s:palette.none)
call jcolor#highlight('xField', s:palette.blue2, s:palette.none)
call jcolor#highlight('xOtherType', s:palette.purple, s:palette.none)
call jcolor#highlight('xOtherField', s:palette.purple2, s:palette.none)

" }}}
" Syntax: {{{
"
highlight! link Delimiter      xPlainText

highlight! link Comment        xComments
highlight! link SpecialComment xCommentsKeywords
highlight! link Todo           xCommentsKeywords

highlight! link Special        xStrings
highlight! link SpecialChar    xStrings
highlight! link String         xStrings

highlight! link Character      xCharactersNumbers
highlight! link Number         xCharactersNumbers
highlight! link Float          xCharactersNumbers

highlight! link Keyword        xKeywords
highlight! link Define         xKeywords
highlight! link Typedef        xKeywords
highlight! link Exception      xKeywords
highlight! link Repeat         xKeywords
highlight! link Statement      xKeywords
highlight! link Error          xKeywords
highlight! link Label          xKeywords
highlight! link Structure      xKeywords
highlight! link StorageClass   xKeywords
highlight! link Label          xKeywords
highlight! link Boolean        xKeywords
highlight! link Operator       xKeywords

highlight! link Macro          xPreprocessor
highlight! link PreProc        xPreprocessor
highlight! link PreCondit      xPreprocessor
highlight! link Include        xPreprocessor

highlight! link Function       xFunctions
highlight! link Tag            xFunctions

highlight! link Type           xType
highlight! link Constant       xField

highlight! link TypeBuiltin    xOtherType
highlight! link ConstantBuiltin xOtherField
highlight! link Identifier     xOtherType
highlight! link Title          xOtherType


call jcolor#highlight('Underlined', s:palette.none, s:palette.none, 'underline')

" }}}
" Predefined Highlight Groups: {{{
call jcolor#highlight('Fg', s:palette.fg, s:palette.none)
call jcolor#highlight('Grey', s:palette.grey, s:palette.none)
call jcolor#highlight('Red', s:palette.red, s:palette.none)
call jcolor#highlight('Orange', s:palette.orange, s:palette.none)
call jcolor#highlight('Yellow', s:palette.yellow, s:palette.none)
call jcolor#highlight('Green', s:palette.green, s:palette.none)
call jcolor#highlight('Blue', s:palette.blue, s:palette.none)
call jcolor#highlight('Purple', s:palette.purple, s:palette.none)
if s:configuration.enable_italic
  call jcolor#highlight('RedItalic', s:palette.red, s:palette.none, 'italic')
  call jcolor#highlight('OrangeItalic', s:palette.orange, s:palette.none, 'italic')
  call jcolor#highlight('YellowItalic', s:palette.yellow, s:palette.none, 'italic')
  call jcolor#highlight('GreenItalic', s:palette.green, s:palette.none, 'italic')
  call jcolor#highlight('BlueItalic', s:palette.blue, s:palette.none, 'italic')
  call jcolor#highlight('PurpleItalic', s:palette.purple, s:palette.none, 'italic')
else
  call jcolor#highlight('RedItalic', s:palette.red, s:palette.none)
  call jcolor#highlight('OrangeItalic', s:palette.orange, s:palette.none)
  call jcolor#highlight('YellowItalic', s:palette.yellow, s:palette.none)
  call jcolor#highlight('GreenItalic', s:palette.green, s:palette.none)
  call jcolor#highlight('BlueItalic', s:palette.blue, s:palette.none)
  call jcolor#highlight('PurpleItalic', s:palette.purple, s:palette.none)
endif
call jcolor#highlight('RedSign', s:palette.red, s:palette.none)
call jcolor#highlight('OrangeSign', s:palette.orange, s:palette.none)
call jcolor#highlight('YellowSign', s:palette.yellow, s:palette.none)
call jcolor#highlight('GreenSign', s:palette.green, s:palette.none)
call jcolor#highlight('BlueSign', s:palette.blue, s:palette.none)
call jcolor#highlight('PurpleSign', s:palette.purple, s:palette.none)
if s:configuration.diagnostic_text_highlight
  call jcolor#highlight('ErrorText', s:palette.none, s:palette.diff_red, 'undercurl', s:palette.red)
  call jcolor#highlight('WarningText', s:palette.none, s:palette.diff_yellow, 'undercurl', s:palette.yellow)
  call jcolor#highlight('InfoText', s:palette.none, s:palette.diff_blue, 'undercurl', s:palette.blue)
  call jcolor#highlight('HintText', s:palette.none, s:palette.diff_green, 'undercurl', s:palette.green)
else
  call jcolor#highlight('ErrorText', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
  call jcolor#highlight('WarningText', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
  call jcolor#highlight('InfoText', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
  call jcolor#highlight('HintText', s:palette.none, s:palette.none, 'undercurl', s:palette.green)
endif
if s:configuration.diagnostic_line_highlight
  call jcolor#highlight('ErrorLine', s:palette.none, s:palette.diff_red)
  call jcolor#highlight('WarningLine', s:palette.none, s:palette.diff_yellow)
  call jcolor#highlight('InfoLine', s:palette.none, s:palette.diff_blue)
  call jcolor#highlight('HintLine', s:palette.none, s:palette.diff_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextWarning Grey
  highlight! link VirtualTextError Grey
  highlight! link VirtualTextInfo Grey
  highlight! link VirtualTextHint Grey
else
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextError Red
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
endif
call jcolor#highlight('ErrorFloat', s:palette.red, s:palette.bg2)
call jcolor#highlight('WarningFloat', s:palette.yellow, s:palette.bg2)
call jcolor#highlight('InfoFloat', s:palette.blue, s:palette.bg2)
call jcolor#highlight('HintFloat', s:palette.green, s:palette.bg2)
if &diff
  call jcolor#highlight('CurrentWord', s:palette.bg0, s:palette.green)
elseif s:configuration.current_word ==# 'grey background'
  call jcolor#highlight('CurrentWord', s:palette.none, s:palette.bg2)
else
  call jcolor#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif
" }}}
" }}}
" Terminal: {{{
if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Definition
  let s:terminal = {
        \ 'black':    s:palette.black,
        \ 'red':      s:palette.red,
        \ 'yellow':   s:palette.yellow,
        \ 'green':    s:palette.green,
        \ 'cyan':     s:palette.orange,
        \ 'blue':     s:palette.blue,
        \ 'purple':   s:palette.purple,
        \ 'white':    s:palette.fg
        \ }
  " Implementation: {{{
  if !has('nvim')
    let g:terminal_ansi_colors = [s:terminal.black[0], s:terminal.red[0], s:terminal.green[0], s:terminal.yellow[0],
          \ s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0], s:terminal.black[0], s:terminal.red[0],
          \ s:terminal.green[0], s:terminal.yellow[0], s:terminal.blue[0], s:terminal.purple[0], s:terminal.cyan[0], s:terminal.white[0]]
  else
    let g:terminal_color_0 = s:terminal.black[0]
    let g:terminal_color_1 = s:terminal.red[0]
    let g:terminal_color_2 = s:terminal.green[0]
    let g:terminal_color_3 = s:terminal.yellow[0]
    let g:terminal_color_4 = s:terminal.blue[0]
    let g:terminal_color_5 = s:terminal.purple[0]
    let g:terminal_color_6 = s:terminal.cyan[0]
    let g:terminal_color_7 = s:terminal.white[0]
    let g:terminal_color_8 = s:terminal.black[0]
    let g:terminal_color_9 = s:terminal.red[0]
    let g:terminal_color_10 = s:terminal.green[0]
    let g:terminal_color_11 = s:terminal.yellow[0]
    let g:terminal_color_12 = s:terminal.blue[0]
    let g:terminal_color_13 = s:terminal.purple[0]
    let g:terminal_color_14 = s:terminal.cyan[0]
    let g:terminal_color_15 = s:terminal.white[0]
  endif
  " }}}
endif
" }}}
" Plugins: {{{
" nvim-treesitter/nvim-treesitter {{{
call jcolor#highlight('TSStrong', s:palette.none, s:palette.none, 'bold')
call jcolor#highlight('TSEmphasis', s:palette.none, s:palette.none, 'bold')
call jcolor#highlight('TSUnderline', s:palette.none, s:palette.none, 'underline')
call jcolor#highlight('TSNote', s:palette.bg0, s:palette.blue, 'bold')
call jcolor#highlight('TSWarning', s:palette.bg0, s:palette.yellow, 'bold')
call jcolor#highlight('TSDanger', s:palette.bg0, s:palette.red, 'bold')
highlight! link TSAnnotation xAttributes
highlight! link TSAttribute xAttributes
highlight! link TSBoolean Keyword
highlight! link TSCharacter Character
highlight! link TSComment Comment
highlight! link TSConditional Keyword
highlight! link TSConstBuiltin xOtherField
highlight! link TSConstMacro Macro
highlight! link TSConstant Constant
highlight! link TSConstructor Function
highlight! link TSException Keyword
highlight! link TSField xField
highlight! link TSFloat Float
highlight! link TSFuncBuiltin Function
highlight! link TSFuncMacro Macro
highlight! link TSFunction Function
highlight! link TSInclude Include
highlight! link TSKeyword Keyword
highlight! link TSKeywordFunction Keyword
highlight! link TSKeywordOperator Keyword
highlight! link TSLabel Label
highlight! link TSMethod Function
highlight! link TSNamespace Type
highlight! link TSNone Fg
highlight! link TSNumber Number
highlight! link TSOperator Keyword
highlight! link TSParameter Fg
highlight! link TSParameterReference Fg
highlight! link TSProperty xField
highlight! link TSPunctBracket Grey
highlight! link TSPunctDelimiter Grey
highlight! link TSPunctSpecial Yellow
highlight! link TSRepeat Keyword
highlight! link TSString String
highlight! link TSStringEscape Character
highlight! link TSStringRegex Character
highlight! link TSStructure Structure
highlight! link TSSymbol Fg
highlight! link TSTag Tag
highlight! link TSTagDelimiter Keyword
highlight! link TSText Green
highlight! link TSStrike Grey
highlight! link TSMath Yellow
highlight! link TSType Type
highlight! link TSTypeBuiltin xOtherType
highlight! link TSURI xURLs
highlight! link TSVariable Fg
highlight! link TSVariableBuiltin xOtherField
" }}}
" neoclide/coc.nvim {{{
call jcolor#highlight('CocHoverRange', s:palette.none, s:palette.none, 'bold,underline')
highlight! link CocSem_angle TSTagDelimiter
highlight! link CocSem_annotation TSOperator
highlight! link CocSem_attribute TSAttribute
highlight! link CocSem_bitwise TSOperator
highlight! link CocSem_boolean TSBoolean
highlight! link CocSem_brace TSPunctBracket
highlight! link CocSem_bracket TSPunctBracket
highlight! link CocSem_builtinAttribute TSAttribute
highlight! link CocSem_builtinType TSTypeBuiltin
highlight! link CocSem_character TSCharacter
highlight! link CocSem_class TSType
highlight! link CocSem_colon TSPunctDelimiter
highlight! link CocSem_comma TSPunctDelimiter
highlight! link CocSem_comment TSComment
highlight! link CocSem_comparison TSOperator
highlight! link CocSem_constParameter TSParameter
highlight! link CocSem_dependent TSInclude
highlight! link CocSem_dot TSOperator
highlight! link CocSem_enum TSType
highlight! link CocSem_enumMember TSField
highlight! link CocSem_escapeSequence TSStringEscape
highlight! link CocSem_event TSType
highlight! link CocSem_formatSpecifier TSStringEscape
highlight! link CocSem_function TSFunction
highlight! link CocSem_interface TSType
highlight! link CocSem_keyword TSKeyword
highlight! link CocSem_label TSLabel
highlight! link CocSem_logical TSOperator
highlight! link CocSem_macro TSConstMacro
highlight! link CocSem_method TSMethod
highlight! link CocSem_modifier TSKeywordOperator
highlight! link CocSem_namespace TSNamespace
highlight! link CocSem_number TSNumber
highlight! link CocSem_operator TSOperator
highlight! link CocSem_parameter TSParameter
highlight! link CocSem_parenthesis TSPunctBracket
highlight! link CocSem_property TSField
highlight! link CocSem_punctuation TSOperator
highlight! link CocSem_regexp TSStringRegex
highlight! link CocSem_selfKeyword TSKeyword
highlight! link CocSem_semicolon TSPunctDelimiter
highlight! link CocSem_string TSString
highlight! link CocSem_struct TSStructure
highlight! link CocSem_type TSType
highlight! link CocSem_typeAlias TSType
highlight! link CocSem_typeParameter TSType
highlight! link CocSem_variable TSVariable
highlight! link CocErrorFloat ErrorFloat
highlight! link CocWarningFloat WarningFloat
highlight! link CocInfoFloat InfoFloat
highlight! link CocHintFloat HintFloat
highlight! link CocErrorHighlight ErrorText
highlight! link CocWarningHighlight WarningText
highlight! link CocInfoHighlight InfoText
highlight! link CocHintHighlight HintText
highlight! link CocHighlightText CurrentWord
highlight! link CocHoverRange CurrentWord
highlight! link CocErrorSign RedSign
highlight! link CocWarningSign YellowSign
highlight! link CocInfoSign BlueSign
highlight! link CocHintSign GreenSign
highlight! link CocWarningVirtualText VirtualTextWarning
highlight! link CocErrorVirtualText VirtualTextError
highlight! link CocInfoVirtualText VirtualTextInfo
highlight! link CocHintVirtualText VirtualTextHint
highlight! link CocErrorLine ErrorLine
highlight! link CocWarningLine WarningLine
highlight! link CocInfoLine InfoLine
highlight! link CocHintLine HintLine
highlight! link CocCodeLens Grey
highlight! link CocFadeOut Grey
highlight! link CocStrikeThrough Grey
highlight! link CocListMode StatusLine
highlight! link CocListPath StatusLine
highlight! link CocTreeOpenClose Grey
highlight! link HighlightedyankRegion Visual
highlight! link CocSymbolFile Fg
highlight! link CocSymbolModule TSNamespace
highlight! link CocSymbolNamespace TSNamespace
highlight! link CocSymbolPackage TSNamespace
highlight! link CocSymbolClass TSType
highlight! link CocSymbolMethod TSMethod
highlight! link CocSymbolProperty TSProperty
highlight! link CocSymbolField TSField
highlight! link CocSymbolConstructor TSConstructor
highlight! link CocSymbolEnum TSStructure
highlight! link CocSymbolInterface TSType
highlight! link CocSymbolFunction TSFunction
highlight! link CocSymbolVariable TSVariable
highlight! link CocSymbolConstant TSConstant
highlight! link CocSymbolString TSString
highlight! link CocSymbolNumber TSNumber
highlight! link CocSymbolBoolean TSBoolean
highlight! link CocSymbolArray TSVariable
highlight! link CocSymbolObject TSVariable
highlight! link CocSymbolKey TSType
highlight! link CocSymbolNull TSVariableBuiltin
highlight! link CocSymbolEnumMember TSProperty
highlight! link CocSymbolStruct TSStructure
highlight! link CocSymbolEvent TSLabel
highlight! link CocSymbolOperator TSOperator
highlight! link CocSymbolTypeParameter TSType
highlight! link CocSymbolDefault TSNone
highlight! link CocGitAddedSign GreenSign
highlight! link CocGitChangeRemovedSign PurpleSign
highlight! link CocGitChangedSign BlueSign
highlight! link CocGitRemovedSign RedSign
highlight! link CocGitTopRemovedSign RedSign
highlight! link CocExplorerBufferRoot Red
highlight! link CocExplorerBufferExpandIcon Blue
highlight! link CocExplorerBufferBufnr Yellow
highlight! link CocExplorerBufferModified Yellow
highlight! link CocExplorerBufferReadonly Red
highlight! link CocExplorerBufferBufname Grey
highlight! link CocExplorerBufferFullpath Grey
highlight! link CocExplorerFileRoot Red
highlight! link CocExplorerFileRootName Green
highlight! link CocExplorerFileExpandIcon Blue
highlight! link CocExplorerFileFullpath Grey
highlight! link CocExplorerFileDirectory Green
highlight! link CocExplorerFileGitStaged Purple
highlight! link CocExplorerFileGitUnstaged Yellow
highlight! link CocExplorerFileGitRootStaged Purple
highlight! link CocExplorerFileGitRootUnstaged Yellow
highlight! link CocExplorerGitPathChange Fg
highlight! link CocExplorerGitContentChange Fg
highlight! link CocExplorerGitRenamed Purple
highlight! link CocExplorerGitCopied Fg
highlight! link CocExplorerGitAdded Green
highlight! link CocExplorerGitUntracked Blue
highlight! link CocExplorerGitUnmodified Fg
highlight! link CocExplorerGitUnmerged Orange
highlight! link CocExplorerGitMixed Fg
highlight! link CocExplorerGitModified Yellow
highlight! link CocExplorerGitDeleted Red
highlight! link CocExplorerGitIgnored Grey
highlight! link CocExplorerFileSize Blue
highlight! link CocExplorerTimeAccessed Purple
highlight! link CocExplorerTimeCreated Purple
highlight! link CocExplorerTimeModified Purple
highlight! link CocExplorerFileRootName Orange
highlight! link CocExplorerBufferNameVisible Green
highlight! link CocExplorerIndentLine Conceal
highlight! link CocExplorerHelpDescription Grey
highlight! link CocExplorerHelpHint Grey
" }}}
" prabirshrestha/vim-lsp {{{
highlight! link LspErrorVirtual VirtualTextError
highlight! link LspWarningVirtual VirtualTextWarning
highlight! link LspInformationVirtual VirtualTextInfo
highlight! link LspHintVirtual VirtualTextHint
highlight! link LspErrorHighlight ErrorText
highlight! link LspWarningHighlight WarningText
highlight! link LspInformationHighlight InfoText
highlight! link LspHintHighlight HintText
highlight! link lspReference CurrentWord
" }}}
" neomake/neomake {{{
highlight! link NeomakeError ErrorText
highlight! link NeomakeWarning WarningText
highlight! link NeomakeInfo InfoText
highlight! link NeomakeMessage HintText
highlight! link NeomakeErrorSign RedSign
highlight! link NeomakeWarningSign YellowSign
highlight! link NeomakeInfoSign BlueSign
highlight! link NeomakeMessageSign GreenSign
highlight! link NeomakeVirtualtextError VirtualTextError
highlight! link NeomakeVirtualtextWarning VirtualTextWarning
highlight! link NeomakeVirtualtextInfo VirtualTextInfo
highlight! link NeomakeVirtualtextMessag VirtualTextHint
" }}}
" Yggdroot/LeaderF{{{
if !exists('g:Lf_StlColorscheme')
  let g:Lf_StlColorscheme = 'one'
endif
call jcolor#highlight('Lf_hl_match', s:palette.green, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_match0', s:palette.green, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_match1', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_match2', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_match3', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_match4', s:palette.purple, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_matchRefine', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('Lf_hl_popup_normalMode', s:palette.bg0, s:palette.blue, 'bold')
call jcolor#highlight('Lf_hl_popup_inputMode', s:palette.bg0, s:palette.green, 'bold')
call jcolor#highlight('Lf_hl_popup_category', s:palette.fg, s:palette.bg4)
call jcolor#highlight('Lf_hl_popup_nameOnlyMode', s:palette.fg, s:palette.bg3)
call jcolor#highlight('Lf_hl_popup_fullPathMode', s:palette.fg, s:palette.bg3)
call jcolor#highlight('Lf_hl_popup_fuzzyMode', s:palette.fg, s:palette.bg3)
call jcolor#highlight('Lf_hl_popup_regexMode', s:palette.fg, s:palette.bg3)
call jcolor#highlight('Lf_hl_popup_lineInfo', s:palette.bg0, s:palette.blue)
call jcolor#highlight('Lf_hl_popup_total', s:palette.bg0, s:palette.red)
call jcolor#highlight('Lf_hl_popup_cursor', s:palette.bg0, s:palette.blue)
highlight! link Lf_hl_cursorline Fg
highlight! link Lf_hl_selection DiffAdd
highlight! link Lf_hl_rgHighlight Visual
highlight! link Lf_hl_gtagsHighlight Visual
highlight! link Lf_hl_popup_inputText Pmenu
highlight! link Lf_hl_popup_window Pmenu
highlight! link Lf_hl_popup_prompt Blue
highlight! link Lf_hl_popup_cwd Pmenu
highlight! link Lf_hl_popup_blank Lf_hl_popup_window
highlight! link Lf_hl_popup_spin Purple
" }}}
" nvim-telescope/telescope.nvim {{{
call jcolor#highlight('TelescopeMatching', s:palette.green, s:palette.none, 'bold')
highlight! link TelescopeBorder Grey
highlight! link TelescopePromptPrefix Blue
highlight! link TelescopeSelection DiffAdd
" }}}
" airblade/vim-gitgutter {{{
highlight! link GitGutterAdd GreenSign
highlight! link GitGutterChange BlueSign
highlight! link GitGutterDelete RedSign
highlight! link GitGutterChangeDelete PurpleSign
" }}}
" easymotion/vim-easymotion {{{
highlight! link EasyMotionTarget Search
highlight! link EasyMotionShade Grey
" }}}
" }}}
" Extended File Types: {{{
" Whitelist: {{{ File type optimizations that will always be loaded.
" diff {{{
highlight! link diffAdded Green
highlight! link diffRemoved Red
highlight! link diffChanged Blue
highlight! link diffOldFile Yellow
highlight! link diffNewFile Orange
highlight! link diffFile Purple
highlight! link diffLine Grey
highlight! link diffIndexLine Purple
" }}}
" }}}
" Generate the `after/ftplugin` directory based on the comment tags in this file.
" For example, the content between `ft_begin: sh/zsh` and `ft_end` will be placed in `after/ftplugin/sh/jcolor.vim` and `after/ftplugin/zsh/jcolor.vim`.
if jcolor#ft_exists(s:path) " If the ftplugin exists.
  if s:configuration.better_performance
    if !jcolor#ft_newest(s:path, s:last_modified) " Regenerate if it's not up to date.
      call jcolor#ft_clean(s:path, 0)
      call jcolor#ft_gen(s:path, s:last_modified, 'update')
    endif
    finish
  else
    call jcolor#ft_clean(s:path, 1)
  endif
else
  if s:configuration.better_performance
    call jcolor#ft_gen(s:path, s:last_modified, 'generate')
    finish
  endif
endif
" ft_begin: nerdtree {{{
" https://github.com/preservim/nerdtree
highlight! link NERDTreeDir Green
highlight! link NERDTreeDirSlash Green
highlight! link NERDTreeOpenable Blue
highlight! link NERDTreeClosable Blue
highlight! link NERDTreeFile Fg
highlight! link NERDTreeExecFile Red
highlight! link NERDTreeUp Grey
highlight! link NERDTreeCWD Purple
highlight! link NERDTreeHelp Grey
highlight! link NERDTreeToggleOn Green
highlight! link NERDTreeToggleOff Red
highlight! link NERDTreeFlags Blue
highlight! link NERDTreeLinkFile Grey
highlight! link NERDTreeLinkTarget Green
" ft_end }}}
" ft_begin: NvimTree {{{
" https://github.com/kyazdani42/nvim-tree.lua
highlight! link NvimTreeSymlink Fg
highlight! link NvimTreeFolderName Green
highlight! link NvimTreeRootFolder Grey
highlight! link NvimTreeFolderIcon Blue
highlight! link NvimTreeEmptyFolderName Green
highlight! link NvimTreeOpenedFolderName Green
highlight! link NvimTreeExecFile Fg
highlight! link NvimTreeOpenedFile Fg
highlight! link NvimTreeSpecialFile Fg
highlight! link NvimTreeImageFile Fg
highlight! link NvimTreeMarkdownFile Fg
highlight! link NvimTreeIndentMarker Grey
highlight! link NvimTreeGitDirty Yellow
highlight! link NvimTreeGitStaged Blue
highlight! link NvimTreeGitMerge Orange
highlight! link NvimTreeGitRenamed Purple
highlight! link NvimTreeGitNew Green
highlight! link NvimTreeGitDeleted Red
" ft_end }}}
" ft_begin: undotree {{{
" https://github.com/mbbill/undotree
call jcolor#highlight('UndotreeSavedBig', s:palette.red, s:palette.none, 'bold')
highlight! link UndotreeNode Blue
highlight! link UndotreeNodeCurrent Purple
highlight! link UndotreeSeq Green
highlight! link UndotreeCurrent Blue
highlight! link UndotreeNext Yellow
highlight! link UndotreeTimeStamp Grey
highlight! link UndotreeHead Purple
highlight! link UndotreeBranch Blue
highlight! link UndotreeSavedSmall Red
" ft_end }}}
" ft_begin: markdown {{{
" builtin: {{{
call jcolor#highlight('markdownH1', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('markdownH2', s:palette.orange, s:palette.none, 'bold')
call jcolor#highlight('markdownH3', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('markdownH4', s:palette.green, s:palette.none, 'bold')
call jcolor#highlight('markdownH5', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('markdownH6', s:palette.purple, s:palette.none, 'bold')
call jcolor#highlight('markdownUrl', s:palette.blue, s:palette.none, 'underline')
call jcolor#highlight('markdownItalic', s:palette.none, s:palette.none, 'italic')
call jcolor#highlight('markdownBold', s:palette.none, s:palette.none, 'bold')
call jcolor#highlight('markdownItalicDelimiter', s:palette.grey, s:palette.none, 'italic')
highlight! link markdownCode Green
highlight! link markdownCodeBlock Green
highlight! link markdownCodeDelimiter Green
highlight! link markdownBlockquote Grey
highlight! link markdownListMarker Red
highlight! link markdownOrderedListMarker Red
highlight! link markdownRule Purple
highlight! link markdownHeadingRule Grey
highlight! link markdownUrlDelimiter Grey
highlight! link markdownLinkDelimiter Grey
highlight! link markdownLinkTextDelimiter Grey
highlight! link markdownHeadingDelimiter Grey
highlight! link markdownLinkText Red
highlight! link markdownUrlTitleDelimiter Green
highlight! link markdownIdDeclaration markdownLinkText
highlight! link markdownBoldDelimiter Grey
highlight! link markdownId Yellow
" }}}
" vim-markdown: https://github.com/gabrielelana/vim-markdown{{{
call jcolor#highlight('mkdURL', s:palette.blue, s:palette.none, 'underline')
call jcolor#highlight('mkdInlineURL', s:palette.blue, s:palette.none, 'underline')
call jcolor#highlight('mkdItalic', s:palette.grey, s:palette.none, 'italic')
highlight! link mkdCodeDelimiter Green
highlight! link mkdBold Grey
highlight! link mkdLink Red
highlight! link mkdHeading Grey
highlight! link mkdListItem Red
highlight! link mkdRule Purple
highlight! link mkdDelimiter Grey
highlight! link mkdId Yellow
" }}}
" ft_end }}}
" ft_begin: html/markdown/javascriptreact/typescriptreact {{{
" builtin: https://notabug.org/jorgesumle/vim-html-syntax{{{
call jcolor#highlight('htmlH1', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('htmlH2', s:palette.orange, s:palette.none, 'bold')
call jcolor#highlight('htmlH3', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('htmlH4', s:palette.green, s:palette.none, 'bold')
call jcolor#highlight('htmlH5', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('htmlH6', s:palette.purple, s:palette.none, 'bold')
call jcolor#highlight('htmlLink', s:palette.none, s:palette.none, 'underline')
call jcolor#highlight('htmlBold', s:palette.none, s:palette.none, 'bold')
call jcolor#highlight('htmlBoldUnderline', s:palette.none, s:palette.none, 'bold,underline')
call jcolor#highlight('htmlBoldItalic', s:palette.none, s:palette.none, 'bold,italic')
call jcolor#highlight('htmlBoldUnderlineItalic', s:palette.none, s:palette.none, 'bold,underline,italic')
call jcolor#highlight('htmlUnderline', s:palette.none, s:palette.none, 'underline')
call jcolor#highlight('htmlUnderlineItalic', s:palette.none, s:palette.none, 'underline,italic')
call jcolor#highlight('htmlItalic', s:palette.none, s:palette.none, 'italic')
highlight! link htmlTag Green
highlight! link htmlEndTag Blue
highlight! link htmlTagN RedItalic
highlight! link htmlTagName RedItalic
highlight! link htmlArg Blue
highlight! link htmlScriptTag Purple
highlight! link htmlSpecialTagName RedItalic
highlight! link htmlString Green
" }}}
" ft_end }}}
" ft_begin: xml {{{
" builtin: https://github.com/chrisbra/vim-xml-ftplugin{{{
highlight! link xmlTag Green
highlight! link xmlEndTag Blue
highlight! link xmlTagName RedItalic
highlight! link xmlEqual Orange
highlight! link xmlAttrib Blue
highlight! link xmlEntity Red
highlight! link xmlEntityPunct Red
highlight! link xmlDocTypeDecl Grey
highlight! link xmlDocTypeKeyword RedItalic
highlight! link xmlCdataStart Grey
highlight! link xmlCdataCdata Purple
highlight! link xmlString Green
" }}}
" ft_end }}}
" ft_begin: css/scss/sass/less {{{
" builtin: https://github.com/JulesWang/css.vim{{{
highlight! link cssStringQ Green
highlight! link cssStringQQ Green
highlight! link cssAttrComma Grey
highlight! link cssBraces Grey
highlight! link cssTagName Purple
highlight! link cssClassNameDot Grey
highlight! link cssClassName Red
highlight! link cssFunctionName Orange
highlight! link cssAttr Green
highlight! link cssCommonAttr Green
highlight! link cssProp Blue
highlight! link cssPseudoClassId Yellow
highlight! link cssPseudoClassFn Green
highlight! link cssPseudoClass Yellow
highlight! link cssImportant Red
highlight! link cssSelectorOp Orange
highlight! link cssSelectorOp2 Orange
highlight! link cssColor Green
highlight! link cssUnitDecorators Green
highlight! link cssValueLength Green
highlight! link cssValueInteger Green
highlight! link cssValueNumber Green
highlight! link cssValueAngle Green
highlight! link cssValueTime Green
highlight! link cssValueFrequency Green
highlight! link cssVendor Grey
highlight! link cssNoise Grey
" }}}
" ft_end }}}
" ft_begin: javascript/javascriptreact {{{
" builtin: http://www.fleiner.com/vim/syntax/javascript.vim{{{
highlight! link javaScriptNull OrangeItalic
highlight! link javaScriptIdentifier BlueItalic
highlight! link javaScriptParens Fg
highlight! link javaScriptBraces Fg
highlight! link javaScriptNumber Purple
highlight! link javaScriptLabel Red
highlight! link javaScriptGlobal BlueItalic
highlight! link javaScriptMessage BlueItalic
" }}}
" vim-javascript: https://github.com/pangloss/vim-javascript{{{
highlight! link jsNoise Fg
highlight! link Noise Fg
highlight! link jsParens Fg
highlight! link jsBrackets Fg
highlight! link jsObjectBraces Fg
highlight! link jsThis BlueItalic
highlight! link jsUndefined OrangeItalic
highlight! link jsNull OrangeItalic
highlight! link jsNan OrangeItalic
highlight! link jsSuper OrangeItalic
highlight! link jsPrototype OrangeItalic
highlight! link jsFunction Red
highlight! link jsGlobalNodeObjects BlueItalic
highlight! link jsGlobalObjects BlueItalic
highlight! link jsArrowFunction Red
highlight! link jsArrowFuncArgs Fg
highlight! link jsFuncArgs Fg
highlight! link jsObjectProp Fg
highlight! link jsVariableDef Fg
highlight! link jsObjectKey Fg
highlight! link jsParen Fg
highlight! link jsParenIfElse Fg
highlight! link jsParenRepeat Fg
highlight! link jsParenSwitch Fg
highlight! link jsParenCatch Fg
highlight! link jsBracket Fg
highlight! link jsObjectValue Fg
highlight! link jsDestructuringBlock Fg
highlight! link jsBlockLabel Purple
highlight! link jsFunctionKey Green
highlight! link jsClassDefinition BlueItalic
highlight! link jsDot Grey
highlight! link jsSpreadExpression Purple
highlight! link jsSpreadOperator Green
highlight! link jsModuleKeyword BlueItalic
highlight! link jsTemplateExpression Purple
highlight! link jsTemplateBraces Purple
highlight! link jsClassMethodType BlueItalic
highlight! link jsExceptions BlueItalic
" }}}
" yajs: https://github.com/othree/yajs.vim{{{
highlight! link javascriptOpSymbol Red
highlight! link javascriptOpSymbols Red
highlight! link javascriptIdentifierName Fg
highlight! link javascriptVariable BlueItalic
highlight! link javascriptObjectLabel Fg
highlight! link javascriptPropertyNameString Fg
highlight! link javascriptFuncArg Fg
highlight! link javascriptObjectLiteral Green
highlight! link javascriptIdentifier OrangeItalic
highlight! link javascriptArrowFunc Red
highlight! link javascriptTemplate Purple
highlight! link javascriptTemplateSubstitution Purple
highlight! link javascriptTemplateSB Purple
highlight! link javascriptNodeGlobal BlueItalic
highlight! link javascriptDocTags RedItalic
highlight! link javascriptDocNotation Blue
highlight! link javascriptClassSuper OrangeItalic
highlight! link javascriptClassName BlueItalic
highlight! link javascriptClassSuperName BlueItalic
highlight! link javascriptOperator Red
highlight! link javascriptBrackets Fg
highlight! link javascriptBraces Fg
highlight! link javascriptLabel Purple
highlight! link javascriptEndColons Grey
highlight! link javascriptObjectLabelColon Grey
highlight! link javascriptDotNotation Grey
highlight! link javascriptGlobalArrayDot Grey
highlight! link javascriptGlobalBigIntDot Grey
highlight! link javascriptGlobalDateDot Grey
highlight! link javascriptGlobalJSONDot Grey
highlight! link javascriptGlobalMathDot Grey
highlight! link javascriptGlobalNumberDot Grey
highlight! link javascriptGlobalObjectDot Grey
highlight! link javascriptGlobalPromiseDot Grey
highlight! link javascriptGlobalRegExpDot Grey
highlight! link javascriptGlobalStringDot Grey
highlight! link javascriptGlobalSymbolDot Grey
highlight! link javascriptGlobalURLDot Grey
highlight! link javascriptMethod Green
highlight! link javascriptMethodName Green
highlight! link javascriptObjectMethodName Green
highlight! link javascriptGlobalMethod Green
highlight! link javascriptDOMStorageMethod Green
highlight! link javascriptFileMethod Green
highlight! link javascriptFileReaderMethod Green
highlight! link javascriptFileListMethod Green
highlight! link javascriptBlobMethod Green
highlight! link javascriptURLStaticMethod Green
highlight! link javascriptNumberStaticMethod Green
highlight! link javascriptNumberMethod Green
highlight! link javascriptDOMNodeMethod Green
highlight! link javascriptES6BigIntStaticMethod Green
highlight! link javascriptBOMWindowMethod Green
highlight! link javascriptHeadersMethod Green
highlight! link javascriptRequestMethod Green
highlight! link javascriptResponseMethod Green
highlight! link javascriptES6SetMethod Green
highlight! link javascriptReflectMethod Green
highlight! link javascriptPaymentMethod Green
highlight! link javascriptPaymentResponseMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptGeolocationMethod Green
highlight! link javascriptES6MapMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptCacheMethod Green
highlight! link javascriptFunctionMethod Green
highlight! link javascriptXHRMethod Green
highlight! link javascriptBOMNavigatorMethod Green
highlight! link javascriptServiceWorkerMethod Green
highlight! link javascriptDOMEventTargetMethod Green
highlight! link javascriptDOMEventMethod Green
highlight! link javascriptIntlMethod Green
highlight! link javascriptDOMDocMethod Green
highlight! link javascriptStringStaticMethod Green
highlight! link javascriptStringMethod Green
highlight! link javascriptSymbolStaticMethod Green
highlight! link javascriptRegExpMethod Green
highlight! link javascriptObjectStaticMethod Green
highlight! link javascriptObjectMethod Green
highlight! link javascriptBOMLocationMethod Green
highlight! link javascriptJSONStaticMethod Green
highlight! link javascriptGeneratorMethod Green
highlight! link javascriptEncodingMethod Green
highlight! link javascriptPromiseStaticMethod Green
highlight! link javascriptPromiseMethod Green
highlight! link javascriptBOMHistoryMethod Green
highlight! link javascriptDOMFormMethod Green
highlight! link javascriptClipboardMethod Green
highlight! link javascriptTypedArrayStaticMethod Green
highlight! link javascriptBroadcastMethod Green
highlight! link javascriptDateStaticMethod Green
highlight! link javascriptDateMethod Green
highlight! link javascriptConsoleMethod Green
highlight! link javascriptArrayStaticMethod Green
highlight! link javascriptArrayMethod Green
highlight! link javascriptMathStaticMethod Green
highlight! link javascriptSubtleCryptoMethod Green
highlight! link javascriptCryptoMethod Green
highlight! link javascriptProp Fg
highlight! link javascriptBOMWindowProp Fg
highlight! link javascriptDOMStorageProp Fg
highlight! link javascriptFileReaderProp Fg
highlight! link javascriptURLUtilsProp Fg
highlight! link javascriptNumberStaticProp Fg
highlight! link javascriptDOMNodeProp Fg
highlight! link javascriptRequestProp Fg
highlight! link javascriptResponseProp Fg
highlight! link javascriptES6SetProp Fg
highlight! link javascriptPaymentProp Fg
highlight! link javascriptPaymentResponseProp Fg
highlight! link javascriptPaymentAddressProp Fg
highlight! link javascriptPaymentShippingOptionProp Fg
highlight! link javascriptTypedArrayStaticProp Fg
highlight! link javascriptServiceWorkerProp Fg
highlight! link javascriptES6MapProp Fg
highlight! link javascriptRegExpStaticProp Fg
highlight! link javascriptRegExpProp Fg
highlight! link javascriptXHRProp Fg
highlight! link javascriptBOMNavigatorProp Green
highlight! link javascriptDOMEventProp Fg
highlight! link javascriptBOMNetworkProp Fg
highlight! link javascriptDOMDocProp Fg
highlight! link javascriptSymbolStaticProp Fg
highlight! link javascriptSymbolProp Fg
highlight! link javascriptBOMLocationProp Fg
highlight! link javascriptEncodingProp Fg
highlight! link javascriptCryptoProp Fg
highlight! link javascriptBOMHistoryProp Fg
highlight! link javascriptDOMFormProp Fg
highlight! link javascriptDataViewProp Fg
highlight! link javascriptBroadcastProp Fg
highlight! link javascriptMathStaticProp Fg
" }}}
" vim-jsx-pretty: https://github.com/maxmellon/vim-jsx-pretty{{{
highlight! link jsxTagName RedItalic
highlight! link jsxOpenPunct Green
highlight! link jsxClosePunct Blue
highlight! link jsxEscapeJs Purple
highlight! link jsxAttrib Blue
" }}}
" ft_end }}}
" ft_begin: typescript/typescriptreact {{{
" vim-typescript: https://github.com/leafgarland/typescript-vim{{{
highlight! link typescriptStorageClass Red
highlight! link typescriptEndColons Fg
highlight! link typescriptSource BlueItalic
highlight! link typescriptMessage Green
highlight! link typescriptGlobalObjects BlueItalic
highlight! link typescriptInterpolation Purple
highlight! link typescriptInterpolationDelimiter Purple
highlight! link typescriptBraces Fg
highlight! link typescriptParens Fg
" }}}
" yats: https:github.com/HerringtonDarkholme/yats.vim{{{
highlight! link typescriptMethodAccessor Red
highlight! link typescriptVariable Red
highlight! link typescriptVariableDeclaration Fg
highlight! link typescriptTypeReference BlueItalic
highlight! link typescriptBraces Fg
highlight! link typescriptEnumKeyword Red
highlight! link typescriptEnum BlueItalic
highlight! link typescriptIdentifierName Fg
highlight! link typescriptProp Fg
highlight! link typescriptCall Fg
highlight! link typescriptInterfaceName BlueItalic
highlight! link typescriptEndColons Fg
highlight! link typescriptMember Fg
highlight! link typescriptMemberOptionality Red
highlight! link typescriptObjectLabel Fg
highlight! link typescriptDefaultParam Fg
highlight! link typescriptArrowFunc Red
highlight! link typescriptAbstract Red
highlight! link typescriptObjectColon Grey
highlight! link typescriptTypeAnnotation Grey
highlight! link typescriptAssign Red
highlight! link typescriptBinaryOp Red
highlight! link typescriptUnaryOp Red
highlight! link typescriptFuncComma Fg
highlight! link typescriptClassName BlueItalic
highlight! link typescriptClassHeritage BlueItalic
highlight! link typescriptInterfaceHeritage BlueItalic
highlight! link typescriptIdentifier OrangeItalic
highlight! link typescriptGlobal BlueItalic
highlight! link typescriptOperator Red
highlight! link typescriptNodeGlobal BlueItalic
highlight! link typescriptExport Red
highlight! link typescriptImport Red
highlight! link typescriptTypeParameter BlueItalic
highlight! link typescriptReadonlyModifier Red
highlight! link typescriptAccessibilityModifier Red
highlight! link typescriptAmbientDeclaration Red
highlight! link typescriptTemplateSubstitution Purple
highlight! link typescriptTemplateSB Purple
highlight! link typescriptExceptions Red
highlight! link typescriptCastKeyword Red
highlight! link typescriptOptionalMark Red
highlight! link typescriptNull OrangeItalic
highlight! link typescriptMappedIn Red
highlight! link typescriptFuncTypeArrow Red
highlight! link typescriptTernaryOp Red
highlight! link typescriptParenExp Fg
highlight! link typescriptIndexExpr Fg
highlight! link typescriptDotNotation Grey
highlight! link typescriptGlobalNumberDot Grey
highlight! link typescriptGlobalStringDot Grey
highlight! link typescriptGlobalArrayDot Grey
highlight! link typescriptGlobalObjectDot Grey
highlight! link typescriptGlobalSymbolDot Grey
highlight! link typescriptGlobalMathDot Grey
highlight! link typescriptGlobalDateDot Grey
highlight! link typescriptGlobalJSONDot Grey
highlight! link typescriptGlobalRegExpDot Grey
highlight! link typescriptGlobalPromiseDot Grey
highlight! link typescriptGlobalURLDot Grey
highlight! link typescriptGlobalMethod Green
highlight! link typescriptDOMStorageMethod Green
highlight! link typescriptFileMethod Green
highlight! link typescriptFileReaderMethod Green
highlight! link typescriptFileListMethod Green
highlight! link typescriptBlobMethod Green
highlight! link typescriptURLStaticMethod Green
highlight! link typescriptNumberStaticMethod Green
highlight! link typescriptNumberMethod Green
highlight! link typescriptDOMNodeMethod Green
highlight! link typescriptPaymentMethod Green
highlight! link typescriptPaymentResponseMethod Green
highlight! link typescriptHeadersMethod Green
highlight! link typescriptRequestMethod Green
highlight! link typescriptResponseMethod Green
highlight! link typescriptES6SetMethod Green
highlight! link typescriptReflectMethod Green
highlight! link typescriptBOMWindowMethod Green
highlight! link typescriptGeolocationMethod Green
highlight! link typescriptServiceWorkerMethod Green
highlight! link typescriptCacheMethod Green
highlight! link typescriptES6MapMethod Green
highlight! link typescriptFunctionMethod Green
highlight! link typescriptRegExpMethod Green
highlight! link typescriptXHRMethod Green
highlight! link typescriptBOMNavigatorMethod Green
highlight! link typescriptServiceWorkerMethod Green
highlight! link typescriptIntlMethod Green
highlight! link typescriptDOMEventTargetMethod Green
highlight! link typescriptDOMEventMethod Green
highlight! link typescriptDOMDocMethod Green
highlight! link typescriptStringStaticMethod Green
highlight! link typescriptStringMethod Green
highlight! link typescriptSymbolStaticMethod Green
highlight! link typescriptObjectStaticMethod Green
highlight! link typescriptObjectMethod Green
highlight! link typescriptJSONStaticMethod Green
highlight! link typescriptEncodingMethod Green
highlight! link typescriptBOMLocationMethod Green
highlight! link typescriptPromiseStaticMethod Green
highlight! link typescriptPromiseMethod Green
highlight! link typescriptSubtleCryptoMethod Green
highlight! link typescriptCryptoMethod Green
highlight! link typescriptBOMHistoryMethod Green
highlight! link typescriptDOMFormMethod Green
highlight! link typescriptConsoleMethod Green
highlight! link typescriptDateStaticMethod Green
highlight! link typescriptDateMethod Green
highlight! link typescriptArrayStaticMethod Green
highlight! link typescriptArrayMethod Green
highlight! link typescriptMathStaticMethod Green
highlight! link typescriptStringProperty Fg
highlight! link typescriptDOMStorageProp Fg
highlight! link typescriptFileReaderProp Fg
highlight! link typescriptURLUtilsProp Fg
highlight! link typescriptNumberStaticProp Fg
highlight! link typescriptDOMNodeProp Fg
highlight! link typescriptBOMWindowProp Fg
highlight! link typescriptRequestProp Fg
highlight! link typescriptResponseProp Fg
highlight! link typescriptPaymentProp Fg
highlight! link typescriptPaymentResponseProp Fg
highlight! link typescriptPaymentAddressProp Fg
highlight! link typescriptPaymentShippingOptionProp Fg
highlight! link typescriptES6SetProp Fg
highlight! link typescriptServiceWorkerProp Fg
highlight! link typescriptES6MapProp Fg
highlight! link typescriptRegExpStaticProp Fg
highlight! link typescriptRegExpProp Fg
highlight! link typescriptBOMNavigatorProp Green
highlight! link typescriptXHRProp Fg
highlight! link typescriptDOMEventProp Fg
highlight! link typescriptDOMDocProp Fg
highlight! link typescriptBOMNetworkProp Fg
highlight! link typescriptSymbolStaticProp Fg
highlight! link typescriptEncodingProp Fg
highlight! link typescriptBOMLocationProp Fg
highlight! link typescriptCryptoProp Fg
highlight! link typescriptDOMFormProp Fg
highlight! link typescriptBOMHistoryProp Fg
highlight! link typescriptMathStaticProp Fg
" }}}
" ft_end }}}
" ft_begin: dart {{{
" dart-lang: https://github.com/dart-lang/dart-vim-plugin{{{
highlight! link dartCoreClasses BlueItalic
highlight! link dartTypeName BlueItalic
highlight! link dartInterpolation Purple
highlight! link dartTypeDef Red
highlight! link dartClassDecl Red
highlight! link dartLibrary Red
highlight! link dartMetadata OrangeItalic
" }}}
" ft_end }}}
" ft_begin: c/cpp/objc/objcpp {{{
" builtin: {{{
highlight! link cLabel Keyword
highlight! link cType TSTypeBuiltin
highlight! link cConstant TSConstBuiltin
highlight! link cppSTLnamespace Type
highlight! link cppSTLtype Keyword
highlight! link cppAccess Keyword
highlight! link cppStructure Keyword
highlight! link cppSTLios TSTypeBuiltin
highlight! link cppSTLiterator TSTypeBuiltin
highlight! link cppSTLexception Keyword
highlight! link cppSTLVariable ConstantBuiltin
highlight! link cppModifier Keyword
highlight! link cppType TSTypeBuiltin
highlight! link cppConstant ConstantBuiltin
" }}}
" ft_end }}}
" ft_begin: objc {{{
" builtin: {{{
highlight! link objcModuleImport Keyword
highlight! link objcException Keyword
highlight! link objcProtocolList Fg
highlight! link objcDirective Keyword
highlight! link objcPropertyAttribute xAttributes
highlight! link objcHiddenArgument Keyword
highlight! link objcPrincipalType TSTypeBuiltin
" }}}
" ft_end }}}
" ft_begin: cs {{{
" builtin: https://github.com/nickspoons/vim-cs{{{
highlight! link csUnspecifiedStatement Red
highlight! link csStorage Red
highlight! link csClass Red
highlight! link csNewType BlueItalic
highlight! link csContextualStatement Red
highlight! link csInterpolationDelimiter Purple
highlight! link csInterpolation Purple
highlight! link csEndColon Fg
" }}}
" ft_end }}}
" ft_begin: python {{{
" builtin: {{{
highlight! link pythonBuiltin BlueItalic
highlight! link pythonExceptions Red
highlight! link pythonDecoratorName OrangeItalic
" }}}
" python-syntax: https://github.com/vim-python/python-syntax{{{
highlight! link pythonExClass BlueItalic
highlight! link pythonBuiltinType BlueItalic
highlight! link pythonBuiltinObj OrangeItalic
highlight! link pythonDottedName OrangeItalic
highlight! link pythonBuiltinFunc Green
highlight! link pythonFunction Green
highlight! link pythonDecorator OrangeItalic
highlight! link pythonInclude Include
highlight! link pythonImport PreProc
highlight! link pythonOperator Red
highlight! link pythonConditional Red
highlight! link pythonRepeat Red
highlight! link pythonException Red
highlight! link pythonNone OrangeItalic
highlight! link pythonCoding Grey
highlight! link pythonDot Grey
" }}}
" semshi: https://github.com/numirias/semshi{{{
call jcolor#highlight('semshiUnresolved', s:palette.orange, s:palette.none, 'undercurl')
highlight! link semshiImported TSInclude
highlight! link semshiParameter TSParameter
highlight! link semshiParameterUnused Grey
highlight! link semshiSelf TSVariableBuiltin
highlight! link semshiGlobal TSType
highlight! link semshiBuiltin TSTypeBuiltin
highlight! link semshiAttribute TSAttribute
highlight! link semshiLocal TSKeyword
highlight! link semshiFree TSKeyword
highlight! link semshiSelected CurrentWord
highlight! link semshiErrorSign RedSign
highlight! link semshiErrorChar RedSign
" }}}
" ft_end }}}
" ft_begin: lua {{{
" builtin: {{{
highlight! link luaFunc Green
highlight! link luaFunction Red
highlight! link luaTable Fg
highlight! link luaIn Red
" }}}
" vim-lua: https://github.com/tbastos/vim-lua{{{
highlight! link luaFuncCall Green
highlight! link luaLocal Red
highlight! link luaSpecialValue Green
highlight! link luaBraces Fg
highlight! link luaBuiltIn BlueItalic
highlight! link luaNoise Grey
highlight! link luaLabel Purple
highlight! link luaFuncTable BlueItalic
highlight! link luaFuncArgName Fg
highlight! link luaEllipsis Red
highlight! link luaDocTag Green
" }}}
" ft_end }}}
" ft_begin: go {{{
" builtin: https://github.com/google/vim-ft-go{{{
highlight! link goDirective Red
highlight! link goConstants OrangeItalic
highlight! link goDeclType Red
" }}}
" polyglot: {{{
highlight! link goPackage Red
highlight! link goImport Red
highlight! link goBuiltins Green
highlight! link goPredefinedIdentifiers OrangeItalic
highlight! link goVar Red
" }}}
" ft_end }}}
" ft_begin: rust {{{
" builtin: https://github.com/rust-lang/rust.vim{{{
highlight! link rustStructure Red
highlight! link rustIdentifier OrangeItalic
highlight! link rustModPath BlueItalic
highlight! link rustModPathSep Grey
highlight! link rustSelf OrangeItalic
highlight! link rustSuper OrangeItalic
highlight! link rustDeriveTrait Purple
highlight! link rustEnumVariant Purple
highlight! link rustMacroVariable OrangeItalic
highlight! link rustAssert Green
highlight! link rustPanic Green
highlight! link rustPubScopeCrate BlueItalic
highlight! link rustAttribute Purple
" }}}
" ft_end }}}
" ft_begin: ruby {{{
" builtin: https://github.com/vim-ruby/vim-ruby{{{
highlight! link rubyKeywordAsMethod Green
highlight! link rubyInterpolation Purple
highlight! link rubyInterpolationDelimiter Purple
highlight! link rubyStringDelimiter Yellow
highlight! link rubyBlockParameterList Fg
highlight! link rubyDefine Red
highlight! link rubyModuleName Red
highlight! link rubyAccess Red
highlight! link rubyMacro Red
highlight! link rubySymbol Fg
" }}}
" ft_end }}}
" ft_begin: haskell {{{
" haskell-vim: https://github.com/neovimhaskell/haskell-vim{{{
highlight! link haskellBrackets Fg
highlight! link haskellIdentifier OrangeItalic
highlight! link haskellDecl Red
highlight! link haskellType BlueItalic
highlight! link haskellDeclKeyword Red
highlight! link haskellWhere Red
highlight! link haskellDeriving Red
highlight! link haskellForeignKeywords Red
" }}}
" ft_end }}}
" ft_begin: perl/pod {{{
" builtin: https://github.com/vim-perl/vim-perl{{{
highlight! link perlStatementPackage Red
highlight! link perlStatementInclude Red
highlight! link perlStatementStorage Red
highlight! link perlStatementList Red
highlight! link perlMatchStartEnd Red
highlight! link perlVarSimpleMemberName Green
highlight! link perlVarSimpleMember Fg
highlight! link perlMethod Green
highlight! link podVerbatimLine Green
highlight! link podCmdText Yellow
highlight! link perlVarPlain Fg
highlight! link perlVarPlain2 Fg
" }}}
" ft_end }}}
" ft_begin: lisp {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_LISP{{{
highlight! link lispAtomMark Purple
highlight! link lispKey Orange
highlight! link lispFunc Green
" }}}
" ft_end }}}
" ft_begin: clojure {{{
" builtin: https://github.com/guns/vim-clojure-static{{{
highlight! link clojureMacro Red
highlight! link clojureFunc Green
highlight! link clojureConstant OrangeItalic
highlight! link clojureSpecial Red
highlight! link clojureDefine Red
highlight! link clojureKeyword Blue
highlight! link clojureVariable Fg
highlight! link clojureMeta Purple
highlight! link clojureDeref Purple
" }}}
" ft_end }}}
" ft_begin: sh/zsh {{{
" builtin: http://www.drchip.org/astronaut/vim/index.html#SYNTAX_SH{{{
highlight! link shRange Fg
highlight! link shOption Purple
highlight! link shQuote Yellow
highlight! link shVariable BlueItalic
highlight! link shDerefSimple BlueItalic
highlight! link shDerefVar BlueItalic
highlight! link shDerefSpecial BlueItalic
highlight! link shDerefOff BlueItalic
highlight! link shVarAssign Red
highlight! link shFunctionOne Green
highlight! link shFunctionKey Red
" }}}
" ft_end }}}
" ft_begin: vim {{{
call jcolor#highlight('vimCommentTitle', s:palette.grey, s:palette.none, 'bold')
highlight! link vimLet Red
highlight! link vimFunction Green
highlight! link vimIsCommand Fg
highlight! link vimUserFunc Green
highlight! link vimFuncName Green
highlight! link vimMap BlueItalic
highlight! link vimNotation Purple
highlight! link vimMapLhs Green
highlight! link vimMapRhs Green
highlight! link vimSetEqual BlueItalic
highlight! link vimSetSep Fg
highlight! link vimOption BlueItalic
highlight! link vimUserAttrbKey BlueItalic
highlight! link vimUserAttrb Green
highlight! link vimAutoCmdSfxList Orange
highlight! link vimSynType Orange
highlight! link vimHiBang Orange
highlight! link vimSet BlueItalic
highlight! link vimSetSep Grey
" ft_end }}}
" ft_begin: make {{{
highlight! link makeIdent Purple
highlight! link makeSpecTarget BlueItalic
highlight! link makeTarget Orange
highlight! link makeCommands Red
" ft_end }}}
" ft_begin: cmake {{{
highlight! link cmakeCommand Red
highlight! link cmakeKWconfigure_package_config_file BlueItalic
highlight! link cmakeKWwrite_basic_package_version_file BlueItalic
highlight! link cmakeKWExternalProject Green
highlight! link cmakeKWadd_compile_definitions Green
highlight! link cmakeKWadd_compile_options Green
highlight! link cmakeKWadd_custom_command Green
highlight! link cmakeKWadd_custom_target Green
highlight! link cmakeKWadd_definitions Green
highlight! link cmakeKWadd_dependencies Green
highlight! link cmakeKWadd_executable Green
highlight! link cmakeKWadd_library Green
highlight! link cmakeKWadd_link_options Green
highlight! link cmakeKWadd_subdirectory Green
highlight! link cmakeKWadd_test Green
highlight! link cmakeKWbuild_command Green
highlight! link cmakeKWcmake_host_system_information Green
highlight! link cmakeKWcmake_minimum_required Green
highlight! link cmakeKWcmake_parse_arguments Green
highlight! link cmakeKWcmake_policy Green
highlight! link cmakeKWconfigure_file Green
highlight! link cmakeKWcreate_test_sourcelist Green
highlight! link cmakeKWctest_build Green
highlight! link cmakeKWctest_configure Green
highlight! link cmakeKWctest_coverage Green
highlight! link cmakeKWctest_memcheck Green
highlight! link cmakeKWctest_run_script Green
highlight! link cmakeKWctest_start Green
highlight! link cmakeKWctest_submit Green
highlight! link cmakeKWctest_test Green
highlight! link cmakeKWctest_update Green
highlight! link cmakeKWctest_upload Green
highlight! link cmakeKWdefine_property Green
highlight! link cmakeKWdoxygen_add_docs Green
highlight! link cmakeKWenable_language Green
highlight! link cmakeKWenable_testing Green
highlight! link cmakeKWexec_program Green
highlight! link cmakeKWexecute_process Green
highlight! link cmakeKWexport Green
highlight! link cmakeKWexport_library_dependencies Green
highlight! link cmakeKWfile Green
highlight! link cmakeKWfind_file Green
highlight! link cmakeKWfind_library Green
highlight! link cmakeKWfind_package Green
highlight! link cmakeKWfind_path Green
highlight! link cmakeKWfind_program Green
highlight! link cmakeKWfltk_wrap_ui Green
highlight! link cmakeKWforeach Green
highlight! link cmakeKWfunction Green
highlight! link cmakeKWget_cmake_property Green
highlight! link cmakeKWget_directory_property Green
highlight! link cmakeKWget_filename_component Green
highlight! link cmakeKWget_property Green
highlight! link cmakeKWget_source_file_property Green
highlight! link cmakeKWget_target_property Green
highlight! link cmakeKWget_test_property Green
highlight! link cmakeKWif Green
highlight! link cmakeKWinclude Green
highlight! link cmakeKWinclude_directories Green
highlight! link cmakeKWinclude_external_msproject Green
highlight! link cmakeKWinclude_guard Green
highlight! link cmakeKWinstall Green
highlight! link cmakeKWinstall_files Green
highlight! link cmakeKWinstall_programs Green
highlight! link cmakeKWinstall_targets Green
highlight! link cmakeKWlink_directories Green
highlight! link cmakeKWlist Green
highlight! link cmakeKWload_cache Green
highlight! link cmakeKWload_command Green
highlight! link cmakeKWmacro Green
highlight! link cmakeKWmark_as_advanced Green
highlight! link cmakeKWmath Green
highlight! link cmakeKWmessage Green
highlight! link cmakeKWoption Green
highlight! link cmakeKWproject Green
highlight! link cmakeKWqt_wrap_cpp Green
highlight! link cmakeKWqt_wrap_ui Green
highlight! link cmakeKWremove Green
highlight! link cmakeKWseparate_arguments Green
highlight! link cmakeKWset Green
highlight! link cmakeKWset_directory_properties Green
highlight! link cmakeKWset_property Green
highlight! link cmakeKWset_source_files_properties Green
highlight! link cmakeKWset_target_properties Green
highlight! link cmakeKWset_tests_properties Green
highlight! link cmakeKWsource_group Green
highlight! link cmakeKWstring Green
highlight! link cmakeKWsubdirs Green
highlight! link cmakeKWtarget_compile_definitions Green
highlight! link cmakeKWtarget_compile_features Green
highlight! link cmakeKWtarget_compile_options Green
highlight! link cmakeKWtarget_include_directories Green
highlight! link cmakeKWtarget_link_directories Green
highlight! link cmakeKWtarget_link_libraries Green
highlight! link cmakeKWtarget_link_options Green
highlight! link cmakeKWtarget_precompile_headers Green
highlight! link cmakeKWtarget_sources Green
highlight! link cmakeKWtry_compile Green
highlight! link cmakeKWtry_run Green
highlight! link cmakeKWunset Green
highlight! link cmakeKWuse_mangled_mesa Green
highlight! link cmakeKWvariable_requires Green
highlight! link cmakeKWvariable_watch Green
highlight! link cmakeKWwrite_file Green
" ft_end }}}
" ft_begin: json {{{
highlight! link jsonKeyword Red
highlight! link jsonString Green
highlight! link jsonBoolean Blue
highlight! link jsonNoise Grey
highlight! link jsonQuote Grey
highlight! link jsonBraces Fg
" ft_end }}}
" ft_begin: yaml {{{
highlight! link yamlKey Red
highlight! link yamlConstant BlueItalic
highlight! link yamlString Green
" ft_end }}}
" ft_begin: gitcommit {{{
highlight! link gitcommitSummary Red
highlight! link gitcommitUntracked Grey
highlight! link gitcommitDiscarded Grey
highlight! link gitcommitSelected Grey
highlight! link gitcommitUnmerged Grey
highlight! link gitcommitOnBranch Grey
highlight! link gitcommitArrow Grey
highlight! link gitcommitFile Green
" ft_end }}}
" ft_begin: help {{{
call jcolor#highlight('helpNote', s:palette.purple, s:palette.none, 'bold')
call jcolor#highlight('helpHeadline', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('helpHeader', s:palette.orange, s:palette.none, 'bold')
call jcolor#highlight('helpURL', s:palette.green, s:palette.none, 'underline')
call jcolor#highlight('helpHyperTextEntry', s:palette.blue, s:palette.none, 'bold')
highlight! link helpHyperTextJump Blue
highlight! link helpCommand Yellow
highlight! link helpExample Green
highlight! link helpSpecial Purple
highlight! link helpSectionDelim Grey
" ft_end }}}
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
