# make_bindings.rb - returns hash of key bindings to procs

def key_inserter_proc(bind_h, set)
  set.each_with_object(bind_h) { |e, h| s, p =  inserter(e); h[s] = p }
end

def special_inserter_proc(bind_h, set)
  set.each_with_object(bind_h) { |e, h| _s, p = inserter(e[1]); h[e[0]] = p }
end

def make_bindings
  result = {}
  key_inserter_proc(result, ('a'..'z'))
  key_inserter_proc(result, ('A'..'Z'))
  key_inserter_proc(result, ('0'..'9'))

  # Control characters
  result[:ctrl_q] = ->(_b) { :quit }
  result[:shift_zz] = ->(b) { b.save; exit }
  result[:shift_home] = ->(b) { b.front_of_line; say b.at }
  result[:shift_end] = ->(b) { b.back_of_line; say b.at }
  result[:shift_pgup] = ->(b) { b.beg; say 'top of buffer' }
  result[:shift_pgdn] = ->(b) { b.fin; say 'bottom of buffer' }
  result[:ctrl_y] = ->(_b) { :cmd_yank }
  result[:ctrl_w] = ->(b) { word = b.word_fwd; b.fwd(word.length); b.srch_fwd(/\w+/); say word }
  result[:ctrl_o] = ->(b) { b.back_of_line; b.ins "\n"; say b.at }
  result[:ctrl_p] = ->(b) { say b.look_ahead.join("\n") }
  result[:ctrl_f] = ->(_b) { :cmd_ifind }
  result[:ctrl_r] = ->(_b) { :cmd_irev_find }
  result[:ctrl_g] = ->(_b) { :cmd_again }
  result[:ctrl_z] = lambda { |b|
    if b.can_undo?
      b.undo
      say 'Undone'
    else
      say BELL
    end
  }
  result[:ctrl_u] = lambda { |b|
    if b.can_redo?
      b.redo
      say 'Redone'
    else
      say BELL
    end
  }

  # command controls
  result[:ctrl_d] = ->(_b) { say BELL }
  result[:ctrl_c] = ->(_b) { say BELL }
  result[:ctrl_s] = ->(_b) { :cmd_w }

  # punctuation
  result[:colon] = insert_sym ':'
  result[:semicolon] = insert_sym ';'
  result[:period] = insert_sym '.'
  result[:comma] = insert_sym ','
  result[:space] = inserter(' ')[1]

  special_inserter_proc(result, [
                          [:apostrophe, "'"], [:quote, '"'],
                          [:asterisk, '*'], [:accent, '`'], [:at, '@'],
                          [:tilde, '~'], [:exclamation, '!'], [:number, '#'],
                          [:dollar, '$'], [:percent, '%'], [:caret, '^'],
                            [:ampersand, '&'],
                          [:lparen, '('], [:rparen, ')'], [:hyphen, '-'],
                          [:underline, '_'], [:plus, '+'], [:equals, '='],
                          [:backslash, '\\'], [:pipe, '|'],
                          [:lbracket, '['], [:rbracket, ']'],
                          [:lbrace, '{'], [:rbrace, '}'],
                          [:less, '<'], [:greater, '>'], [:question, '?'], [:slash, '/']
                        ])
  result[:return] = ->(b) { b.ins "\n"; say 'return' }
  result[:tab] = ->(b) { handle_tab(b) }
  result[:ctrl_h] = ->(_b) { :cmd_help }
  result[:ctrl_j] = ->(b) { say b.at }
  result[:ctrl_k] = ->(b) { say b.col }
  result[:ctrl_l] = ->(b) { say b.line }
  result[:right] = ->(b) { b.fwd; say b.at }
  result[:left] = ->(b) { b.back; say b.at }
  result[:up] = ->(b) { b.up; say b.line }
  result[:down] = ->(b) { b.down; say b.line }
  result[:backspace] = lambda { |b|
    if b.mark_set?
      $clipboard = b.cut; say 'selection deleted'
    else
      ch = b.del; say "delete #{ch}"
    end
  }

  # Function keys
  result[:fn_1] = ->(_b) { :cmd_help }
  result[:fn_2] = ->(_b) { :cmd_report }
  result[:fn_3] = ->(_b) { :cmd_keys }
  # result[:fn_4] = ->(b) { say BELL }

  # copy and paste keys
  result[:ctrl_c] = ->(b) { $clipboard = b.copy; say 'copy' }
  result[:ctrl_v] = ->(b) { b.ins($clipboard); say 'paste' }
  result[:ctrl_x] = ->(b) { $clipboard = b.cut; say 'cut' }

  result[:shift_right] = ->(b) { say "lit #{b.at}"; b.set_if_not_set; b.fwd }
  result[:shift_left] = ->(b) { b.set_if_not_set; b.back; say "lit #{b.at}" }
  # mark set FN key
  result[:fn_4] = lambda { |b|
    if b.mark_set?
      b.unset_mark
      say 'mark unset'
    else
      b.set_mark
      say 'mark set'
    end
  }
  result[:ctrl_a] = ->(b) { b.beg; b.set_mark; b.fin; say 'select all' }
  result[:shift_up] = ->(_b) { say BELL }
  result[:shift_down] = ->(_b) { say BELL }

  # Meta Command sequences
  result[:meta_d] = ->(b) { play_chord(b, :meta_d) }
  result[:meta_colon] = ->(_b) { :command }

  # rotate the buffer ring
  result[:ctrl_t] = ->(_b) { :cmd_n }
  result[:delete_at] = ->(b) { c = b.del_at; say "delete #{c}" }
  result
end
