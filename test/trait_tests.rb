# trait_tests.rb - tests for CharacterTraits

require_relative 'test_helper'



class TraitTests < BaseSpike
  def set_up
    @buf = Buffer.new ''
  end
  # create string sets @buf and positions it at beginning
  def create string
    @buf.ins string
    @buf.beg
  end
  def test_w_no_trait_set_has_returns_false
    create 'hello'
    assert_false @buf.trait_has 'm'
  end
  def test_set_trait
    create 'hello'
    @buf.trait_set 'm'
    assert @buf.trait_has 'm'
  end
  def test_trait_del
    create 'hello'
    @buf.trait_set 'm'
    @buf.trait_del 'm'
    assert_false @buf.trait_has 'm'
  end
  def test_trait_next
    create 'hello'
    @buf.fwd; @buf.fwd; @buf.fwd
    @buf.trait_set 'm'
    @buf.beg
    result = @buf.trait_next 'm'
    assert_eq result, 3
  end
  def test_trait_prev
    create 'hello'
    @buf.trait_set 'm'
    @buf.fin
    result = @buf.trait_prev 'm'
    assert_eq result, 0
  end
  def test_trait_exists
    create 'hello'
    @buf.fin
    @buf.back
    @buf.trait_set 'm'
    @buf.fin
  assert @buf.trait_exists 'm'
  end
  def test_trait_exists_w_no_trait_set
    create 'hello'
    assert_false @buf.trait_exists 'm'
  end
  def test_trait_first_w_no_trait_set_returns_0
    create 'hello'
    assert_eq @buf.trait_first('m'), 0
  end
  def test_trait_first_finds_position
    create 'hello'
    @buf.fwd; @buf.fwd
    @buf.trait_set 'm'
    @buf.fin
    assert_eq @buf.trait_first('m'), 2
  end
  def test_first_does_move_position
    create 'hello'
    @buf.fwd; @buf.fwd
    @buf.trait_set 'm'
    @buf.beg
    var = @buf.trait_first 'm'
    assert_eq @buf.position, 0
  end
  def test_trait_next_does_change_position
    create 'hello'
    @buf.fwd; @buf.fwd
    @buf.trait_set 'm'
    @buf.beg
    @buf.fwd
    var = @buf.trait_next 'm'
    assert_eq @buf.position, 1
  end
  def test_trait_prev_does_change_position
    create 'hello'
    @buf.fwd
    @buf.trait_set 'm'
    @buf.fin
    @buf.trait_prev 'm'
    assert_eq @buf.position, 5
  end
  def test_trait_exists_does_not_change_position
    create 'hello'
    @buf.fwd; @buf.fwd; @buf.fwd
    @buf.trait_set 'm'
    @buf.beg
    var = @buf.trait_exists 'm'
    assert_eq @buf.position, 0
  end
  def test_trait_exists_w_no_mark_set_does_not_change_position
    create 'hello'
    var = @buf.trait_exists 'm'
    assert_eq @buf.position, 0
  end
end