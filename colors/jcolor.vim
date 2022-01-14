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
let g:jcolor_palette = s:palette

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
" Cursor, column, lines {{{
let g:jcolor_bg_a1 = s:palette.bg_a1[0]
let g:jcolor_bg_cursor = s:palette.bg_cursor_i[0]
augroup JCOLOR_UI
  autocmd!
  autocmd InsertEnter * execute 'highlight CursorLine guibg=' . g:jcolor_bg_cursor . ' guifg=NONE'
  autocmd InsertLeave * execute 'highlight CursorLine guibg=' . g:jcolor_bg_a1 . ' guifg=NONE'
augroup END
if &diff
  call jcolor#highlight('CursorLine', s:palette.none, s:palette.none, 'underline')
  call jcolor#highlight('CursorColumn', s:palette.none, s:palette.none, 'bold')
  call jcolor#highlight('CursorLineNr', s:palette.fg, s:palette.none, 'underline')
else
  call jcolor#highlight('CursorLine', s:palette.none, s:palette.bg_a1)
  call jcolor#highlight('CursorColumn', s:palette.none, s:palette.bg_a1)
  call jcolor#highlight('CursorLineNr', s:palette.fg, s:palette.none)
endif
call jcolor#highlight('ColorColumn', s:palette.none, s:palette.bg_line_t)
call jcolor#highlight('Cursor', s:palette.none, s:palette.none, 'reverse')
call jcolor#highlight('LineNr', s:palette.grey_m1, s:palette.none)

call jcolor#highlight('Folded', s:palette.grey, s:palette.bg_a1)
call jcolor#highlight('FoldColumn', s:palette.grey_m1, s:palette.none)
call jcolor#highlight('SignColumn', s:palette.fg, s:palette.none)
call jcolor#highlight('ToolbarLine', s:palette.fg, s:palette.bg_a2)

call jcolor#highlight('StatusLine', s:palette.fg, s:palette.bg_line_t)
call jcolor#highlight('StatusLineTerm', s:palette.fg, s:palette.bg_line_t)
call jcolor#highlight('StatusLineNC', s:palette.grey, s:palette.bg_a1)
call jcolor#highlight('StatusLineTermNC', s:palette.grey, s:palette.bg_a1)

call jcolor#highlight('TabLine', s:palette.grey_a1, s:palette.bg_line_t)
call jcolor#highlight('TabLineFill', s:palette.grey, s:palette.bg_line_t)
call jcolor#highlight('TabLineSel', s:palette.green, s:palette.bg_a4, 'bold')

call jcolor#highlight('VertSplit', s:palette.black, s:palette.none)
call jcolor#highlight('QuickFixLine', s:palette.blue, s:palette.none, 'bold')

highlight! link vCursor Cursor
highlight! link iCursor Cursor
highlight! link lCursor Cursor
highlight! link CursorIM Cursor
highlight! link TermCursor Cursor
" }}}
call jcolor#highlight('Normal', s:palette.fg, s:palette.bg)
call jcolor#highlight('Visual', s:palette.none, s:palette.diff_green)
call jcolor#highlight('VisualNOS', s:palette.none, s:palette.bg_a3, 'underline')
call jcolor#highlight('Terminal', s:palette.fg, s:palette.bg)

call jcolor#highlight('Search', s:palette.bg, s:palette.bg_green)
call jcolor#highlight('IncSearch', s:palette.bg, s:palette.bg_red)
call jcolor#highlight('MatchParen', s:palette.none, s:palette.bg_a4)

call jcolor#highlight('DiffAdd', s:palette.none, s:palette.diff_green)
call jcolor#highlight('DiffChange', s:palette.none, s:palette.diff_blue)
call jcolor#highlight('DiffDelete', s:palette.none, s:palette.diff_red)
call jcolor#highlight('DiffText', s:palette.bg, s:palette.blue)

call jcolor#highlight('Directory', s:palette.green, s:palette.none)

