mkbuf /v/search
mkarray /v/search/bufstack
mkarray /v/search/modestack
_mode=search mode_keys :(printable)
kname=:(echo -n ' '|xfkey)
_mode=search bind :kname { ins :_buf ' ' } { echo -n space }
_mode=search bind move_down { capture { down :_buf; line :_buf } } { cat }
_mode=search bind move_up { capture { up :_buf; line :_buf } } { cat }
_mode=search bind move_left { back :_buf } { at :_buf }
_mode=search bind move_right { fwd :_buf } { at :_buf }
_mode=search bind ctrl_j { nop } { at :_buf }
_mode=search bind ctrl_k { nop } { col :_buf }
_mode=search bind ctrl_l { nop } { line :_buf }
_mode=search bind key_backspace { del :_buf } { echo -n delete :(xfkey | xfkey -h) }
_mode=search bind key_delete { del_at :_buf } { echo -n delete :(xfkey | xfkey -h) }
_mode=search bind move_shift_home { front_of_line :_buf } { at :_buf }
_mode=search bind move_shift_end { back_of_line :_buf } { at :_buf }
_mode=search bind ctrl_m { pattern=:(line /v/search); echo | ins /v/search; _mode=:(pop /v/search/modestack); global _mode; _buf=:(pop /v/search/bufstack); global _buf; srch_fwd :_buf :pattern; rline :_buf } { nop }
_mode=search bind ctrl_f { nop } { echo -n search forward }

