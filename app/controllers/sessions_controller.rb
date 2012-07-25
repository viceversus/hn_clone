class SessionsController < Devise::SessionsController
  def create
    @user = User.find_by_email(params[:user][:email])
    if @user.nil? || @user.banned
      flash[:error] = "Error message"
      redirect_to root_path
    else
      super
    end
  end

  def destroy
    super
  end
end