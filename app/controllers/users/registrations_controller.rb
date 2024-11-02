class Users::RegistrationsController < Devise::RegistrationsController
  # For Authorities
  def new_authority
    @user = User.new  # Render the sign-up form for authorities
  end

  def create_authority
    @user = User.new(user_params)
    @user.role = 'authority'  # Assign role to 'authority' only

    if @user.save
      sign_in @user  # Automatically sign in after successful creation
      redirect_to authority_dashboard_path  # Redirect to authority dashboard
    else
      render :new_authority  # Render the registration page again if unsuccessful
    end
  end

  # For Normal Users
  def new_normal_user
    @user = User.new  # Render the sign-up form for normal users
  end

  def create_normal_user
    @user = User.new(user_params)
    @user.role = 'normal_user'  # Assign role to 'normal_user' only

    if @user.save
      sign_in @user  # Automatically sign in after successful creation
      redirect_to normal_user_dashboard_path  # Redirect to normal user dashboard
    else
      render :new_normal_user  # Render the registration page again if unsuccessful
    end
  end

  private

  # Permit the required user attributes (name, email, password, password_confirmation)
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
