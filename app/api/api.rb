class API < Grape::API
  prefix "api"  
  format :json
  
  helpers do 
    def warden
      env["warden"]
    end
    
    def current_user
        @current_user ||= User.authorize!(env)
    end
    
    def authenticated
      return true if warden.authenticated?
      params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
    end
    
    def current_user
      warden.user || @user
    end
  end
  
  before do
    authenticated
  end
  
  mount Messanger::Room
  mount Messanger::Friend
  mount Messanger::User
end


