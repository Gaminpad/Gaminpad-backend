ActiveAdmin.register Game do
  
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :status
      f.input :players
    end
    f.actions
  end
  
  
end
