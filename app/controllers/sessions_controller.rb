class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
  	user=User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.from_omniauth(request.env["omniauth.auth"])
    File.open("tmp/oat.txt", "w") do |w|
      w.write(JSON.pretty_generate(auth))
    end
  	reset_session
    session[:user_id]=user.id
  	redirect_to tweets_path
  end

  def destroy
  	session[:user_id]=nil
  	redirect_to root_path
  end
end
