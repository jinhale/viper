# redirect_stdout - class RedirectStdout - > file


class RedirectStdout < Redirection
  def initialize  target
    super target, 'w'
  end
  def type_key
    :out
  end
end
