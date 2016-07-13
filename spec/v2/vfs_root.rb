# vfs_root - class VFSRoot - parent node of all nodes, and holder  for subtrees


class VFSRoot
  def initialize 
    @root = VFSNode.new nil, ''
    @wd = @root
  end
  attr_reader :root, :wd


  def pwd
    pathr = []
    p = @wd
    until p.parent.nil?
      pathr << p
      p = p.parent
    end
    '/' + pathr.reverse.map {|e| e.name }.join('/')
  end
  def path_to_elements path
    elements = path.split('/')
    if elements[0].nil? || elements[0].empty?
      elements[0] = @root
    else
    elements.unshift @wd
  end
  elements
  end
  def _chdir elements, start=@wd
    elements.each do |e|
      start = start[e]
    end
    binding.pry if start.nil?
    fail "cd: path not found" if start.nil?
    @wd = start
  end
  def _mkdir elements, start=@root
    node = start
    elements.each do |e|
      if node[e].nil?
        node = node.mknode e
      else
        node = node[e]
      end
  end
end
  def cd path
    start, *elements = path_to_elements(path)
    _chdir elements, start
  end
  def mkdir_p path
    start, *elements = path_to_elements path
    _mkdir elements, start
  end
  def node elements, start=@root
    elements.each do |e|
      start = start[e]
    end
    start
  end
  def directory? path
          start, *elements = path_to_elements path
    mynode = node elements, start
    mynode.instance_of? VFSNode
  end
  def list path='.'
    if path == '.'
      @wd.keys
    else
      start, *elements = path_to_elements path
      mynode = node(elements, start)
      mynode.keys
    end
  end
  def contains? path
    start, *elements = path_to_elements path
    !@root[elements[0]].nil?
  end
end
