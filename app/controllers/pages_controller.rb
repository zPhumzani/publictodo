class PagesController < ApplicationController
  def home
  	redirect_to tasks_path if user_signed_in?
  	@tasks = Task.where(state: 'todo', private: false)
  end

  def about
  end
end
