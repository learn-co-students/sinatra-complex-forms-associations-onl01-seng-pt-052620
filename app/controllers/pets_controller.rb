class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet][:name]) 

    if !params[:pet][:owner_id].empty?
      @pet.owner_id = params[:pet][:owner_id]
      @pet.save
    else
      @pet.owner = Owner.create(name: params[:pet][:owner_name])
      @pet.save
    end
    
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 

    redirect to "pets/#{@pet.id}"
  end
end