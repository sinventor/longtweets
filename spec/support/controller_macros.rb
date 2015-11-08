module ControllerMacros

  def set_session_for_user(user)
    session[:user_id] = user.id
  end

end
