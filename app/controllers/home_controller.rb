class HomeController < ApplicationController
  def show
  end

  def about_us
    @developers=[
    						  {
    						  	name: 'Рушан Аляутдинов', 
    						  	email: 'rushan_orline@mail.ru'
    						  }
  							]
  end
end