call jcolor#highlight('MsgArea', s:palette.fg, s:palette.bg)
call jcolor#highlight('Conceal', s:palette.grey_m1, s:palette.none)
call jcolor#highlight('ErrorMsg', s:palette.red, s:palette.none, 'bold,underline')
call jcolor#highlight('WarningMsg', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('ModeMsg', s:palette.fg, s:palette.none, 'bold')
call jcolor#highlight('MoreMsg', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('NonText', s:palette.bg_a4, s:palette.none)
call jcolor#highlight('Whitespace', s:palette.bg_a4, s:palette.none)
call jcolor#highlight('SpecialKey', s:palette.bg_a4, s:palette.none)
call jcolor#highlight('Title', s:palette.yellow, s:palette.none, 'bold')

call jcolor#highlight('NormalFloat', s:palette.fg, s:palette.bg_a2)
call jcolor#highlight('Pmenu', s:palette.fg, s:palette.bg_a2)
call jcolor#highlight('PmenuSbar', s:palette.none, s:palette.bg_a2)
call jcolor#highlight('PmenuThumb', s:palette.none, s:palette.bg_a4)
if s:configuration.menu_selection_background ==# 'blue'
  call jcolor#highlight('PmenuSel', s:palette.bg, s:palette.bg_blue)
elseif s:configuration.menu_selection_background ==# 'green'
  call jcolor#highlight('PmenuSel', s:palette.bg, s:palette.bg_green)
elseif s:configuration.menu_selection_background ==# 'red'
  call jcolor#highlight('PmenuSel', s:palette.bg, s:palette.bg_red)
endif
highlight! link WildMenu PmenuSel

call jcolor#highlight('Question', s:palette.yellow, s:palette.none)
call jcolor#highlight('SpellBad', s:palette.none, s:palette.none, 'undercurl', s:palette.red)
call jcolor#highlight('SpellCap', s:palette.none, s:palette.none, 'undercurl', s:palette.yellow)
call jcolor#highlight('SpellLocal', s:palette.none, s:palette.none, 'undercurl', s:palette.blue)
call jcolor#highlight('SpellRare', s:palette.none, s:palette.none, 'undercurl', s:palette.purple)
call jcolor#highlight('Debug', s:palette.yellow, s:palette.none)
call jcolor#highlight('debugPC', s:palette.bg, s:palette.green)
call jcolor#highlight('debugBreakpoint', s:palette.bg, s:palette.red)
call jcolor#highlight('Substitute', s:palette.bg, s:palette.yellow)

if s:configuration.show_eob
  call jcolor#highlight('EndOfBuffer', s:palette.bg_a4, s:palette.bg)
else
  call jcolor#highlight('EndOfBuffer', s:palette.bg, s:palette.bg)
endif

" }}}
" Predefined Custome Highlight Groups: {{{
call jcolor#highlight('Fg', s:palette.fg, s:palette.none)
call jcolor#highlight('Grey', s:palette.grey, s:palette.none)
call jcolor#highlight('Red', s:palette.red, s:palette.none)
call jcolor#highlight('Orange', s:palette.orange, s:palette.none)
call jcolor#highlight('Yellow', s:palette.yellow, s:palette.none)
call jcolor#highlight('Green', s:palette.green, s:palette.none)
call jcolor#highlight('Blue', s:palette.blue, s:palette.none)
call jcolor#highlight('Purple', s:palette.purple, s:palette.none)

call jcolor#highlight('FgBold', s:palette.fg, s:palette.none, 'bold')
call jcolor#highlight('GreyBold', s:palette.grey, s:palette.none, 'bold')
call jcolor#highlight('RedBold', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('OrangeBold', s:palette.orange, s:palette.none, 'bold')
call jcolor#highlight('YellowBold', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('GreenBold', s:palette.green, s:palette.none, 'bold')
call jcolor#highlight('BlueBold', s:palette.blue, s:palette.none, 'bold')
call jcolor#highlight('PurpleBold', s:palette.purple, s:palette.none, 'bold')

call jcolor#highlight('Underlined', s:palette.none, s:palette.none, 'underline')
call jcolor#highlight('Bold', s:palette.none, s:palette.none, 'bold')

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

