class FilesController < ApplicationController
  def view
    fn = Rails.root.to_path + '/files/' + Subject.find(params[:id]).pic
    send_data File.read(fn), :type => 'image/jpeg', :disposition => 'inline'
  end
end
