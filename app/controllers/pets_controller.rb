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
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      owner.pets << @pet
    else
      owner = Owner.find_by_id(params["pet"]["owner_id"])
      owner.pets << @pet
    end
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

  patch '/pets/:id' do 
    #   ####### bug fix
    #   if !params[:owner].keys.include?("pet_ids")
    #     params[:owner]["pet_ids"] = []
    #     end
    #     #######
    
    #     @owner = Owner.find(params[:id])
    #     @owner.update(params["owner"])
    #     if !params["pet"]["name"].empty?
    #       @owner.pets << Pet.create(name: params["pet"]["name"])
    #     end
    #     redirect "owners/#{@owner.id}"
    # end

    # if !params[:pet].keys.include?("owner_id")
    #   params[:pet]["owner_id"] = []
    # end
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      owner = Owner.create(name: params["owner"]["name"])
      owner.pets << @pet
    else
      owner = Owner.find_by_id(params["pet"]["owner_id"])
      owner.pets << @pet
    end

    redirect to "pets/#{@pet.id}"
  end
end