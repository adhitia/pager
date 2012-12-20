require 'test_helper'

class Array
  include Pager
end

describe 'filtered_page' do
  before do
    @unfiltered = %w(a b c d e f g h i j)
  end

  it "filter with the supplied block" do
    assert_equal ['a'], @unfiltered.filtered_page(1) {|x| %w(a b c).include?(x)}
  end

  it "start filtering at the offset index" do
    assert_equal ['e', 'h'], @unfiltered.filtered_page(2, offset: 'd') {|x| %w(a e h).include?(x)}
  end

  it "stops filtering when limit satisfied" do
    assert_equal ['a', 'f'], @unfiltered.filtered_page(2) {|x| %w(a f h).include?(x)}
  end

  it 'keeps the current offset after done filtering' do
    @unfiltered.filtered_page(2) {|x| %w(c d).include?(x)}
    assert_equal 'e', @unfiltered.current_offset
  end

  it 'return next batch when called again' do
    assert_equal ['a'], @unfiltered.filtered_page(1) {|x| %w(a b c).include?(x)}
    assert_equal ['b'], @unfiltered.filtered_page(1) {|x| %w(a b c).include?(x)}
  end

  it 'return empty array when no more element' do
    assert_equal [], @unfiltered.filtered_page(1) {|x| %w(z).include?(x)}
  end

  it 'return filtered result if nothing more to filter' do
    assert_equal ['a','b'], @unfiltered.filtered_page(5) {|x| %w(a b z).include?(x)}
  end
end
