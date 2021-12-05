require 'rubygems' 
require 'twilio-ruby' 

class TwilioClient
	def sendSMS(phone)
		account_sid = 'ACfafcaff2e143c3bb631414349aaa16c5' 
		auth_token = '4e81e21eafdb1605a88dfc144e5b7638' 
		client = Twilio::REST::Client.new(account_sid, auth_token) 
        x = 4
        message = "OTP is  "
        otp = ""
        while x > 0
            otp += rand(9).to_s
            x -= 1
        end
        message += otp
		message = client.messages.create(
			from: '+17724448696',
			to: phone,
			body: message
		)
        return otp
	end
end