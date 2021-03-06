require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
  end

  describe "instance methods" do
    it "should return total list of ingredients" do
      @chef_1 = Chef.create!(name: "Kris Litman")
      @dish_1 = @chef_1.dishes.create!(name: "dank curry", description: "Southern style fish curry")
      @fish = Ingredient.create(name: "fish", calories: 100)
      @broth = Ingredient.create(name: "Chicken broth", calories: 100)
      @potato = Ingredient.create(name: "Potato", calories: 125)
      @dish_1.ingredients << @fish
      @dish_1.ingredients << @broth
      @dish_1.ingredients << @potato

      expect(@chef_1.all_ingredients).to eq([@fish, @broth, @potato])
    end

    it "returns most poplular" do
      @chef_1 = Chef.create!(name: "Kris Litman")
      @dish_1 = @chef_1.dishes.create!(name: "dank curry", description: "Southern style fish curry")
      @dish_2 = @chef_1.dishes.create!(name: "pazole", description: "sabores de las mayas")
      @corn = Ingredient.create(name: "corn", calories: 50)
      @fish = Ingredient.create(name: "fish", calories: 100)
      @broth = Ingredient.create(name: "Chicken broth", calories: 100)
      @eggs = Ingredient.create(name: "egg", calories: 120)
      @apple = Ingredient.create(name: "apple", calories: 200)
      @potato = Ingredient.create(name: "Potato", calories: 125)
      @dish_1.ingredients << @fish
      @dish_1.ingredients << @broth
      @dish_1.ingredients << @potato
      @dish_1.ingredients << @apple
      @dish_1.ingredients << @eggs
      @dish_2.ingredients << @potato
      @dish_2.ingredients << @fish
      @dish_2.ingredients << @broth

      expect(@chef_1.most_popular).to eq([@fish, @broth, @potato])
    end
  end
end