call jcolor#highlight('ErrorFloat', s:palette.red, s:palette.bg_a2)
call jcolor#highlight('WarningFloat', s:palette.yellow, s:palette.bg_a2)
call jcolor#highlight('InfoFloat', s:palette.blue, s:palette.bg_a2)
call jcolor#highlight('HintFloat', s:palette.green, s:palette.bg_a2)

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

  call jcolor#highlight('VGreyError', s:palette.grey_a1, s:palette.diff_red)
  call jcolor#highlight('VGreyWarn', s:palette.grey_a1, s:palette.diff_yellow)
  call jcolor#highlight('VGreyInfo', s:palette.grey_a1, s:palette.diff_blue)
  call jcolor#highlight('VGreyHint', s:palette.grey_a1, s:palette.diff_green)
else
  highlight clear ErrorLine
  highlight clear WarningLine
  highlight clear InfoLine
  highlight clear HintLine
endif

if &diff
  call jcolor#highlight('CurrentWord', s:palette.bg, s:palette.green)
elseif s:configuration.current_word ==# 'grey background'
  call jcolor#highlight('CurrentWord', s:palette.none, s:palette.bg_a2)
else
  call jcolor#highlight('CurrentWord', s:palette.none, s:palette.none, s:configuration.current_word)
endif

" }}}
" Xcode: {{{
call jcolor#highlight('xPlainText', s:palette.fg, s:palette.none)
call jcolor#highlight('xComment', s:palette.grey, s:palette.none)
call jcolor#highlight('xCommentsKeyword', s:palette.yellow, s:palette.none, 'bold')
call jcolor#highlight('xString', s:palette.red_m1, s:palette.none)
call jcolor#highlight('xCharactersNumber', s:palette.yellow, s:palette.none)
call jcolor#highlight('xKeyword', s:palette.red, s:palette.none, 'bold')
call jcolor#highlight('xPreprocessor', s:palette.orange, s:palette.none)
call jcolor#highlight('xURL', s:palette.blue_m3, s:palette.none)
call jcolor#highlight('xAttribute', s:palette.orange_a1, s:palette.none)
call jcolor#highlight('xDeclaration', s:palette.blue_m1, s:palette.none)
call jcolor#highlight('xOtherDeclaration', s:palette.blue_m2, s:palette.none)
call jcolor#highlight('xType', s:palette.cyan, s:palette.none)
call jcolor#highlight('xField', s:palette.cyan_m1, s:palette.none)
call jcolor#highlight('xFunction', s:palette.cyan_m2, s:palette.none)
call jcolor#highlight('xBuiltinType', s:palette.purple, s:palette.none)
call jcolor#highlight('xBuiltinField', s:palette.purple_m1, s:palette.none)
call jcolor#highlight('xBuiltinFunction', s:palette.purple_m1, s:palette.none)
" }}}
" VIM Buildtin Syntax Group: {{{
highlight! link Comment         xComment

highlight! link Constant        xField
highlight! link String          xString
highlight! link Character       xCharactersNumber
highlight! link Number          xCharactersNumber
highlight! link Boolean         xKeyword
highlight! link Float           xCharactersNumber

highlight! link Identifier      xBuiltinType
highlight! link Function        xFunction

highlight! link Statement       xKeyword
highlight! link Conditional     xKeyword
highlight! link Repeat          xKeyword
highlight! link Label           xKeyword
highlight! link Operator        xKeyword
highlight! link Keyword         xKeyword
highlight! link Exception       xKeyword

highlight! link PreProc         xPreprocessor
highlight! link Include         xPreprocessor
highlight! link Define          xKeyword
highlight! link Macro           xPreprocessor
highlight! link PreCondit       xPreprocessor

highlight! link Type            xType
highlight! link StorageClass    xKeyword
highlight! link Structure       xKeyword
highlight! link Typedef         xKeyword

highlight! link Special         xString
highlight! link SpecialChar     xString
highlight! link Tag             Green
highlight! link Delimiter       xPlainText
highlight! link SpecialComment  xCommentsKeyword
highlight! link Debug           Yellow

