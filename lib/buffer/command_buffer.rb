# command_buffer.rb - class CommandBuffer track commands for undo/redo

# CommandBuffer class is used for the interactive command shell. Invoked with meta_semicolon.
class CommandBuffer
  def initialize
    @a_buff = []
    @b_buff = []
    @name = 'Command Buffer'
  end

  def <<(command)
    @a_buff.push command
  end

  def back
    value = @a_buff.pop
    @b_buff.unshift value
    value
  end

  def fwd
    value = @b_buff.shift
    @a_buff.push value
    value
  end

  def to_a
    @a_buff + @b_buff
  end

  def at_start?
    @a_buff.empty?
  end

  def at_end?
    @b_buff.empty?
  end
end
