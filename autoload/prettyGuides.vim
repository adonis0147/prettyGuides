function! prettyGuides#init()
    set conceallevel=1
    set concealcursor=nivc
    syntax sync minlines=100
    syntax sync maxlines=200

    call prettyGuides#initColor()
endfunction

function! prettyGuides#getPatterns()
    let l:number = &shiftwidth
    let w:indentPattern = '\s'
    let w:headIndentPattern = ''
    
    for i in range(1, number - 1)
        let w:indentPattern = w:indentPattern . '\s'
        let w:headIndentPattern = w:headIndentPattern . '\s'
    endfor

    let w:indentPattern = '/\(^\(' . w:indentPattern . '\)\+\)\@<=\s/'
    let w:headIndentPattern = '/^\s\(' . w:headIndentPattern . '\)\@=/'
endfunction

function! prettyGuides#initColor()
    let l:termColorString = 'ctermfg=' . string(g:PrettyGuidesTermColor) . ' ctermbg=NONE'
    let l:guiColorString = 'guifg=' . g:PrettyGuidesGuiColor . ' guibg=NONE'
    exec 'highlight Conceal ' . l:termColorString . ' ' . l:guiColorString
endfunction

function! prettyGuides#display()
    call prettyGuides#getPatterns()
    exec 'syntax match IndentPattern ' . w:indentPattern . ' containedin=ALL conceal cchar=' . g:PrettyGuidesChar
    exec 'syntax match HeadIndentPattern ' . w:headIndentPattern . ' containedin=ALL conceal cchar=' . g:PrettyGuidesChar
endfunction

function! prettyGuides#clear()
    syntax clear IndentPattern
    syntax clear HeadIndentPattern
endfunction

function! prettyGuides#checkFileTypes()
    if g:PrettyGuidesDefaultFileTypesExcluded == 1
        let l:fileTypesExcluded = ['', 'text', 'markdown', 'tex']
    else
        let l:fileTypesExcluded = []
    endif

    if index(g:PrettyGuidesFileTypesExcluded, &ft) != -1
        let w:FileTypesFlag = 0
    elseif len(g:PrettyGuidesFileTypesIncluded) != 0 && index(g:PrettyGuidesFileTypesIncluded, &ft) == -1
        let w:FileTypesFlag = 0
    elseif index(l:fileTypesExcluded, &ft) != -1
        let w:FileTypesFlag = 0
    else
        let w:FileTypesFlag = 1
    endif
endfunction

function! prettyGuides#enable()
    call prettyGuides#checkFileTypes()

    if w:FileTypesFlag
        call prettyGuides#init()
        call prettyGuides#display()
    endif
endfunction

function! prettyGuides#disable()
    call prettyGuides#clear()
endfunction
