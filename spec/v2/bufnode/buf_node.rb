# buf_node - class BufNode - subclass VFSNode - like a directory, but a buffer


class BufNode < VFSNode
  def initialize parent, name
    super parent, name
    @list['line'] = StringIO.new
  end
  def mknode name
    @list['nl'] = BufNode.new self, 'nl'
  end
  def insnode text=''
    child = @list['nl']
    baby = mknode ''
    baby['line'] = StringIO.new(text)
    baby['nl'] = child
    baby
  end
  def to_s
    "buf node #{name}"
  end
end
