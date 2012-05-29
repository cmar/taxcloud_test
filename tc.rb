require "savon"

cart_id = rand(9999)
order_id = rand(9999)

api_login_id = '1B3D4440'
api_key = '77CE20A3-0805-4A3D-BF36-AD7FC4D39BA0'

# create a client for your SOAP service
client = Savon::Client.new("https://api.taxcloud.net/1.0/?wsdl")
puts client.wsdl.soap_actions

response = client.request(:ping) do
  soap.body = { 'apiLoginID' => api_login_id,
                'apiKey' => api_key
              }
end

puts response.body

response = client.request(:lookup) do
  soap.body = { 'apiLoginID' => api_login_id,
                'apiKey' => api_key,
                'customerID' => '1',
                'cartID' => cart_id,
                'cartItems' => [
                  {'CartItem' => {
                    'Index' => 1,
                    'ItemID' => 'SKU-001',
                    'TIC' => 0,
                    'Price' => 544.99,
                    'Qty' => 3 }},
                    {'CartItem' => {
                    'Index' => 2,
                    'ItemID' => 'SHIPPING',
                    'TIC' => 11010,
                    'Price' => 10.00,
                    'Qty' => 1 }}
                ],
                'origin' => {
                  'Address1' => '7735 OLD GEORGETOWN RD STE 510',
                  'Address2' => '',
                  'City' => 'Bethesda',
                  'State' => 'MD',
                  'Zip5' => '20814',
                  'Zip4' => ''
                },
                  # 331 Church St. San Francisco, CA 94114
                'destination' => {
                  'Address1' => '331 Church St',
                  'Address2' => '',
                  'City' => 'San Francisco',
                  'State' => 'CA',
                  'Zip5' => '94114',
                  'Zip4' => ''
                }
              }
  puts soap.body
end

puts response.body

response = client.request(:authorized_with_capture) do
  soap.body = { 'apiLoginID' => api_login_id,
                'apiKey' => api_key,
                'customerID' => '1',
                'cartID' => cart_id,
                'orderID' => order_id,
                'dateAuthorized' => DateTime.now,
                'dateCaptured' => DateTime.now
              }
end
puts response.body
