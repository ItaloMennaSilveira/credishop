class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    if resource.save
      flash[:notice] = "Cadastro realizado com sucesso! Por favor, faça login."
      redirect_to new_user_session_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
