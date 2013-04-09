" Vim plugin to add auto-detection of the HTML encoding for installed Windows
" codepages (those that are well-supported) and auto-detection of any installed
" codepage from an HTML encoding.
"
" Maintainer: Ben Fritz <fritzophrenic@gmail.com>
" Version: 4
" License: MIT <http://opensource.org/licenses/MIT>

if exists('g:loaded_2html_wincp_plugin')
  finish
else
  let g:loaded_2html_wincp_plugin = 3
endif

if has('autocmd') && exists('##SourcePre') && (has('win32') || has('win64'))
  augroup TOHTML_CPWIN32
    au!
    " make sure the setup happens after 2html itself has been loaded to allow
    " verion checking
    autocmd VimEnter * call s:Setup()
  augroup END

  function s:Setup()
    augroup TOHTML_CPWIN32
      au!
      " automatically load HTML encodings installed codepages only once, right
      " before the first TOhtml conversion.
      if exists('g:loaded_2html_plugin')
        let tohtml_ver = split(g:loaded_2html_plugin, 'vim\|_v')
      else
        let tohtml_ver = ["0.0", "0"]
      endif
      if      (str2float(tohtml_ver[0]) > 7.3 ||
            \  str2float(tohtml_ver[0]) == 7.3 &&
            \     str2nr(tohtml_ver[1]) >= 7)
        autocmd SourcePre $VIMRUNTIME/autoload/tohtml.vim call tohtml_wincp#get_installed_cps()
        autocmd SourcePre $HOME/vimfiles/autoload/tohtml.vim call tohtml_wincp#get_installed_cps()
      else
        autocmd SourcePre */syntax/2html.vim echomsg "Warning: wrong version of 2html to autodetect Windows codepages" | sleep 1
      endif
    augroup END
  endfun
endif
