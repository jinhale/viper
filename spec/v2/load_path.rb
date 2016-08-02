# load_path.rb - loads stuff for testing, running

require_relative 'hal'
require_relative 'frame_stack'
require_relative 'quoted_string'
require_relative 'string_literal'
require_relative 'glob'
require_relative 'deref'
require_relative 'assignment'
require_relative 'argument'
require_relative 'lazy_argument'
require_relative 'command'
require_relative 'redirection'
require_relative 'statement'
require_relative 'block'
require_relative 'sub_shell'
require_relative 'sub_shell_expansion'
require_relative 'pipe'
require_relative 'boolean_and'
require_relative 'boolean_or'
require_relative 'alias_declaration'
require_relative 'function'
require_relative 'function_declaration'
require_relative 'lambda'
require_relative 'lambda_declaration'
# get all the commands
Dir['./bin/*.rb'].each {|f| require_relative f }
require_relative 'visher'
require_relative 'null_facade'
require_relative 'string_io_facade'
require_relative 'io_factory'

require_relative 'vfs_node'
require_relative 'vfs_root'
Dir['./bufnode/*.rb'].each {|f| require_relative f }

require_relative 'virtual_machine'