highlight! link Error           Red
highlight! link Todo            xCommentsKeyword
" }}}
" Diagnostic {{{
if s:configuration.diagnostic_virtual_text ==# 'grey'
  highlight! link VirtualTextError VGreyError
  highlight! link VirtualTextWarning VGreyWarn
  highlight! link VirtualTextInfo VGreyInfo
  highlight! link VirtualTextHint VGreyHint
else
  highlight! link VirtualTextError Red
  highlight! link VirtualTextWarning Yellow
  highlight! link VirtualTextInfo Blue
  highlight! link VirtualTextHint Green
endif

highlight! link DiagnosticsFloatingError ErrorFloat
highlight! link DiagnosticsFloatingWarning WarningFloat
highlight! link DiagnosticsFloatingInformation InfoFloat
highlight! link DiagnosticsFloatingHint HintFloat
highlight! link DiagnosticsDefaultError ErrorText
highlight! link DiagnosticsDefaultWarning WarningText
highlight! link DiagnosticsDefaultInformation InfoText
highlight! link DiagnosticsDefaultHint HintText
highlight! link DiagnosticsVirtualTextError VirtualTextError
highlight! link DiagnosticsVirtualTextWarning VirtualTextWarning
highlight! link DiagnosticsVirtualTextInformation VirtualTextInfo
highlight! link DiagnosticsVirtualTextHint VirtualTextHint
highlight! link DiagnosticsUnderlineError ErrorText
highlight! link DiagnosticsUnderlineWarning WarningText
highlight! link DiagnosticsUnderlineInformation InfoText
highlight! link DiagnosticsUnderlineHint HintText
highlight! link DiagnosticsSignError RedSign
highlight! link DiagnosticsSignWarning YellowSign
highlight! link DiagnosticsSignInformation BlueSign
highlight! link DiagnosticsSignHint GreenSign
highlight! link ReferenceText CurrentWord
highlight! link ReferenceRead CurrentWord
highlight! link ReferenceWrite CurrentWord

