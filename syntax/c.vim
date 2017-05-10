" Highlight Class and Function names
syn match    cParen    "(" contains=cParen,cCppParen
syn match    cFunc     "\w\+\s*(" contains=cParen
syn match    cScope    "::"
syn match    cClass    "\w\+\s*::" contains=cScope

hi def link cFunc  Function
hi def link cClass Function
syn match cFunc "\<\h\w*\>\(\s\|\n\)*("me=e-1 contains=cType,cDelimiter,cDefine
syn match cPointer "(\s*\*\s*\h\w*\s*)\(\s\|\n\)*(" contains=cDelimiter,cOperator

hi def link cPointer cFunction
