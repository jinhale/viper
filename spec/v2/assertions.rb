
# assertions.rb - methods for assert and its kin



def ignore_this_file list
      list.map {|e| e.split(':') }.reject {|e| e[0] == __FILE__ }.map {|e| e.join(':') }
end

class BaseAssertionException < RuntimeError
  def backtrace
    # super.map {|e| e.split(':') }.reject {|e| e[0] == __FILE__ }.map {|e| e.join(':') }
    super
  end
end

class AssertionFailure < BaseAssertionException
end

def assert expr, message='Expected true, got false'
  raise AssertionFailure.new(message) unless expr
end

def assert_eq left, right
  assert(left == right, "Expected #{left} to equal #{right}")
end

def assert_is actual, klass
  assert(klass === actual, "Expected #{actual} to be instance of #{klass}, got #{actual.class.name}")
end

# skips
class SkipException < BaseAssertionException
end

def skip message='skipped'
  raise SkipException.new(message)
end
