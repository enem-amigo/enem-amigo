require 'test_helper'

class AlternativeTest < ActiveSupport::TestCase

  test 'should save alternative with all atributes' do
    alternative = Alternative.new(letter: 'a', description: 'something')

    assert alternative.save
  end

  test 'should not save alternative without a letter' do
    alternative = Alternative.new(description: 'something')

    assert_not alternative.save
  end

  test 'should not save alternative without a enunciation' do
    alternative = Alternative.new(letter: 'a')

    assert_not alternative.save
  end

  test 'should not save a alternative that length''s letter is more than one' do
    alternative = Alternative.new(letter: 'abc')

    assert_not alternative.save
  end

end