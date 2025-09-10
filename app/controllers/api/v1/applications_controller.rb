module Api
  module V1
    class ApplicationsController < ApplicationController
      

      load_and_authorize_resource :job 
      load_and_authorize_resource :application, through: :job, shallow: true


      def create
        # byebug
        if params[:application][:document].present?
          @application.build_document(file: params[:application][:document])
        end
        if @application.save
          JobApplicationMailer.with(application: @application).created_email.deliver_later
          render json: ApplicationSerializer.new(@application).
          serializable_hash, status: :ok
        else
          render json: {errors: @application.errors.full_messages}, status: :unprocessable_entity
        end
      end

      def show
        render json: ApplicationSerializer.new(@application).serializable_hash, status: :ok
      end

      def index
        # byebug

        @q = @applications.ransack(params[:q])
        @applications = @q.result(distinct: true)

        render json: ApplicationSerializer.new(@applications).serializable_hash, status: :ok
      end

      def destroy
        @application.destroy
        render json: { message: "Application deleted successfully" }, status: :ok
      end
      

      def change_status
        # byebug
        
        if @application.update(status: params[:status])
          JobApplicationMailer.with(application: @application).status_changed_email.deliver_later
          render json: ApplicationSerializer.new(@application).serializable_hash, status: :ok
        else
          render json: { errors: @application.errors.full_messages }, status: :unprocessable_entity
        end
      end


      def application_params
        params.require(:application).permit(:cgpa, :yoe, :name, :age, :email)
      end
    end
  end

end