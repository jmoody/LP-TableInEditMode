require 'calabash-cucumber/calabash_steps'

def step_pause
  sleep STEP_PAUSE
end

def row_exists? (row_name)
  !query("tableViewCell marked:'#{row_name}'", :accessibilityIdentifier).empty?
end

def should_see_row (row_name)
  unless row_exists? row_name
    screenshot_and_raise "i do not see a row named #{row_name}"
  end
end

def should_not_see_row(row_name)
  if row_exists? row_name
    screenshot_and_raise "i should not have seen row named #{row_name}"
  end
end

def row_with_label_and_text_exists? (row_id, label_id, text)
  arr = query("tableViewCell marked:'#{row_id}' child tableViewCellContentView child label marked:'#{label_id}'", :text)
  (arr.length == 1) and (arr.first.eql? text)
end

def should_see_row_with_label_with_text (row_id, label_id, text)
  unless row_with_label_and_text_exists? row_id, label_id, text
    actual = query("tableViewCell marked:'#{row_id}' child tableViewCellContentView child label marked:'#{label_id}'", :text)
    screenshot_and_raise "expected to see row '#{row_id}' with label '#{label_id}' that has text '#{text}', but found '#{actual}'"
  end
end


def scroll_until_i_see_row (dir, row_id, limit)
  unless row_exists? row_id
     count = 0
     begin
       scroll("scrollView index:0", dir)
       sleep(STEP_PAUSE)
       count = count + 1
     end while ((not row_exists?(row_id)) and count < limit.to_i)
   end
   unless row_exists?(row_id)
     screenshot_and_raise "i scrolled '#{dir}' '#{limit}' times but did not see '#{row_id}'"
   end
end


Then /^I scroll (left|right|up|down) until I see the "([^\"]*)" row limit (\d+)$/ do |dir, row_name, limit|
  scroll_until_i_see_row dir, row_name, limit
end


Then /^I touch row number (\d+)$/ do |index|
  index = index.to_i + 1
  screenshot_and_raise "Index should be positive (was: #{index})" if (index<=0)
  touch("tableViewCell index:#{index-1}")
  sleep(STEP_PAUSE)
end

def touch_row (row_name)
  touch("tableViewCell marked:'#{row_name}'")
  step_pause
end

Then /^I touch row "([^"]*)"$/ do |row_name|
  touch_row row_name
end

Then /^I touch the "([^"]*)" row$/ do |row_name|
  touch_row row_name
end

def table_exists? (table_name)
  !query("tableView marked:'#{table_name}'", :accessibilityIdentifier).empty?
end

def should_see_table (table_name)
  res = table_exists? table_name
  unless res
    screenshot_and_raise "could not find table with access id #{table_name}"
  end
end

def should_not_see_table (table_name)
  res = table_exists? table_name
  if res
    screeenshot_and_raise "expected not to find table with access id #{table_name}"
  end
end

Then /^I touch the "([^"]*)" section header$/ do |header_name|
  touch("tableView child view marked:'#{header_name}'")
  wait_for_animation
end

Then /^I should see the "([^"]*)" table in edit mode$/ do |table_id|
  unless query("tableView marked:'#{table_id}'", :isEditing).first.to_i == 1
    screenshot_and_raise "expected to see table '#{table_id}' in edit mode"
  end
end

Then /^I should see (?:the|an?) "([^"]*)" row$/ do |name|
  should_see_row name
end

Then /^the (first|second) row should be "([^"]*)"$/ do |idx, name|
  index = -1
  (idx.eql? "first") ? index = 0 : index = 1
  res = query("tableViewCell", :accessibilityIdentifier)[index]
  unless res.eql? name
    screenshot_and_raise "i expected the #{idx} row would be #{name}, but found #{res}"
  end
end


def swipe_on_row (dir, row_name)
  swipe(dir, {:query => "tableViewCell marked:'#{row_name}'"})
  step_pause
  @row_that_was_swiped = row_name
end

Then /^I swipe (left|right) on the "([^"]*)" row$/ do |dir, row_name|
  swipe_on_row dir, row_name
