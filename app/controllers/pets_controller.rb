class PetsController < ApplicationController

  get '/pets' do
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    
    @pet.save
    
    redirect to "pets/#{@pet.id}"
  end
  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  post '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])

    if params[:pet][:owner_ids]
      @pet.owner_id=params[:pet][:owner_ids].first
    end

    if !params[:owner][:name].empty?
      owner = Owner.create(name: params[:owner][:name])
      @pet.owner = owner
    end
    
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  # patch '/pets/:id' do 
  #   if !params[:pet].keys.include?("owner_ids")
  #     params[:pet]["owner_ids"] = []
  #   end
    
  #   @pet = Pet.find(params[:id])
  #   @pet.update(params[:owner])
  #   @pet.save
    
  #   if !params["owner"]["name"].empty?
  #     @pet.owners << Owner.create(name: params["owner"]["name"])
  #   end
    
  #   redirect to "/pets/#{@pet.id}"
  # end
end