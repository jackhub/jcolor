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
        \ 'transparent_background': get(g:, 'jcolor_transparent_background', 0),
        \ 'disable_italic_comment': get(g:, 'jcolor_disable_italic_comment', 0),
        \ 'enable_italic': get(g:, 'jcolor_enable_italic', 0),
        \ 'cursor': get(g:, 'jcolor_cursor', 'auto'),
        \ 'menu_selection_background': get(g:, 'jcolor_menu_selection_background', 'blue'),
        \ 'show_eob': get(g:, 'jcolor_show_eob', 1),
        \ 'current_word': get(g:, 'jcolor_current_word', get(g:, 'jcolor_transparent_background', 0) == 0 ? 'grey background' : 'bold'),
        \ 'lightline_disable_bold': get(g:, 'jcolor_lightline_disable_bold', 0),
        \ 'diagnostic_text_highlight': get(g:, 'jcolor_diagnostic_text_highlight', 0),
        \ 'diagnostic_line_highlight': get(g:, 'jcolor_diagnostic_line_highlight', 0),
        \ 'diagnostic_virtual_text': get(g:, 'jcolor_diagnostic_virtual_text', 'grey'),
        \ 'better_performance': get(g:, 'jcolor_better_performance', 0),
        \ }
endfunction "}}}
function! jcolor#get_palette(style) "{{{
  if a:style ==# 'default'
    let palette = {
          \ 'black':      ['#181a1c',   '0'],
          \ 'bg0':        ['#282a2f',   '0'],
          \ 'bg1':        ['#333836',   '0'],
          \ 'bg2':        ['#373c3b',   '0'],
          \ 'bg3':        ['#3d4445',   '0'],
          \ 'bg4':        ['#424b4b',   '0'],
          \ 'bg_red':     ['#ff6d7e',   '0'],
          \ 'diff_red':   ['#55393d',   '0'],
          \ 'bg_green':   ['#a5e179',   '0'],
          \ 'diff_green': ['#394634',   '0'],
          \ 'bg_blue':    ['#7ad5f1',   '0'],
          \ 'diff_blue':  ['#354157',   '0'],
          \ 'diff_yellow':['#4e432f',   '0'],
          \ 'fg':         ['#dedfe0',   '0'],
          \ 'red':        ['#ff7ab2',   '0'],
          \ 'red2':       ['#fe8170',   '0'],
          \ 'red3':       ['#fe8170',   '0'],
          \ 'orange':     ['#ffa14f',   '0'],
          \ 'orange2':    ['#ffa14f',   '0'],
          \ 'yellow':     ['#eacb64',   '0'],
          \ 'green':      ['#93c76b',   '0'],
          \ 'blue':       ['#88deff',   '0'],
          \ 'blue2':      ['#78c1b3',   '0'],
          \ 'blue3':      ['#78c1b3',   '0'],
          \ 'blue4':      ['#78c1b3',   '0'],
          \ 'purple':     ['#d9bbfe',   '0'],
          \ 'purple2':    ['#d9bbfe',   '0'],
          \ 'grey':       ['#828a9a',   '0'],
          \ 'grey2':      ['#5a6477',   '0'],
          \ 'none':       ['NONE',      '0']
          \ }
  elseif a:style ==# 'everforest'
    let palette = {
          \ 'black':      ['#181a1c',   '0'],
          \ 'bg0':        ['#21292f',   '235'],
          \ 'bg1':        ['#293138',   '236'],
          \ 'bg2':        ['#2d363d',   '237'],
          \ 'bg3':        ['#445055',   '238'],
          \ 'bg4':        ['#4c555b',   '239'],
          \ 'bg_red':     ['#4e3e43',   '52'],
          \ 'diff_red':   ['#55393d',   '0'],
          \ 'bg_green':   ['#404d44',   '22'],
          \ 'diff_green': ['#394634',   '0'],
          \ 'bg_blue':    ['#394f5a',   '17'],
          \ 'diff_blue':  ['#354157',   '0'],
          \ 'bg_yellow':  ['#4a4940',   '136'],
          \ 'fg':         ['#cfd3d0',   '223'],
          \ 'red':        ['#f85552',   '160'],
          \ 'red2':       ['#fe8170',   '0'],
          \ 'red3':       ['#fe8170',   '0'],
          \ 'orange':     ['#f57d26',   '116'],
          \ 'orange2':    ['#ffa14f',   '0'],
          \ 'yellow':     ['#dfa000',   '136'],
          \ 'green':      ['#8da101',   '106'],
          \ 'blue':       ['#3a94c5',   '32'],
          \ 'blue2':      ['#78c1b3',   '0'],
          \ 'blue3':      ['#78c1b3',   '0'],
          \ 'blue4':      ['#78c1b3',   '0'],
          \ 'purple':     ['#df69ba',   '162'],
          \ 'purple2':    ['#d9bbfe',   '0'],
          \ 'grey':       ['#a6b0a0',   '247'],
          \ 'grey2':      ['#939f91',   '247'],
          \ 'none':       ['NONE',      '0']
          \ }
  endif
  return palette
endfunction "}}}
function! jcolor#highlight(group, fg, bg, ...) "{{{
  execute 'highlight' a:group
        \ 'guifg=' . a:fg[0]
        \ 'guibg=' . a:bg[0]
        \ 'ctermfg=' . a:fg[1]
        \ 'ctermbg=' . a:bg[1]
        \ 'gui=' . (a:0 >= 1 ?
          \ (a:1 ==# 'undercurl' ?
            \ (g:jcolor#tmux ?
              \ 'underline' :
              \ 'undercurl') :
            \ a:1) :
          \ 'NONE')
        \ 'cterm=' . (a:0 >= 1 ?
          \ (a:1 ==# 'undercurl' ?
            \ 'underline' :
            \ a:1) :
          \ 'NONE')
        \ 'guisp=' . (a:0 >= 2 ?
          \ a:2[0] :
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
