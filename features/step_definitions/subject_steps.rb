When("I visit subjects page") do
  visit '/subjects'
end

Given("Subjects are in database") do
  @subject1 = FactoryBot.create(:subject)
  @subject2 = FactoryBot.create(:subject)
end


Then("I can see list of all subjects") do
  expect(page).to have_content("Spis przedmiotów")
  expect(page).to have_content(@subject1.name, @subject1.description)
  expect(page).to have_content(@subject2.name, @subject2.description)
end

Then("I can see button to adding subjects") do
  expect(page).to have_selector(:link_or_button, "Dodaj nowy przedmiot")
end
