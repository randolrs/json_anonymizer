module ApplicationHelper

	def anonymized_file_directory

		return 'anonymized_data/'

	end

	def anonymized_files_array

    	data_directory = Dir.open anonymized_file_directory #get directory from anonymized_file_directory set in helper function

    	@files = Array.new 

	    data_directory.each do |file|

	      extension_type = file.last(5).downcase #get file extension (specific to JSON)

	      if extension_type == ".json" #test if file is JSON

	        data = File.read(anonymized_file_directory + file)

	        json_data = JSON.parse(data)

	        if json_data

	          file_index = json_data[0]['anonymized_file_index']

	        end

	        @files << {"file_name" => file, "anonymized_file_index" => file_index, "json_data" => json_data}
	      
	      end

	    end

	    return @files

	end
end
