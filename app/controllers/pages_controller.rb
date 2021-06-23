class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      redirect_to todos_path
    else
      redirect_to new_user_session_path
    end
    # user_signed_in? ? redirect_to todos_path : redirect_to new_user_session_path
  end
end
