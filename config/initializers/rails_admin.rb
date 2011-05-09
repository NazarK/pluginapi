RailsAdmin.authorize_with do
  redirect_to "user#sign_in" if !current_user
end