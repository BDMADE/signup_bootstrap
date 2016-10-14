require_dependency "signup/application_controller"

module Signup
  class UsersController < ApplicationController
    before_action :set_user, :match_user, only: [:show, :edit, :update, :destroy]
    before_action :authorized?, :admin?, except: [:signup, :create]
    before_action :go_back_if_not_admin , except: [:signup,:create,:edit,:show,:update]

    # GET /users
    def index
      @users = User.all
    end

    # GET /users/1
    def show
    end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit
    end

    # POST /users
    def create
      @user = User.new(user_params)

      if @user.save
        log_in @user
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /users/1
    def destroy
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end

    # sign up page
    def signup
      if current_user.nil?
        @user = User.new
      else
        redirect_to user_path(current_user) ,alert: 'Already signed in !'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation, :admin)
      end
    # it matches current user with database and prevents to edit/update other user profile
    def match_user
      if not admin?
        user = User.find(current_user)

        if not user.id == set_user.id
          redirect_to user_path(current_user),notice: 'You have not permission to grant this page !'
        end
      end
    end

  end
end
