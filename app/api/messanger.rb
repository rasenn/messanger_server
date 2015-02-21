module Messanger
  class API < Grape::API

    format :json
    prefix :api

    helpers do 
      def current_user
        @current_user ||= User.authorize!(env)
      end

      def authenticate!
        error!("401 unauthorized", 401) unless current_user
      end
    end

    resource :rooms do 

      
    end

    resource :friends do
      
    end

    resource :user


  end
end


