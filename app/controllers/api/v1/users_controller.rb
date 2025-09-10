module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:index]
      skip_before_action :set_tenant, only: [:index]
      skip_before_action :check_tenant, only: [:index]

      load_and_authorize_resource except: [:me]

      def me #done
        # byebug
        render json: UserSerializer.new(current_user).serializable_hash, status: :ok
      end

      def show 
        render json: UserSerializer.new(@user).serializable_hash, status: :ok
      end

      def index
        render json: UserSerializer.new(@users).serializable_hash, status: :ok
      end

      def get_all #done
        render json: UserSerializer.new(@users).serializable_hash, status: :ok
      end

      def destroy #done

        if @user.destroy
          render json: { status: { code: 200, message: "User deleted successfully." } }, status: :ok
        else
          render json: { status: { message: "User couldn't be deleted. #{user.errors.full_messages.to_sentence}" } },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
