class UserPreferencesController < ApplicationController

  def index
    @all_user_prefs = UserPreference.all
    @user_prefs = @all_user_prefs.where(user_id: session[:user_id])
  end


  def show
    @user_pref = UserPreference.find_by(id: params[:id])
  end


  def new
    @new_user_pref = UserPreference.new
    @criteria = Criterium.all

    render layout: false
  end


  def create
    if session[:user_id]
      @new_user_pref = UserPreference.create!(userpref_params)
      render partial: "user_preferences/newcriteria", layout: false
    else
      flash[:notice] = "You must be a member to add your preference!"
      redirect_to new_user_preference_path
    end
  end


  def edit
    @user_pref = UserPreference.find_by(id: params[:id])

    render layout: false
  end


  def update
    @user_pref = UserPreference.find_by(id: params[:id])
    if session[:user_id] == @user_pref.user_id
      @user_pref.update_attributes(userpref_params)
      render partial: "user_preferences/editcriteria"
      # redirect_to user_preferences_path
    else
      flash[:notice] = "You cannot edit these criteria"
      redirect_to edit_userpreference_path
    end
  end


  def destroy
    @user_pref = UserPreference.find_by(id: params[:id])
    if session[:user_id] == @user_pref.user_id
      @user_pref.destroy!
      if request.xhr?
        render text: 'Deleted'
      else
        redirect_to user_preferences_path
      end
    else
      redirect_to user_preferences_path
    end
  end


private

  def userpref_params
    params.permit(:criterium_id, :score, :search).merge(user_id: session[:user_id])
  end
end
