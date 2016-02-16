Pay2go.setup do |pay2go|
	if Rails.env.development?
		pay2go.merchant_id = "11513403"
		pay2go.hash_key = "zhHgWSZrZH5aCmDtfYLv5ChLGZNwGu7f"
		pay2go.hash_iv = "LPwIHvaGdfRPCvjR"
		pay2go.service_url = "http://capi.pay2go.com/MPG/mpg_gateway"
	else
		pay2go.merchant_id = "11513403"
		pay2go.hash_key = "zhHgWSZrZH5aCmDtfYLv5ChLGZNwGu7f"
		pay2go.hash_iv = "LPwIHvaGdfRPCvjR"
		pay2go.service_url = "http://capi.pay2go.com/MPG/mpg_gateway"
	end
end