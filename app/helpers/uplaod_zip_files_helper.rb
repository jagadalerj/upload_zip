module UplaodZipFilesHelper


def read_file(file, xml_file_name)
	@xml_file_names = []
	@content = []
	Zip::File.open(file.zip_file.path) do |zipfile|
      zipfile.each do |entry|
        @xml_file_names << entry.name if (entry.name =~ /.xml$/).present?
        if xml_file_name == entry.name
          @content << entry.get_input_stream.read && break if params[:filter].blank?
          parse_xml_string(entry)
        end
      end
    end
    rescue 
    flash[:error] = 'Can not read zip file.'  
end

def parse_xml_string(entry)
    @random_string = [*('A'..'Z'),*('a'..'z')].sample(20).join
    @doc = Nokogiri::XML.parse(entry.get_input_stream.read)
    results = @doc.xpath(params[:filter])
    results.map do |x|
      node = Nokogiri::XML::Node.new @random_string, @doc
      x.add_previous_sibling(node) if @doc.root != x
      @content << x.to_s
    end
    rescue
      flash[:error] = 'X-path are not correct.'
end

end
