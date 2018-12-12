require 'minitest/autorun'
require 'load_file'

class LoadFileEntryTests < MiniTest::Test
  # Test for full equality. Since LoadFileEntry is a value object its identity
  # is the sum of all its attributes. Therefore, for two LoadFileEntries to be equal
  # requires control number, volume, and image path of the LoadFileEntries are equal.
  def test_equals
    assert_equal LoadFile::LoadFileEntry.new(control_number: "test-000001",
                                             volume: "Import Test 01",
                                             image_path: "IMAGES\001\test-000001.tif"),
                 LoadFile::LoadFileEntry.new(control_number: "test-000001",
                                             volume: "Import Test 01",
                                             image_path: "IMAGES\001\test-000001.tif")
  end

  # Given the definition of equality above, two LoadFileEntries are not equal if
  # any one of their attribute are not equal.
  def test_not_equals
    refute_equal LoadFile::LoadFileEntry.new(control_number: "test-000001",
                                             volume: "Import Test 01",
                                             image_path: "IMAGES\001\test-000001.tif"),
                 LoadFile::LoadFileEntry.new(control_number: "test-000002",
                                             volume: "Import Test 01",
                                             image_path: "IMAGES\001\test-000002.tif")
  end
end
