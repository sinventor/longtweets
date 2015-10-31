class HomeController < ApplicationController
  def show
  end

  def about_us
    WebsocketRails[:weets].trigger 'deliver', { text: ' Ioppp' }
    @developers = [
    						    {
    						  	  name: 'Рушан Аляутдинов', 
    						  	  email: 'rushan_orline@mail.ru'
    						    }
  							  ]
  end
end
