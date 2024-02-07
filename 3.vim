" Part 1 {{{
function! AddNum(lnum, col)
  " Gets number under position [lnum, col], adds it to the global ans and
  " replaces it with dots
  call cursor(a:lnum, a:col)
  let num_str = expand('<cword>')
  let num_len = len(num_str)
  let num = str2nr(num_str)
  let new_str = substitute(num_str, '\d', '.', 'g')
  let g:ans += num
  exe 'normal! ciw' . new_str . "\<Esc>"
endfunction

function! Search(lnum, col, slnum, scol)
  call cursor(a:lnum, a:col)

  " search backwards
  let match = search('[0-9]', 'bc')

  let l = line('.')
  let c = col('.')
  if match > 0 && abs(l - a:slnum) <= 1 && abs(c - a:scol) <= 1
    " match found in diagonal reach
    call AddNum(l, c)
  endif

  " search forward
  call cursor(a:lnum, a:col)
  let match = search('[0-9]', 'c')

  let l = line('.')
  let c = col('.')
  if match > 0 && abs(l - a:slnum) <= 1 && abs(c - a:scol) <= 1
    " match found in diagonal reach
    call AddNum(l, c)
  endif

  " return to match
  call cursor(a:slnum, a:scol)
endfunction

function! Solve()
  let g:ans = 0
  let last = line('$')
  call cursor(1,1) " go to start of buffer
  while search('[^0-9.]') > 0
    let l = line('.')
    let c = col('.')

    if l > 1
      call Search(l - 1, c, l, c) " search in line above
    endif

    call Search(l, c, l, c) " search in current line

    if l < last
      call Search(l + 1, c, l, c) " search in line below
    endif

    " remove match
    normal! r.
  endwhile
  echomsg "Answer (Part 1): " . g:ans

endfunction
" }}}
" Part 2 {{{ 
function! MulNum(lnum, col)
  call cursor(a:lnum, a:col)
  let num_str = expand('<cword>')
  let num = str2nr(num_str)
  return num
endfunction

function! Search2(lnum, col, slnum, scol)
  call cursor(a:lnum, a:col)
  let r = 1

  " search backwards
  let match = search('[0-9]', 'bc', line('.'))

  let l = line('.')
  let c = col('.')
  if match > 0 && abs(l - a:slnum) <= 1 && abs(c - a:scol) <= 1
    " match found in diagonal reach
    let g:cnt += 1
    let r *= MulNum(l, c)
  endif

  " search forward
  " call cursor(a:lnum, a:col)
  if match > 0
    normal! w
  endif
  let match = search('[0-9]', '', line('.'))

  let l = line('.')
  let c = col('.')
  if match > 0 && abs(l - a:slnum) <= 1 && abs(c - a:scol) <= 1
    " match found in diagonal reach
    let g:cnt += 1
    let r *= MulNum(l, c)
  endif

  " return to match
  call cursor(a:slnum, a:scol)
  return r
endfunction

function! Solve2()
  let g:cnt = 0
  let g:ans = 0
  let last = line('$')
  call cursor(1, 1)
  while search('*') > 0
    let g:cnt = 0
    let ret = 1

    let l = line('.')
    let c = col('.')

    if l > 1
      let ret *= Search2(l - 1, c, l, c) " search in line above
    endif

    let ret *= Search2(l, c, l, c) " search in current line

    if l < last
      let ret *= Search2(l + 1, c, l, c) " search in line below
    endif

    if g:cnt == 2
      let g:ans += ret
      normal! r!
    else
      normal! r.
    endif

    " remove match
    " normal! r.
  endwhile
  echomsg "Answer (Part 2): " . g:ans
endfunction
" }}}
