module AnonymizerHelper

	def random_humanized_string(min_length, max_length)


		return ((0... min_length + rand(max_length - min_length)).map { (65 + rand(26)).chr }.join).humanize

	end

	def random_birth_date

		time_earliest =  Time.now - 120.years
        time_latest = Time.now - 18.years

		return Time.at((time_latest.to_f - time_earliest.to_f)*rand + time_earliest.to_f)

	end


	def random_gender

		if rand > 0.508 #US population is 50.8% female
                
	        return "male"

	      else

	        return "female"

        end

	end

	def random_address_1

		random_street_number = rand(1..99999).to_s

		random_street_name = random_humanized_string(6,12)

		if rand < 0.3

			random_street_type = "Ave"

		elsif rand >= 0.3 && rand < 0.7

			random_street_type = "Street"

		else

			random_street_type = "Road"

		end


		return random_street_number + " " + random_street_name + " " + random_street_type
	end


	def random_address_2

		random_address_number = rand(10..9999).to_s

		if rand > 0.5

			random_address_type = "Suite"
		else

			random_address_type = "Apt"
		end

		return random_address_type + " " + random_address_number
	end

	def random_person_code

		return "0" + rand(1..4).to_s

	end


	def random_integer_with_length(length)

		min_value = (10 ** (length - 1))
		max_value = (10 ** length) - 1

		return rand(min_value..max_value).to_s

	end


end
