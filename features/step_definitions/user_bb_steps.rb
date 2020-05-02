Given("I visit {string}") do |url|
  page.driver.get(url)
  print "#{page.html}"
  save_and_open_page
end

Given /^User with following details creates an account using post call$/ do |table|
  table = table.raw
  keys = table[0]
  data = {}
  (1..table.length-1).each do |i|
    inner_table=table[i]
    inner_data ={}
    (0..inner_table.length-1).each do |j|
      data[keys[j].to_sym] = inner_table[j]
    end
  end
  print data
  page.driver.post('v1/api/user/signup', data.to_json)
end

And /^It should be successful$/ do
  expect(page.body)
end
