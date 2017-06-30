class PagesController < ApplicationController
  
  require 'json'

  include ApplicationHelper

  include AnonymizerHelper

  def home
  end

  
  def index

    @files = anonymized_files_array #get array of anonymized JSON files, function in helpers/application_helper.rb


  end


  def input_form


  end

  def anonymized_file_show

    id = params[:id].to_i

    @files = anonymized_files_array #get array of anonymized JSON files, function in helpers/application_helper.rb

    @files.each do |file|

      file_index = file['anonymized_file_index']

      if file_index

        if file_index == id

          @anonymized_file = file

        end 

      end

      break if @anonymized_file != nil


    end

    unless @anonymized_file

      flash[:error] = "Cannot locate file."
      redirect_to index_path

    end


  end

  

  def import_file

  	if user_signed_in?

      file_data = params[:upload_file]

      extension_type = File.extname(file_data.original_filename).downcase #get file extension

      if extension_type == ".json" #test if file is JSON

        if file_data.respond_to?(:read)

          file = file_data.read

      		data = JSON.parse(file) #parse JSON file

          tempHash = Array.new #create array to store transformed JSON

          file_name = params[:name] + ".json" #create file name for new anonymized JSON file

          anonymized_file_object = AnonymizedFile.create(:name => file_name)

      		data.each do |entry| #loop through JSON entries

      			# BEGIN transform data from original JSON file
      			
            entry['anonymized_file_index'] = anonymized_file_object.id

            if entry['member_id']

              entry['member_id'] = random_integer_with_length(10) #10 character member ID; function in helpers/AnonymizerHelper.rb

            end

            if entry['person_code']

              entry['person_code'] = random_person_code #function in helpers/AnonymizerHelper.rb

            end

            
            if entry['first_name']

              random_first_name = random_humanized_string(3,12) #function in helpers/AnonymizerHelper.rb

              entry['first_name'] = random_first_name

            end

            if entry['last_name']

              random_last_name = random_humanized_string(3,12) #function in helpers/AnonymizerHelper.rb

              entry['last_name'] = random_last_name

            end

            if entry['date_of_birth']

              entry['date_of_birth'] = random_birth_date.strftime("%Y-%m-%d") #function in helpers/AnonymizerHelper.rb

            end

            if entry['gender']

              entry['gender'] = random_gender #function in helpers/AnonymizerHelper.rb

            end

            if entry['ssn']

              entry['ssn'] = random_integer_with_length(9) #function in helpers/AnonymizerHelper.rb

            end

            if entry['address_1']
              
              entry['address_1'] = random_address_1 #function in helpers/AnonymizerHelper.rb

            end

            if entry['address_2']
              
              entry['address_2'] = random_address_2 #function in helpers/AnonymizerHelper.rb

            end

            if entry['city']

              entry['city'] = random_humanized_string(6,12) #function in helpers/AnonymizerHelper.rb

            end

            if entry['state']

              entry['state'] = random_humanized_string(1,1) #function in helpers/AnonymizerHelper.rb

            end

            if entry['zip']

              entry['zip'] = random_integer_with_length(5) #function in helpers/AnonymizerHelper.rb

            end

            if entry['primary_first_name']

              if random_first_name
                
                entry['primary_first_name'] = random_first_name #function in helpers/AnonymizerHelper.rb
              
              else

                entry['primary_first_name'] = random_humanized_string(3,12) #function in helpers/AnonymizerHelper.rb

              end

            end

            if entry['primary_last_name']

              if random_last_name
                
                entry['primary_last_name'] = random_last_name #function in helpers/AnonymizerHelper.rb
              
              else

                entry['primary_last_name'] = random_humanized_string(3,12) #function in helpers/AnonymizerHelper.rb
              end

            end

            if entry['prescription_number']

              entry['prescription_number'] = random_integer_with_length(8) #function in helpers/AnonymizerHelper.rb

            end

            #END transfom data from original JSON file

            entry['anonymized'] = true #mark entry as anonymized

            tempHash << entry #add transformed data to temporary hash/array

      		end



      		File.open("anonymized_data/" + file_name,"w") do |f|
      			
      			f.write(tempHash.to_json) #write temporary hash array with transformed data as JSON file

          end


          flash[:notice] = "File successfully uploaded and anonymized."

          redirect_to index_path

        else

          #Error message and redirect where user uploads an unreadable JSON file

          flash[:error] = "Read Error. Unreadable JSON file"

          redirect_to input_form_path

        end

      else

        #Error message and redirect where user uploads a non-JSON file

        flash[:error] = "Please upload a .json file"

        redirect_to input_form_path

  		end

  	else

      #redirect to home if user not signed in

  		redirect_to root_path

  	end

  end

end
