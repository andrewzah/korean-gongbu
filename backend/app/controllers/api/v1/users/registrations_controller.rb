module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          register_success && return if resource.persisted?

          register_failed
        end

        def register_success
          render json: {
            message: 'Signed up sucessfully.',
            user: current_api_v1_user
          }
        end

        def register_failed
          render json: { message: "Something went wrong." }, status: :unprocessable_entity
        end
      end
    end
  end
end
