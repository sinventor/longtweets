module TweetsHelper
  def tweet(tweet)
    client=Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.config.twitter_key
      config.consumer_secret = Rails.application.config.twitter_secret
      config.access_token=current_user.oauth_token
      config.access_token_secret=current_user.oauth_secret
    end
    message=" отправлено с longtweets.ru"
    tmp_file = "tmp/image.jpg"
    client.update_with_media(tweet[0,20]+message,File.new(tmp_file))
    File.delete(tmp_file) if File.exists?(tmp_file)
  end

  def text_to_image(text)
    image=Magick::Image.new(50,50)
    draw=Magick::Draw.new
    optimal_width=80
    offset=0
    positions=[]
    while positions.length<text.length/optimal_width
      space_index=get_index_nearest_space(text,offset*optimal_width+optimal_width)
      if space_index != -1
        positions << space_index
      else
        positions << offset*optimal_width+optimal_width
      end
      offset+=1
    end
    positions.each { |pos| text[pos]="\n" }
    current_metrics=draw.get_multiline_type_metrics(image,text)
    width=current_metrics.width
    height=current_metrics.height
    image=Magick::Image.new(width+20,height+20)
    draw.text(13,13,text)
    draw.draw(image)
    begin
      unless File.exists? "tmp/image.jpg"
        written_file = "image.jpg"
      else
        written_file = "image2.jpg"
      end
      image.write("tmp/"+written_file)
      return true
    rescue 
      return false
    end
  end

  def get_index_nearest_space(str, index)
    while true
      if index < 0
        return -1
      end
      if str[index]==" "
        return index
      end
      index=index-1
    end
  end
end
