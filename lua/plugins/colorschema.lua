return {
  {
    'ameiurl/seoul256.vim',
    config = function()
        vim.cmd [[
            let g:seoul256_background = 236
            colorscheme seoul256 
            hi phpVarSelector       guifg=#FFBFBD              gui=none
            "hi phpIdentifier        guifg=#C8C8C8              gui=none
            "hi phpVarSelector       guifg=#C8C8C8              gui=none
            hi phpStringSingle      guifg=#BCDDBD              gui=none
            hi phpStringDouble      guifg=#BCDDBD              gui=none
            hi phpFunctions         guifg=#e2c792              gui=none
            hi phpMethods           guifg=#e2c792              gui=none
            hi phpSpecialFunction   guifg=#e2c792              gui=none
            hi phpBaselib           guifg=#e2c792              gui=none
            hi phpNumber            guifg=#e55561              gui=none
            hi phpFloat             guifg=#e55561              gui=none
            hi htmlTag              guifg=#98BC99              gui=none
            hi htmlEndTag           guifg=#98BC99              gui=none
            hi javaScript           guifg=#C8C8C8              gui=none
        ]]
    end,
  },
}
