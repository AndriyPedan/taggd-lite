class Users::SessionsController < Devise::SessionsController
  def destroy
    current_user.retailers.update_all(current: false)
    super
  end
end
