require "httparty"
require "nokogiri"

url = 'https://www.joinclubhouse.com/event/mZrL48zw'

def get_clubhouse_room_information(url)
    

    html = HTTParty.get(url)
    
    response = Nokogiri::HTML(html)
    
    time = response.css("div.ml-1").first.text
    
    title =  response.css("div.text-lg.font-semibold").last.text
    
    avatars = response.css('div.w-16')
    
    avatars_list = Array.new
    avatars.each { |avatar|
        if avatar['style']
            left_colon = avatar['style'].index('(')
            right_colon = avatar['style'].index(')')
            avatars_list << avatar['style'][left_colon + 2 .. right_colon - 2]
        end
        }
    
    
    hosts_list = Array.new
    hosts_text = response.css('em').text
    hosts = hosts_text.sub('w/ ', '').split(',')
    hosts.each { |host|
        host = host.strip
        hosts_list << host
    }
    
    description = response.css('div.text-sm.font-thin.mt-2').text
    description = description.sub(hosts_text, '').strip
    description = description[1..-1]
    description = description.strip
    
    clubhouse_room_information = {
        :title => title,
        :description => description,
        :hosts => hosts_list,
        :avatars => avatars_list,
        :time => time 
    }
    puts clubhouse_room_information
end

get_clubhouse_room_information(url)


