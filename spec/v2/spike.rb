# spike.rb - spike simple tests like xUnit

require_relative 'assertions'


$befores = []
$tests = []
$afters = []

class Passed
  def message
    'Passed'
  end
end

def closure &blk
  yield
end

def test &blk
  $tests << blk
end


def before &blk
  $befores << blk
end

def after &blk
  $afters << blk
end

# execution phase
def combine list
  list.map { |e| $befores + [e] + $afters }
end


def lambdaize list
  list.map {|e| ->() { e.each {|f| f.call } } }
end

def run list
list.map do |e|
  begin
    e.call
    Passed.new
  rescue => err
    err
  end
end
end

# statistics
def passed list
  list.count {|e| Passed === e }
end


def skipped list
  list.count {|e| SkipException === e }
end
def non_passed list
  list.reject {|e| Passed === e }
end

def failures list
  list.select {|e| AssertionFailure === e }
end

def errors list
  list.length - passed(list) - failures(list).length - skipped(list)
end

def stats list
  puts <<EOD
  Total: #{list.length}
  Passed: #{passed(list)}
  Failures: #{failures(list).length}
  Errors: #{errors(list)}
  Skips: #{skipped(list)}
EOD
end

def report list
  ndxs = non_passed(list).each_with_index
  non_passed(list).flat_map {|e| [ndxs.next[1] + 1, e.message, ignore_this_file(e.backtrace)[0]] }.each_with_index do |e, i|
    puts e
  end
end



def separator
  puts
end
# main
def main
  c = combine $tests
  l = lambdaize c
  r = run l.shuffle
  report r
  separator
  stats r
  non_passed(r).length == 0 ? 0 : 1
end


at_exit do 
  result = main
  exit result
end