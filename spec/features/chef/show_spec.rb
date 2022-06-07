require 'rails_helper'

RSpec.describe 'chef show page' do 
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

  it 'shows name of chef' do 
    visit chef_path(chef_1.id)

    expect(page).to have_content(chef_1.name)
  end

  it 'has link to list of all ingredients' do 
    visit chef_path(chef_1.id)

    click_link "All Ingredients"

    expect(current_path).to eq(chef_ingredients_path(chef_1.id))
  end

  it 'shows three most popular ingredients' do 
    visit chef_path(chef_1.id)

    expect(page).to have_content(ingredient_1.name)
    expect(page).to have_content(ingredient_2.name)
    expect(page).to have_content(ingredient_3.name)
    expect(page).to_not have_content(ingredient_7.name)
  end
end