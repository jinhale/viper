# iterate_commands.rb - method iterate_commands

def iterate_commands(sexps, &_blk)
  fail CommandBlockExpected.new unless block_given?
  result = nil
  sexps.each do |s|
    cmd, args = s
    result = exec_cmd cmd, yield, *args
  end

  result
end
