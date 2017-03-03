# virtual_layer_tests.rb - tests for VirtualLayer 

require_relative 'test_helper'


class VirtualLayerTests < BaseSpike
  def set_up
    @vm = VirtualMachine.new
    @vm.mount '/v', env:@vm.ios, frames:@vm.fs
    @vroot = @vm.fs[:vroot]    
    Hal.chdir '/v'
    @wd = @vroot.wd
  end
  def test_chdir_ok
    VirtualLayer.chdir '/v'
  end
  def test_chdir_bad_raises_Errno
        assert_raises Errno::ENOENT do 
      VirtualLayer.chdir '/v/xxx/ttt/ggg'
    end 
  end
  def test_touch
    VirtualLayer.touch '/v/aa'
    assert VirtualLayer.exist? '/v/aa'
  end
  def test_cp_dir
    VirtualLayer.touch '/v/file'
    VirtualLayer.mkdir_p '/v/zzz'
    VirtualLayer.cp '/v/file', '/v/zzz'
    assert VirtualLayer.exist?('/v/zzz/file'), 'Expected /v/zzz/file to exist'
  end
  def test_cp_file_to_non_existant_file
    VirtualLayer.touch 'file'
    VirtualLayer.cp 'file', 'thing'
    assert VirtualLayer.exist?('/v/thing'), 'expected /v/thing to exist'
  end
  def test_cp_file_to_existing_object
    file = VirtualLayer.touch 'file'
    old = VirtualLayer.touch 'old'
    file.print 'hello'
    file.rewind
    assert_eq file.string, 'hello'
    VirtualLayer.cp 'file', 'old'
    new_file = @vroot['/v/old']
    new_file.rewind
    contents = new_file.string
    assert_eq contents, 'hello'
  end
  def test_mv
    VirtualLayer.touch '/v/aa'
    VirtualLayer.mkdir_p '/v/xxx'
    VirtualLayer.mv '/v/aa', '/v/xxx'
    assert VirtualLayer.exist?('/v/xxx/aa')
  end
end
