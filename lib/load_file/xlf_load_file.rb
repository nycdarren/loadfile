require 'nokogiri'
require_relative 'load_file_entry'

module LoadFile
  class XlfLoadFile
    # Initializes an XlfLoadFile instance with an IO object to read from
    #
    # @param io [IO] an IO object to read the loadfile
    #
    # @return [XlfLoadFile] an instance of a XlfLoadFile
    def initialize(io)
      @io = io
    end

    # Implementing the Enumerable interface, calling the block with a LoadFileEntry
    #
    # Parses XLF Load File 
    #
    # @return [Enumerator] An Enumerator yielding a LoadFileEntry
    def entries
      xml_doc  = Nokogiri::XML( io )
      xml_doc.xpath('//entry').lazy.map { |entry| parse_entry(entry) }
    end

    private def parse_entry(entry)   
      LoadFile::LoadFileEntry.new(control_number: entry['control-number'] ,
                                  volume: entry.xpath('volume').text  ,
                                  image_path: entry.xpath('image-path').text + entry.xpath('image-name').text )
      
    end

    private

    attr_reader :io
  end
end
