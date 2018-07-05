require 'sinatra'
# require 'url_safe_base64'
require 'base64'
require 'pstore'

get '/:url' do  
    original = ShortURL.read(params[:url])


    if original 
        redirect "http://" + original
    else 
        p "SORRY...URL, YOU ENTERED NOT FOUND"
end
end 

get '/' do
    "ENTER YOUR URL HERE usings Curl POST request"
end

post '/' do
    url = generate_short_url(params[:url])

    "Your Shorten URL is : #{url} \n "
end

def generate_short_url(original) 
    ShortURL.save(Base64.encode64(original)[0..6], original)

   "localhost:4567/" + Base64.encode64(original) [0..6]
end

class ShortURL
    def self.save(encoded, original)
        store.transaction {|t| store[encoded] = original }
    end

    def self.read(encoded)
        store.transaction { store[encoded] }
    end

        def self.store
            @store ||= PStore.new("shortened_urls.db") #making a DATABASE Purpose
        end
end 
 
