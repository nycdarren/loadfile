require_relative 'load_file_entry'

module LoadFile
  class LfpLoadFile
    # Initializes an LfpLoadFile instance with an IO object to read from
    #
    # @param io [IO] an IO object to read the loadfile
    #
    # @return [OptLoadFile] an instance of a OptLoadFile
    def initialize(io)
      @io = io
    end

    # Implementing the Enumerable interface, calling the block with a LoadFileEntry
    #
    # Reads each line from the IO object provided at initialization, creates a new
    # LoadFileEntry from the contents of the line.
    #
    # @return [Enumerator] An Enumerator yielding a LoadFileEntry
    def entries
      io.each_line.lazy.map { |line| parse_line(line) }
    end

    private def parse_line(line)
     
      _, control_number, _, _ , _, volume, image_path, _  = line.split(/[,;@]/)
      LoadFile::LoadFileEntry.new(control_number: control_number,
                                  volume: volume,
                                  image_path: image_path+control_number+".tif" )
    end

    private

    attr_reader :io
  end
end
