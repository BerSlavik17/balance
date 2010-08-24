class SettingsController < ApplicationController
  def at_begin
    @setting = Setting.find_or_create_by_key('at_begin', :value => '0')
  end

  def update
    @setting = Setting.find params[:id]

    if @setting.update_attributes params[:setting]
      redirect_to items_path
    else
      render :edit
    end
  end
end