end

def should_not_see_delete_confirmation_in_row(row_name)
  unless query("tableViewCell marked:'#{row_name}' child tableViewCellDeleteConfirmationControl").empty?
    screenshot_and_raise "should see a delete confirmation button on row #{row_name}"
  end
end


def should_see_delete_confirmation_in_row(row_name)
  if query("tableViewCell marked:'#{row_name}' child tableViewCellDeleteConfirmationControl").empty?
    screenshot_and_raise "should see a delete confirmation button on row #{row_name}"
  end
end

def touch_delete_confirmation(row_name)
  touch("tableViewCell marked:'#{row_name}' child tableViewCellDeleteConfirmationControl")
  step_pause
end

def edit_mode_delete_button_exists? (row_name)
  !query("tableViewCell marked:'#{row_name}' child tableViewCellEditControl").empty?
end

def should_see_edit_mode_delete_button (row_name)
  unless edit_mode_delete_button_exists? row_name
    screenshot_and_raise "should see a edit mode delete button on row #{row_name}"
  end
end

def should_not_see_edit_mode_delete_button (row_name)
  if edit_mode_delete_button_exists? row_name
    screenshot_and_raise "i should not see an edit mode delete button on row #{row_name}"
  end
end

def reorder_button_exists? (row_name)
  #TableViewCellReorderControl
  !query("tableViewCell marked:'#{row_name}' child tableViewCellReorderControl").empty?
end

def should_see_reorder_button (row_name)
  unless reorder_button_exists? row_name
    screenshot_and_raise "i should be able to see reorder button on row #{row_name}"
  end
end

def should_not_see_reorder_button (row_name)
  if reorder_button_exists? row_name
    screenshot_and_raise "i should not see reorder button on row #{row_name}"
  end
end



Then /^I should be able to swipe to delete the "([^"]*)" row$/ do |row_name|
  swipe_on_row "left", row_name
  should_see_delete_confirmation_in_row row_name
  touch_delete_confirmation row_name
  should_not_see_row row_name
end

Then /^I touch the delete button on the "([^"]*)" row$/ do |row_name|
  should_see_edit_mode_delete_button row_name
  touch("tableViewCell marked:'#{row_name}' child tableViewCellEditControl")
  step_pause
  should_see_delete_confirmation_in_row row_name
end

Then /^I use the edit mode delete button to delete the "([^"]*)" row$/ do |row_name|
  macro %Q|I touch the delete button on the "#{row_name}" row|
  touch_delete_confirmation row_name
  should_not_see_row row_name
end

Then /^I should see "([^"]*)" in row (\d+)$/ do |cell_name, row|
  res = query("tableViewCell index:#{row}", :accessibilityIdentifier).first
  unless res.eql? cell_name
    screenshot_and_raise "expected to see '#{cell_name}' in row #{row} but found '#{res}'"
  end
end

Then /^I should see the rows in this order "([^"]*)"$/ do |row_ids|
  tokens = row_ids.split(",")
  counter = 0
  tokens.each do |token|
    token.strip!
    macro %Q|I should see "#{token}" in row #{counter}|
    counter = counter + 1
  end
end

Given /^that the table is not in edit mode$/ do
  result = query("tableView marked:'table'", :isEditing).first.to_i
  unless result == 0
    touch("navigationButton index:0")
  end
end

Then /^I should see that row "([^"]*)" has title "([^"]*)"$/ do |row_id, row_title|
  should_see_row_with_label_with_text row_id, "label", row_title
end

Then /^I should see row "([^"]*)"$/ do |row_id|
  should_see_row row_id
end


Then /^I touch the edit button$/ do
  touch("navigationButton index:0")
end

Then /^I should be able to see the delete and reorder buttons in row "([^"]*)"$/ do |row_id|
  can_see_delete = edit_mode_delete_button_exists? row_id
  can_see_move = reorder_button_exists? row_id
  unless can_see_delete && can_see_move
    screenshot_and_raise "i should be able to see the table-edit-mode delete and reorder buttons"
  end
end
