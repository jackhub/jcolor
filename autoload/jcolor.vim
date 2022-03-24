" =============================================================================
" URL: https://github.com/sainnhe/jcolor
" Filename: autoload/jcolor.vim
" Author: sainnhe
" Email: sainnhe@gmail.com
" License: MIT License
" =============================================================================

" g:jcolor#tmux: is in tmux < 2.9 or not {{{
let g:jcolor#tmux = executable('tmux') && $TMUX !=# '' ?
      \ (str2float(system("tmux -V | grep -oE '[0-9]+\.[0-9]*'")) < 2.9 ?
      \ 1 :
      \ 0) :
      \ 0 "}}}
function! jcolor#get_configuration() "{{{
  return {
        \ 'style': get(g:, 'jcolor_style', 'default'),
        \ 'disable_italic_comment': get(g:, 'jcolor_disable_italic_comment', 0),
        \ 'enable_italic': get(g:, 'jcolor_enable_italic', 0),
        \ 'menu_selection_background': get(g:, 'jcolor_menu_selection_background', 'green'),
        \ 'show_eob': get(g:, 'jcolor_show_eob', 0),
        \ 'current_word': get(g:, 'jcolor_current_word', get(g:, 'jcolor_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'diagnostic_text_highlight': get(g:, 'jcolor_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'jcolor_diagnostic_line_highlight', 0),
        \ 'diagnostic_virtual_text': get(g:, 'jcolor_diagnostic_virtual_text', 'grey'),
        \ 'better_performance': get(g:, 'jcolor_better_performance', 0),
        \ }
endfunction "}}}
function! jcolor#get_palette(style) "{{{
  " UIs
  let palette = {
        \ 'white':        '#ffffff',
        \ 'black':        '#1a1b1a',
        \ 'fg':           '#dedfe0',
        \ 'grey_m1':      '#5a6477',
        \ 'grey':         '#7e8c98',
        \ 'grey_a1':      '#a2b0be',
        \ 'bg':           '#292a2f',
        \ 'bg_a1':        '#2f3238',
        \ 'bg_a2':        '#383b42',
        \ 'bg_a3':        '#3f434a',
        \ 'bg_a4':        '#484c55',
        \ 'bg_line_t':    '#2f3037',
        \ 'bg_cursor_i':  '#342d3e',
        \ 'bg_red':       '#ff6d7e',
        \ 'bg_green':     '#a5e179',
        \ 'bg_blue':      '#76bed3',
        \ 'bg_yellow':    '#4a4940',
        \ 'diff_red':     '#55393d',
        \ 'diff_green':   '#2e4434',
        \ 'diff_blue':    '#354157',
        \ 'diff_yellow':  '#4e432f',
        \
        \ 'red':          '#ff7ab2',
        \ 'green':        '#93c76b',
        \ 'blue':         '#8addff',
        \ 'yellow':       '#d9c87c',
        \ 'orange':       '#ffa14f',
        \ 'purple':       '#d9bbfe',
        \
        \ 'none':         'NONE'
        \ }

  " Codes
  if a:style ==# 'default'
    " from Xcode
    let theme = {
          \ 'xString':       '#fe8170',
          \ 'xCharNum':      '#d9c87c',
          \ 'xKeyword':      '#ff7ab2',
          \ 'xPreprocStm':   '#ffa14f',
          \ 'xPreproc':      '#ffa14f',
          \ 'xURL':          '#6599ff',
          \ 'xAttribute':    '#cb9768',
          \ 'xTypeDecl':     '#69dffe',
          \ 'xOtherDecl':    '#4eafcb',
          \ 'xType':         '#abf1e3',
          \ 'xField':        '#78c1b3',
          \ 'xFunc':         '#93c66c',
          \ 'xOtherType':    '#d9bbfe',
          \ 'xOtherFiled':   '#b180eb',
          \ 'xOtherFunc':    '#b180eb',
          \ }
  elseif a:style ==# 'onedark'
    " joshdick / onedark.vim
    " bojan / xcode-one-dark
    let theme = {
          \ 'bg':            '#272c32',
          \ 'fg':            '#b5bfcb',
          \ 'grey':          '#6c7582',
          \ 'red':           '#e68085',
          \ 'green':         '#9fcb8a',
          \ 'blue':          '#71bdf2',
          \ 'yellow':        '#eacb8e',
          \
          \ 'xString':       '#9fcb8a',
          \ 'xCharNum':      '#dba570',
          \ 'xKeyword':      '#d191e3',
          \ 'xPreprocStm':   '#53a667',
          \ 'xPreproc':      '#5ebd75',
          \ 'xURL':          '#dba570',
          \ 'xAttribute':    '#dba570',
          \ 'xTypeDecl':     '#eacb8e',   
          \ 'xOtherDecl':    '#6ca3f4',
          \ 'xType':         '#e5c07b',
          \ 'xField':        '#df8e90',
          \ 'xFunc':         '#7cb2f6',
          \ 'xOtherType':    '#5bcbcc',
          \ 'xOtherFiled':   '#4fa0a2',
          \ 'xOtherFunc':    '#4fa0a2',
          \ }
  endif
  return extend(palette, theme)
endfunction "}}}
function! jcolor#highlight(group, fg, bg, ...) "{{{
  execute 'highlight' a:group
        \ 'guifg=' . a:fg
        \ 'guibg=' . a:bg
        \ 'gui=' . (a:0 >= 1 ?
        \ (a:1 ==# 'undercurl' ?
        \ (g:jcolor#tmux ?
        \ 'underline' :
        \ 'undercurl') :
        \ a:1) :
        \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
        \ a:2 :
        \ 'NONE')
endfunction "}}}
function! jcolor#ft_gen(path, last_modified, msg) "{{{
  " Generate the `after/ftplugin` directory.
  let full_content = join(readfile(a:path), "\n") " Get the content of `colors/jcolor.vim`
  let ft_content = []
  let rootpath = jcolor#ft_rootpath(a:path) " Get the path to place the `after/ftplugin` directory.
  call substitute(full_content, '" ft_begin.\{-}ft_end', '\=add(ft_content, submatch(0))', 'g') " Search for 'ft_begin.\{-}ft_end' (non-greedy) and put all the search results into a list.
  for content in ft_content
    let ft_list = []
    call substitute(matchstr(matchstr(content, 'ft_begin:.\{-}{{{'), ':.\{-}{{{'), '\(\w\|-\)\+', '\=add(ft_list, submatch(0))', 'g') " Get the file types. }}}}}}
    for ft in ft_list
      call jcolor#ft_write(rootpath, ft, content) " Write the content.
    endfor
  endfor
  call jcolor#ft_write(rootpath, 'text', "let g:jcolor_last_modified = '" . a:last_modified . "'") " Write the last modified time to `after/ftplugin/text/jcolor.vim`
  if a:msg ==# 'update'
    echohl WarningMsg | echom '[jcolor] Updated ' . rootpath . '/after/ftplugin' | echohl None
  else
    echohl WarningMsg | echom '[jcolor] Generated ' . rootpath . '/after/ftplugin' | echohl None
  endif
endfunction "}}}
function! jcolor#ft_write(rootpath, ft, content) "{{{
  " Write the content.
  let ft_path = a:rootpath . '/after/ftplugin/' . a:ft . '/jcolor.vim' " The path of a ftplugin file.
  " create a new file if it doesn't exist
  if !filereadable(ft_path)
    call mkdir(a:rootpath . '/after/ftplugin/' . a:ft, 'p')
    call writefile([
          \ "if !exists('g:colors_name') || g:colors_name !=# 'jcolor'",
          \ '    finish',
          \ 'endif'
          \ ], ft_path, 'a') " Abort if the current color scheme is not jcolor.
    call writefile([
          \ "if index(g:jcolor_loaded_file_types, '" . a:ft . "') ==# -1",
          \ "    call add(g:jcolor_loaded_file_types, '" . a:ft . "')",
          \ 'else',
          \ '    finish',
          \ 'endif'
          \ ], ft_path, 'a') " Abort if this file type has already been loaded.
  endif
  " If there is something like `call jcolor#highlight()`, then add
  " code to initialize the palette and configuration.
  if matchstr(a:content, 'jcolor#highlight') !=# ''
    call writefile([
          \ 'let s:configuration = jcolor#get_configuration()',
          \ 'let s:palette = jcolor#get_palette(s:configuration.style)'
          \ ], ft_path, 'a')
  endif
  " Append the content.
  call writefile(split(a:content, "\n"), ft_path, 'a')
endfunction "}}}
function! jcolor#ft_rootpath(path) "{{{
  " Get the directory where `after/ftplugin` is generated.
  if (matchstr(a:path, '^/usr/share') ==# '') || has('win32') " Return the plugin directory. The `after/ftplugin` directory should never be generated in `/usr/share`, even if you are a root user.
    return fnamemodify(a:path, ':p:h:h')
  else " Use vim home directory.
    if has('nvim')
      return stdpath('config')
    else
      if has('win32') || has ('win64')
        return $VIM . '/vimfiles'
      else
        return $HOME . '/.vim'
      endif
    endif
  endif
endfunction "}}}
function! jcolor#ft_newest(path, last_modified) "{{{
  " Determine whether the current ftplugin files are up to date by comparing the last modified time in `colors/jcolor.vim` and `after/ftplugin/text/jcolor.vim`.
  let rootpath = jcolor#ft_rootpath(a:path)
  execute 'source ' . rootpath . '/after/ftplugin/text/jcolor.vim'
  return a:last_modified ==# g:jcolor_last_modified ? 1 : 0
endfunction "}}}
function! jcolor#ft_clean(path, msg) "{{{
  " Clean the `after/ftplugin` directory.
  let rootpath = jcolor#ft_rootpath(a:path)
  " Remove `after/ftplugin/**/jcolor.vim`.
  let file_list = split(globpath(rootpath, 'after/ftplugin/**/jcolor.vim'), "\n")
  for file in file_list
    call delete(file)
  endfor
  " Remove empty directories.
  let dir_list = split(globpath(rootpath, 'after/ftplugin/*'), "\n")
  for dir in dir_list
    if globpath(dir, '*') ==# ''
      call delete(dir, 'd')
    endif
  endfor
  if globpath(rootpath . '/after/ftplugin', '*') ==# ''
    call delete(rootpath . '/after/ftplugin', 'd')
  endif
  if globpath(rootpath . '/after', '*') ==# ''
    call delete(rootpath . '/after', 'd')
  endif
  if a:msg
    echohl WarningMsg | echom '[jcolor] Cleaned ' . rootpath . '/after/ftplugin' | echohl None
  endif
endfunction "}}}
function! jcolor#ft_exists(path) "{{{
  return filereadable(jcolor#ft_rootpath(a:path) . '/after/ftplugin/text/jcolor.vim')
endfunction "}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker fmr={{{,}}}:
