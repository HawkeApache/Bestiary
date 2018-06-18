Given("I do not exist as a user") do
  #no user in db
end

When("I sign in with valid credentials") do
  visit '/users/sign_in'
  fill_in "user_email", with: "test@example.com"
  fill_in "user_password", with: "passwd123"
  click_on "Zaloguj"
end

Then("I see an invalid credentials message") do
  expect(page).to have_content("Błędny adres email lub hasło.")
end


Given("I exist as a user") do
  @user = FactoryBot.create(:user)
end

Given("I am not signed in") do
  visit '/users/sign_in'
  expect(page).not_to have_content("Jesteś aktualnie zalogowany.")
end

Then("I see a success message") do
  expect(current_path).to eql(root_path)
  expect(page).to have_content("Edytuj profil")
  expect(page).to have_content("Wyloguj się")
end

When("I sign in with a wrong email") do
  visit '/users/sign_in'
  fill_in "user_email", with: "invalid@example.com"
  fill_in "user_password", with: "passwd123"
  click_on "Zaloguj"
end

Then("I see an invalid credential message") do
  expect(page).to have_content("Błędny adres email lub hasło.")
end

When("I sign in with a wrong password") do
  visit '/users/sign_in'
  fill_in "user_email", with: "test@example.com"
  fill_in "user_password", with: "invalidpasswd"
  click_on "Zaloguj"
end


Given("I exist as an Admin") do
  @admin = FactoryBot.create(:user, email: 'admin@admin.com', role: 'admin')
end

Given("I sign in with valid credentials as Admin") do
  visit '/users/sign_in'
  fill_in "user_email", with: 'admin@admin.com'
  fill_in "user_password", with: "passwd123"
  click_on "Zaloguj"
end
