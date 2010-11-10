" Vim plugin to add auto-detection of the HTML encoding for installed Windows
" codepages (those that are well-supported) and auto-detection of any installed
" codepage from an HTML encoding.
"
" Maintainer: Ben Fritz <fritzophrenic@gmail.com>
" Version: 1

if exists('g:loaded_2html_wincp_plugin')
  finish
else
  let g:loaded_2html_wincp_plugin = 1
endif

if has('autocmd') && exists('##SourcePre') && has('win32') || has('win64')
  augroup TOHTML_CPWIN32
    au!
    " automatically load HTML encodings installed codepages only once, right
    " before the first TOhtml conversion.
    if exists('g:loaded_2html_plugin') &&
          \ str2float(strpart(g:loaded_2html_plugin, 3)) >= 7.3 &&
          \ str2nr(substitute(g:loaded_2html_plugin, '.*_v', '', '')) >= 7
      au SourcePre $VIMRUNTIME/autoload/tohtml.vim call tohtml_wincp#get_installed_cps()
      au SourcePre $HOME/vimfiles/autoload/tohtml.vim call tohtml_wincp#get_installed_cps()
      au SourcePre $VIMRUNTIME/autoload/tohtml.vim echomsg "hello world!"
    else
      au SourcePre syntax/2html.vim echomsg "Warning: wrong version of 2html to autodetect Windows codepages"
    endif
  augroup END
endif
