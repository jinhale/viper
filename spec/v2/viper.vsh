_mode=viper mode_keys :(printable)
kname=:(echo -n ' '|xfkey)
_mode=viper bind :kname { ins :_buf ' ' } { echo -n space }
_mode=viper bind move_down { down :_buf } { line :_buf }
_mode=viper bind move_up { up :_buf } { line :_buf }
_mode=viper bind move_left { back :_buf } { at :_buf }
_mode=viper bind move_right { fwd :_buf } { at :_buf }
_mode=viper bind ctrl_j { nop } { at :_buf }
_mode=viper bind ctrl_k { nop } { col :_buf }
_mode=viper bind ctrl_l { nop } { line :_buf }
_mode=viper bind key_backspace { del :_buf } { echo -n delete :(xfkey | xfkey -h) }
_mode=viper bind ctrl_m { echo | ins :_buf } { echo -n new line }
_mode=viper bind key_delete { del_at :_buf } { echo -n delete :(xfkey | xfkey -h) }
function next() { rotate /v/modes/viper/metadata/buffers; _buf=:(peek /v/modes/viper/metadata/buffers); global _buf }
_mode=viper bind ctrl_t { next } { echo -n buffer is now :(basename :_buf) } }


