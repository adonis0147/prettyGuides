if !has('conceal')
    finish
endif

if !exists('g:PrettyGuidesEnable')
    let g:PrettyGuidesEnable = 1
endif

if !exists('g:PrettyGuidesChar')
    if &encoding ==? 'utf-8'
        let g:PrettyGuidesChar = '¦'
    else
        let g:PrettyGuidesChar = '|'
    endif
endif

if !exists('g:PrettyGuidesFileTypesIncluded')
    let g:PrettyGuidesFileTypesIncluded = []
endif

if !exists('g:PrettyGuidesFileTypesExcluded')
    let g:PrettyGuidesFileTypesExcluded = ['']
endif


function! s:PrettyGuidesToggle()
    if s:PrettyGuidesToggle
        let s:PrettyGuidesToggle = 0
        call s:PrettyGuidesEnable()
    else
        let s:PrettyGuidesToggle = 1
        call s:PrettyGuidesDisable()
    endif
endfunction

function! s:PrettyGuidesEnable()
    call prettyGuides#enable()
endfunction

function! s:PrettyGuidesDisable()
    call prettyGuides#disable()
endfunction

function! s:PrettyGuidesProcessAutocmd()
    if g:PrettyGuidesEnable
        let s:PrettyGuidesToggle = 0
        call s:PrettyGuidesEnable()
    else
        let s:PrettyGuidesToggle = 1
        finish
    end
endfunction


command! -bar PrettyGuidesToggle call s:PrettyGuidesToggle()
command! -bar PrettyGuidesEnable call s:PrettyGuidesEnable()
command! -bar PrettyGuidesDisable call s:PrettyGuidesDisable()

autocmd BufWinEnter * call s:PrettyGuidesProcessAutocmd()