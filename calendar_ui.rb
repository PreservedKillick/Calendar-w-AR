require 'bundler/setup'
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file}



database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

system "clear"
def welcome
  puts "Welcome to the calendar app!"
  main_menu
end

def main_menu
  puts "\n\n"
  choice = nil
  until choice == 'x'
    puts "Are you a new user or an existing user?
    \nPress 'l' to sign in as an existing user
    \nPress 'a' to add a new user
    \nPress 'x' to exit program"
    choice = gets.chomp.downcase
    case choice
    when 'l'
      existing_user
    when 'a'
      new_user
    when 'x'
    else
      puts "Invalid choice, please choose 'a', 'l' or 'x'"
    end
  end
end

def new_user
  puts "Please enter the name of the user you would like to add"
  new_user = gets.chomp
  User.create(:name => new_user)
  puts "#{new_user} has been added to the program. Thank you."
  existing_user
end

def existing_user
  system "clear"
  list_user
  puts "\n\nEnter your user name"
  user_name = gets.chomp.capitalize
  this_user = User.find_by(:name => user_name)
  if this_user == nil
    puts "No such user found. Please try again"
  else
    puts "What would you like to do? Press"
    puts "\t'A' to add an event"
    puts "\t'E' to edit an event"
    puts "\t'L' to list events"
    puts "\t'D' to delete an event"
    puts "\t'S' to sort event by start time"
    puts "\t'M' to return to the main menu"
    user_choice = gets.chomp.upcase
    case user_choice
    when 'A'
      add_event(this_user)
    when 'E'
      edit_event(this_user)
    when 'L'
      list_event(this_user)
    when 'D'
      delete_event(this_user)
    when 'S'
      sort_events_by_start(this_user)
    when 'M'
      main_menu
    else
      puts "Please enter a valid entry"
    end
  end
end

def add_event(this_user)

  puts "Enter a description of the event you would like to add"
  event_descr = gets.chomp.downcase
  puts "\nEnter the location of the event"
  event_loc = gets.chomp
  puts "\nEnter the starting date and time of the event (yyyy/mm/dd 00:00)"
  event_start = DateTime.parse(gets.chomp)
  puts "\nEnter the ending date and time of the event (yyyy/mm/dd 00:00)"
  event_end = DateTime.parse(gets.chomp)

  new_event = Event.create({:description => event_descr, :location => event_loc, :start_time => event_start, :finish_time => event_end, :user_id => this_user.id })

  system ('clear')

  puts "Processing....."
  sleep(1)
  system ('clear')
  puts "Processing...."
  sleep(1)
  system ('clear')
  puts "Processing..."
  sleep(1)
  system ('clear')
  puts "Processing.."
  sleep(1)
  system ('clear')
  puts "Processing."
  sleep(1)
  system ('clear')
  puts "Processing"
  sleep(1)


  puts "#{new_event.description} has been added to your calendar."
  puts "\nPress 'A' to add another event, 'M' to return to the main menu or 'X' to exit the program"

  case  gets.chomp.upcase
  when 'A'
    add_event(this_user)
  when 'M'
    main_menu
  when 'L'
    list_event(this_user)
  when 'X'
    puts "Goodbye!"
  else
    puts "Please enter a valid input"
  end
end

def edit_event(this_user)
  list_event(this_user)
  puts "Choose the event you would like to edit"
  user_choice = gets.chomp.downcase
  event_to_edit = Event.find_by(:description => user_choice)
  puts "What would you like to edit:\n
  Press 'D' to update description
  Press 'L' to update location
  Press 'S' to update starting time
  Press 'F' to update finishing time"
  case gets.chomp.upcase
  when 'D'
  puts "Enter a new description to the event"
  event_descr = gets.chomp.downcase
  event_to_edit.update({:description => event_descr})
  when 'L'
  puts "\nEnter a new location for the event"
  event_loc = gets.chomp
  event_to_edit.update({:location => event_loc})
  when 'S'
  puts "\nEnter a new starting date and time of the event (yyyy/mm/dd 00:00)"
  event_start = DateTime.parse(gets.chomp)
  event_to_edit.update({:start_time => event_start })
  when 'F'
  puts "\nEnter a new ending date and time of the event (yyyy/mm/dd 00:00)"
  event_end = DateTime.parse(gets.chomp)
  event_to_edit.update({:finish_time => event_end})
  end
  system 'clear'
  puts "#{event_to_edit.description} has been updated."
end

def delete_event(this_user)
  system "clear"
  list_event(this_user)
  puts "Choose the event you would like to delete"
  user_input = gets.chomp.downcase
  event_to_delete = Event.find_by(:description => user_input)
  event_to_delete.destroy
  puts "#{user_input} has been deleted from your calendar."

  puts "\nWould you like to delete another event? Y/N"
  if gets.chomp.upcase == 'Y'
    delete_event(this_user)
  elsif gets.chomp.upcase == 'N'
    existing_user
  else
    puts "Please enter a valid input"
  end
end



################################################################
def list_user
  User.all.each do | user|
    puts "#{user.id}) #{user.name}"
  end
end

def list_event(this_user)
  this_user.events.each do |event|
    puts "Event: #{event.description} \t at #{event.location} is due by #{event.finish_time}"
  end
end

def sort_events_by_start(this_user)
  system 'clear'
  sorted = this_user.events.sort_by &:start_time
  sorted.each do |event|
    if event.start_time > Time.now
      puts "#{event.description} starts at: #{event.start_time}"
    else
      puts "#{event.description} has already occurred."
    end
  end
end

welcome










