When("I visit beasts page") do
  visit '/beasts'
end

Then("I can see list of all beasts") do
  expect(page).to have_content("Spis bestii")
end

Then("I can see button to adding beasts") do
  expect(page).to have_selector(:link_or_button, "Dodaj nową bestię")
end