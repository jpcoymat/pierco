module Upload


  def set_picture_file(picture_file, picture_filename_field="image_filename")
    attributes_hash = {}
    attributes_hash[picture_filename_field.to_sym] = picture_file.original_filename
    if self.update_attributes(attributes_hash)
      copy_picture_file(picture_file)      
    end
  end
  
  def copy_picture_file(picture_file)
    File.open(Rails.root.join('public','images',picture_file.original_filename),"wb") do |file|
      file.write(picture_file.read)
    end
  end


end
