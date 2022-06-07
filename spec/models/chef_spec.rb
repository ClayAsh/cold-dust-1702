require 'rails_helper'

RSpec.describe Chef, type: :model do
  let!(:chef_1) {Chef.create!(name: "Boyardee")}
  let!(:dish_1) {chef_1.dishes.create!(name: "Ravioli" , description: "delicious" )}
  let!(:dish_2) {chef_1.dishes.create!(name: "Spaghetii" , description: "delicious" )}
  let!(:ingredient_1) {dish_1.ingredients.create!(name: "cheese", calories: 234)}
  let!(:ingredient_2) {dish_1.ingredients.create!(name: "flour", calories: 100)}
  let!(:ingredient_3) {dish_1.ingredients.create!(name: "tomato", calories: 234)}
  
  let!(:ingredient_4) {dish_2.ingredients.create!(name: "cheese", calories: 234)}
  let!(:ingredient_5) {dish_2.ingredients.create!(name: "flour", calories: 100)}
  let!(:ingredient_6) {dish_2.ingredients.create!(name: "tomato", calories: 100)}

  let!(:ingredient_7) {dish_2.ingredients.create!(name: "basil", calories: 100)}

  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it { should have_many(:dish_ingredients).through(:dishes) }
    it { should have_many(:ingredients).through(:dish_ingredients) } 
  end

  it 'shows unique list of ingredients' do 
    expect(chef_1.unique_ingredients).to eq(["basil", "cheese", "flour", "tomato"])
  end

  it 'shows three most popular ingredients' do 
    expect(chef_1.most_popular_ingredients).to eq(["flour", "tomato", "cheese"])
  end
end
