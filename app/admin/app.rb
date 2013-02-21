ActiveAdmin.register App do

	menu :priority => 20

	index do                            
		column :name
		column :url_slug
		column :admin_user
		column :created_at
		default_actions                   
	end                                 

	filter :email                       

	form do |f|                         
		f.inputs "App Details" do
			f.input :name
			f.input :url_slug
			f.input :status, label: "Status", as: :radio,
        collection: [:active, :private, :disabled]
		end                               
		f.actions                         
	end

controller do

  def create
  	@app = App.new(params[:app])
  	@app.admin_user = current_admin_user
  	if @app.save
  		redirect_to admin_app_path(:id => @app.id)
  	else
  		render 'new'
  	end
  end

end


end                                   
