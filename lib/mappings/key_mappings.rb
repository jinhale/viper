# key_mappings.rb - method key_mappings returns a hash of keys to syms
def key_mappings
  {
    "\u0011" => :ctrl_q,
    "\eZZ" => :shift_zz,
    "\001" => :ctrl_a,
    "\005" => :ctrl_e,
    "\u0017" => :ctrl_w,
    "\u0006" => :ctrl_f,
    "\u0012" => :ctrl_r,
    "\u0014" => :ctrl_t,
    "\002" => :ctrl_b,
    "\u0013" => :ctrl_s,
    "\003" => :ctrl_c,
    "\u0016" => :ctrl_v,
    "\u0018" => :ctrl_x,
    "\u001A" => :ctrl_z,
    "\u0015" => :ctrl_u,
    "\u000F" => :ctrl_o,
    "\u0010" => :ctrl_p,
    "\004" => :ctrl_d,
    "\a" => :ctrl_g,
    "\b" => :ctrl_h,
    # duplicated with tab key
    # "\t" => :ctrl_i,
    "\u0019" => :ctrl_y,
    "\n" => :ctrl_j,
    "\v" => :ctrl_k,
    "\f" => :ctrl_l,
    "\u000E" => :ctrl_n,
    "\t" => :tab,
    "\u007F" => :backspace,
    "\033[A" => :up,
    "\033[B" => :down,
    "\033[C" => :right,
    "\033[D" => :left,

    # Function keys
    "\eOP" => :fn_1,
    "\eOQ" => :fn_2,
    "\eOR" => :fn_3,
    "\eOS" => :fn_4,
    "\e[15~" => :fn_5,
    "\e[17~" => :fn_6,
    "\e[18~" => :fn_7,
    "\e[19~" => :fn_8,
    "\e[20~" => :fn_9,
    "\e[21~" => :fn_10,
    # FN_11 is not accessable
    "\e[24~" => :fn_12,
    # punctuation and other characters
    ';' => :semicolon,
    ':' => :colon,
    '.' => :period,
    ',' => :comma,
    '?' => :question,
    '!' => :exclamation,
    '~' => :tilde,
    '`' => :accent,
    '@' => :at,
    '#' => :number,
    '$' => :dollar,
    '%' => :percent,
    '^' => :caret,
    '&' => :ampersand,
    '*' => :asterisk,
    '(' => :lparen,
    ')' => :rparen,
    '-' => :hyphen,
    '_' => :underline,
    '=' => :equals,
    '+' => :plus,
    '\\' => :backslash,
    '/' => :slash,
    '|' => :pipe,
    "'" => :apostrophe,
    '"' => :quote,
    '<' => :less,
    '>' => :greater,
    '[' => :lbracket,
    ']' => :rbracket,
    '{' => :lbrace,
    '}' => :rbrace,
    # Shift Arrow keys
    "\e[1;2C" => :shift_right,
    "\e[1;2D" => :shift_left,
    # "\e[A" => :shift_up,
    # "\e[B" => :shift_down
    "\e[H" => :shift_home,
    "\e[F" => :shift_end,
    "\e[5~" => :shift_pgup,
    "\e[6~" => :shift_pgdn,

    # Meta characters
    "∂" => :meta_d,
    "…" => :meta_colon,
    "\e[3~" => :delete_at
  }
end
