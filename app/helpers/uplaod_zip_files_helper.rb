module UplaodZipFilesHelper


def read_file(file, xml_file_name)
	@xml_file_names = []
	@content = []
	Zip::File.open(file.zip_file.path) do |zipfile|
      zipfile.each do |entry|
        @xml_file_names << entry.name if (entry.name =~ /.xml$/).present?
        if xml_file_name == entry.name
          parse_xml_string(entry)
        end
      end
    end
end

def parse_xml_string(entry)
    @content = Nokogiri::XML.parse(entry.get_input_stream.read)
end

end
