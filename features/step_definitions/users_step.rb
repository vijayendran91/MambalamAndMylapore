

Given("I visit {string}") do |string|
  page.driver.get('v1/api/users')
  print "#{page.html}"
end

Given /^User with following details cretes an account using post call$/ do |table|
  table = table.raw
  keys = table.first
  data = {}
  (1..table.length-1).each do |i|
    count = 0
    table[i].each do |user|
      data[keys[count].to_sym] = user
      count += 1
    end
  end
  binding.pry
  page.driver.post('v1/api/user/signup', data.to_json)
  print "#{page.html}"
end

Given("User with following details cretes an account") do |table|
  table = table.raw
  keys = table.first
  data = {}
  (1..table.length-1).each do |i|
    count = 0
    table[i].each do |user|
      data[keys[count].to_sym] = user
      count += 1
    end
  end
  @user = user_signup(data)
end

And /^I get user details for username "([^"]*)" successfully$/ do |username|
  @user_data = get_user_with_username(username)
  expect(@user_data.errors.empty?).to eq(true)
end