highlight! link DiagnosticError Red
highlight! link DiagnosticWarn Yellow
highlight! link DiagnosticInfo Grey
highlight! link DiagnosticHint Green
" }}}
" }}}
" Terminal: {{{
if (has('termguicolors') && &termguicolors) || has('gui_running')
  " Definition
  let s:terminal = {
        \ 'black':    s:palette.grey_m1,
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
" Tree-sitter defines highlights.
highlight! link TSAttribute          xAttribute
highlight! link TSBoolean            Keyword
highlight! link TSCharacter          Character
highlight! link TSComment            Comment
highlight! link TSConditional        Keyword
highlight! link TSConstant           Constant
highlight! link TSConstBuiltin       xBuiltinField
highlight! link TSConstMacro         Macro
highlight! link TSConstructor        Type
highlight! link TSError              Keyword
highlight! link TSException          Keyword
highlight! link TSField              xField
highlight! link TSFloat              Float
highlight! link TSFunction           Function
highlight! link TSFuncBuiltin        xBuiltinFunction
highlight! link TSFuncMacro          Macro
highlight! link TSInclude            Include
highlight! link TSKeyword            Keyword
highlight! link TSKeywordFunction    Keyword
highlight! link TSKeywordOperator    Keyword
highlight! link TSKeywordReturn      Keyword
highlight! link TSLabel              Label
highlight! link TSMethod             Function
highlight! link TSNamespace          Type
highlight! link TSNone               Fg
highlight! link TSNumber             Number
highlight! link TSOperator           Fg
highlight! link TSParameter          Fg
highlight! link TSParameterReference Fg
highlight! link TSProperty           TSField
highlight! link TSPunctDelimiter     Fg
highlight! link TSPunctBracket       Fg
highlight! link TSPunctSpecial       Yellow
highlight! link TSRepeat             Keyword
highlight! link TSString             String
highlight! link TSStringRegex        Character
highlight! link TSStringEscape       Character
highlight! link TSStringSpecial      Character
highlight! link TSSymbol             Fg
highlight! link TSTag                Tag
highlight! link TSTagAttribute       xAttribute
highlight! link TSTagDelimiter       Fg
highlight! link TSText               Fg
highlight! link TSStrong             Bold
highlight! link TSEmphasis           Bold
highlight! link TSUnderline          Underline
highlight! link TSStrike             Grey
highlight! link TSTitle              YellowBold
highlight! link TSLiteral            Fg
highlight! link TSURI                xURLs
highlight! link TSMath               Yellow
highlight! link TSTextReference      xURLs
" TSEnvironment
" TSEnvironmentName
highlight! link TSNote               BlueBold
highlight! link TSWarning            YellowBold
highlight! link TSDanger             RedBold
highlight! link TSType               Type
highlight! link TSTypeBuiltin        xBuiltinType
highlight! link TSVariable           Fg
highlight! link TSVariableBuiltin    xBuiltinField

"----------------------------
" Custom Defines for clangd.
"----------------------------
highlight! link TSTypeDefaultLibrary  xBuiltinType
highlight! link TSOtherDefaultLibrary xBuiltinField
highlight! link TSTypeDeclaration     xDeclaration
highlight! link TSOtherDeclaration    xOtherDeclaration

highlight! link TSMacro               Macro
highlight! link TSClass               TSType
highlight! link TSInterface           TSType
highlight! link TSEnum                TSType
highlight! link TSEnumMember          TSField

" }}}
" neoclide/coc.nvim {{{
call jcolor#highlight('CocHoverRange', s:palette.none, s:palette.none, 'bold,underline')
highlight! link CocSem_angle                   TSTagDelimiter
highlight! link CocSem_annotation              TSOperator
highlight! link CocSem_attribute               TSAttribute
highlight! link CocSem_bitwise                 TSOperator
highlight! link CocSem_boolean                 TSBoolean
highlight! link CocSem_brace                   TSPunctBracket
highlight! link CocSem_bracket                 TSPunctBracket
highlight! link CocSem_builtinAttribute        TSAttribute
highlight! link CocSem_builtinType             TSTypeBuiltin
highlight! link CocSem_character               TSCharacter
highlight! link CocSem_class                   TSType
highlight! link CocSem_colon                   TSPunctDelimiter
highlight! link CocSem_comma                   TSPunctDelimiter
highlight! link CocSem_comment                 TSComment
highlight! link CocSem_comparison              TSOperator
highlight! link CocSem_constParameter          TSParameter
highlight! link CocSem_dependent               TSInclude
highlight! link CocSem_dot                     TSOperator
highlight! link CocSem_enum                    TSType
highlight! link CocSem_enumMember              TSField
highlight! link CocSem_escapeSequence          TSStringEscape
highlight! link CocSem_event                   TSType
highlight! link CocSem_formatSpecifier         TSStringEscape
highlight! link CocSem_function                TSFunction
highlight! link CocSem_interface               TSType
highlight! link CocSem_keyword                 TSKeyword
highlight! link CocSem_label                   TSLabel
highlight! link CocSem_logical                 TSOperator
highlight! link CocSem_macro                   TSConstMacro
highlight! link CocSem_method                  TSMethod
highlight! link CocSem_modifier                TSKeywordOperator
highlight! link CocSem_namespace               TSNamespace
highlight! link CocSem_number                  TSNumber
highlight! link CocSem_operator                TSOperator
highlight! link CocSem_parameter               TSParameter
highlight! link CocSem_parenthesis             TSPunctBracket
highlight! link CocSem_property                TSField
highlight! link CocSem_punctuation             TSOperator
highlight! link CocSem_regexp                  TSStringRegex
highlight! link CocSem_selfKeyword             TSKeyword
highlight! link CocSem_semicolon               TSPunctDelimiter
highlight! link CocSem_string                  TSString
highlight! link CocSem_struct                  TSStructure
highlight! link CocSem_type                    TSType
highlight! link CocSem_typeAlias               TSType
highlight! link CocSem_typeParameter           TSType
highlight! link CocSem_variable                TSVariable

highlight! link CocErrorFloat                  ErrorFloat
highlight! link CocWarningFloat                WarningFloat
highlight! link CocInfoFloat                   InfoFloat
highlight! link CocHintFloat                   HintFloat
highlight! link CocErrorHighlight              ErrorText
highlight! link CocWarningHighlight            WarningText
highlight! link CocInfoHighlight               InfoText
highlight! link CocHintHighlight               HintText
highlight! link CocHighlightText               CurrentWord
highlight! link CocHoverRange                  CurrentWord
highlight! link CocErrorSign                   RedSign
highlight! link CocWarningSign                 YellowSign
highlight! link CocInfoSign                    BlueSign
highlight! link CocHintSign                    GreenSign
highlight! link CocWarningVirtualText          VirtualTextWarning
highlight! link CocErrorVirtualText            VirtualTextError
highlight! link CocInfoVirtualText             VirtualTextInfo
highlight! link CocHintVirtualText             VirtualTextHint
highlight! link CocErrorLine                   ErrorLine
highlight! link CocWarningLine                 WarningLine
highlight! link CocInfoLine                    InfoLine
highlight! link CocHintLine                    HintLine
highlight! link CocCodeLens                    Grey
highlight! link CocFadeOut                     Grey
highlight! link CocStrikeThrough               Grey
highlight! link CocListMode                    StatusLine
highlight! link CocListPath                    StatusLine
highlight! link CocTreeOpenClose               Grey
highlight! link HighlightedyankRegion          Visual

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
call jcolor#highlight('Lf_hl_popup_normalMode', s:palette.bg, s:palette.green, 'bold')
call jcolor#highlight('Lf_hl_popup_inputMode', s:palette.bg, s:palette.purple, 'bold')
call jcolor#highlight('Lf_hl_popup_category', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_nameOnlyMode', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_fullPathMode', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_fuzzyMode', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_regexMode', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_cwd', s:palette.grey_a1, s:palette.bg_a2)
call jcolor#highlight('Lf_hl_popup_lineInfo', s:palette.grey_a1, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_total', s:palette.bg_a3, s:palette.bg_a3)
call jcolor#highlight('Lf_hl_popup_cursor', s:palette.fg, s:palette.fg)
highlight! link Lf_hl_cursorline Fg
highlight! link Lf_hl_selection DiffAdd
highlight! link Lf_hl_rgHighlight Visual
highlight! link Lf_hl_gtagsHighlight Visual
highlight! link Lf_hl_popup_inputText Pmenu
highlight! link Lf_hl_popup_window Pmenu
highlight! link Lf_hl_popup_prompt Blue
highlight! link Lf_hl_popup_blank Lf_hl_popup_window
highlight! link Lf_hl_popup_spin Purple
" }}}
" airblade/vim-gitgutter {{{
highlight! link GitGutterAdd GreenSign
highlight! link GitGutterChange BlueSign
highlight! link GitGutterDelete RedSign
highlight! link GitGutterChangeDelete PurpleSign
" }}}
" easymotion/vim-easymotion {{{
highlight! link EasyMotionTarget Keyword
highlight! link EasyMotionShade Grey
" }}}
" lewis6991/gitsigns.nvim {{{
highlight! link GitSignsCurrentLineBlame Grey
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
call jcolor#highlight('NERDTreeDir', s:palette.grey_a1, s:palette.none, 'bold')
call jcolor#highlight('NERDTreeDirSlash', s:palette.bg, s:palette.none)
highlight! link NERDTreeOpenable Green
highlight! link NERDTreeClosable Green
highlight! link NERDTreeFile Fg
highlight! link NERDTreeExecFile Red
highlight! link NERDTreeUp Grey
highlight! link NERDTreeCWD Grey
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
" ft_end }}}
" ft_begin: typescript/typescriptreact {{{
highlight! link typescriptGlobal TSTypeBuiltin
highlight! link typescriptGlobalMethod TSFuncBuiltin
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
highlight! link cppSTLVariable TSConstBuiltin
highlight! link cppModifier Keyword
highlight! link cppType TSTypeBuiltin
highlight! link cppConstant TSConstBuiltin
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
" }}}
" ft_end }}}
" ft_begin: lua {{{
" builtin: {{{
highlight! link luaFunc Green
highlight! link luaFunction Red
highlight! link luaTable Fg
highlight! link luaIn Red
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
