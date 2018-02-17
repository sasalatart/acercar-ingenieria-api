class RenameVideoUrlCodeToVideoUrl < ActiveRecord::Migration[5.1]
  def change
    rename_column :majors, :video_url_code, :video_url
  end
end
