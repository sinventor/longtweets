class ChatController < WebsocketRails::BaseController
  def new_message
    # Here we call the rails-websocket broadcast_message method
    File.open("tmp/info2.txt", "w") do |f|
      f.write("start")
      f.write("processed")
    end
    begin 
      chat = PublicChat.create(text: data["message"], user_id: data["user_id"])
      File.open("tmp/info1.txt", "w") do |f|
        f.write(chat.id)
        f.write(chat.text)
      end
    rescue Exception => e
      File.open('tmp/wrong.txt', 'w') do |f|
        f.write(e.message)
      end
    end
    broadcast_message :new_message, data
  end
end
