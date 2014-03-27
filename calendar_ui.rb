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
  until choice == 'X'
    puts "Are you a new user or an existing user?
    \tPress 'L' to log-in as an existing user
    \tPress 'A' to add a new user
    \tPress 'X' to exit program"
    choice = gets.chomp.upcase
    case choice
    when 'L'
      existing_user
    when 'A'
      new_user
    when 'X'
    else
      puts "Invalid choice, please choose 'A', 'L' or 'X'"
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
    user_menu(this_user)
  end
end

def user_menu(this_user)
  system 'clear'
  puts "What would you like to do? Press"
  puts "\t'A' to add an event"
  puts "\t'E' to edit an event"
  puts "\t'D' to delete an event"
  puts "\t'S' to display all events or events for a given timeframe"
  puts "\t'M' to return to the main menu"
  user_choice = gets.chomp.upcase
  case user_choice
  when 'A'
    add_event(this_user)
  when 'E'
      edit_event(this_user)
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

def add_event(this_user)
  system 'clear'
  puts "Would you like to add a general event or a specific event with due date?
  \tPress 'G' to add a general event
  \tPress 'S' to add a specific event"
  case gets.chomp.upcase
  when 'G'
    system 'clear'
    puts "Enter a whatever you would like to the event you would like to add"
    event_descr = gets.chomp
    new_to_do = ToDo.create({:description => event_descr, :user_id => this_user.id })

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
    system ('clear')

    puts "To do: #{new_to_do.description} has been added to your list."
    puts "\nPress 'A' to add another event, 'U' to return to the user menu or 'X' to exit the program"

    case  gets.chomp.upcase
    when 'A'
      add_event(this_user)
    when 'U'
      user_menu
    when 'L'
      list_event(this_user)
    when 'X'
      puts "Goodbye!"
      exit
    else
      puts "Please enter a valid input"
    end

  when 'S'
    system 'clear'
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
    system ('clear')

    puts "Event: #{new_event.description} has been added to your calendar."
    puts "\nPress 'A' to add another event, 'U' to return to the user menu or 'X' to exit the program"

    case  gets.chomp.upcase
    when 'A'
      add_event(this_user)
    when 'U'
      user_menu(this_user)
    when 'L'
      list_event(this_user)
    when 'X'
      puts "Good-bye!"
      exit
    else
      puts "Please enter a valid input"
    end
  end
end

def edit_event(this_user)
  system 'clear'
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
    puts "Event: #{event_to_edit.description} has been updated."
    user_menu(this_user)
end

def delete_event(this_user)
  system "clear"
  puts "Would you like to delete an event or a to do?
  \tPress 'E' to delete an event
  \tPress 'T' to delete a to do"
  case gets.chomp.upcase

  when 'E'
    this_user.events.each do |event|
      puts "Event: #{event.description} \t at #{event.location} has due date of #{event.finish_time}\n\n"
    end
    puts "Choose the event you would like to delete"
    user_input = gets.chomp.downcase
    event_to_delete = Event.find_by(:description => user_input)
    event_to_delete.destroy
    puts "Event: #{user_input} has been deleted from your calendar."

  when 'T'
    this_user.to_dos.each do |todo|
      puts "To do: #{todo.description} \n\n"
    end
    puts "Choose the to do you would like to delete"
    user_input = gets.chomp.downcase
    todo_to_delete = ToDo.find_by(:description => user_input)
    todo_to_delete.destroy
    puts "To do: #{user_input} has been deleted."
  else
    "Invalid input, please choose another"
  end
  puts "\nWould you like to delete another item? Y/N"
  if gets.chomp.upcase == 'Y'
    delete_event(this_user)
  elsif gets.chomp.upcase == 'N'
    user_menu(this_user)
  else
    puts "Please enter a valid input"
  end
end

def sort_events_by_start(this_user)
  system 'clear'
  puts "How would you like to view the events in your calendar?"
  puts "\t'A' to see all of your events, past events, or future events"
  puts "\t'S' to see them all, sorted by start time"
  puts "\t'D' to see all the events for the next day"
  puts "\t'W' to see all the events for the next week"
  puts "\t'M' to see all the events for the next month"
  puts "\t'Y' to see all the events for the next year"

  case gets.chomp.upcase
  when 'A'
    list_event(this_user)
    user_menu(this_user)
  when 'S'
    sorted = this_user.events.sort_by &:start_time
    sorted.each do |event|
      if event.start_time > Time.now
        puts "Event: #{event.description} starts at: #{event.start_time}"
      else
        puts "Event: #{event.description} has already occurred."
      end
    end
    gets.chomp
    user_menu(this_user)
  when 'D'
    sorted = this_user.events.sort_by &:start_time
    sorted.each do |event|
      if event.start_time > Time.now && event.start_time < Time.now+(24*60*60)
         puts "Event: #{event.description} starts at: #{event.start_time}"
      end
    end
    gets.chomp
    user_menu(this_user)
  when 'W'
    sorted = this_user.events.sort_by &:start_time
    sorted.each do |event|
      if event.start_time > Time.now && event.start_time < Time.now+(7*24*60*60)
         puts "Event: #{event.description} starts at: #{event.start_time}"
      end
    end
    gets.chomp
    user_menu(this_user)
  when 'M'
    forward = Date.strptime(Time.now.strftime("%Y-%d-%m"), '%Y-%d-%m')>>1
    sorted = this_user.events.sort_by &:start_time
    sorted.each do |event|
      if event.start_time > Time.now && event.start_time < forward
         puts "Event: #{event.description} starts at: #{event.start_time}"
      end
    end
    gets.chomp
    user_menu(this_user)
  when 'Y'
    sorted = this_user.events.sort_by &:start_time
    sorted.each do |event|
      if event.start_time > Time.now && event.start_time < Time.now+(52*7*24*60*60)
         puts "Event: #{event.description} starts at: #{event.start_time}"
      end
    end
    gets.chomp
    user_menu(this_user)
  else
    puts "Sorry, that was not a valid input"
  end
end

def list_event(this_user)
  puts "Would you like to see all events, future events or past due events?
  \tPress 'A' to view all events
  \tPress 'F' to see all future events
  \tPress 'P' to see past due events"
  case gets.chomp.upcase
  when 'A'
    puts "\n\n"
    this_user.events.each do |event|
      puts "Event: #{event.description} \t at #{event.location} has due date of #{event.finish_time}\n\n"
    end
    puts "Press any key to return to the user menu"
    gets.chomp
  when 'F'
    puts "\n\n"
    this_user.events.each do |event|
      if event.start_time > Time.now
        puts "Event: #{event.description} \t at #{event.location} is due by #{event.finish_time}\n\n"
      end
    end
    puts "Press any key to return to the user menu"
    gets.chomp
  when 'P'
    puts "\n\n"
    this_user.events.each do |event|
      if event.start_time < Time.now
      puts "Event: #{event.description} \t at #{event.location} was due at #{event.finish_time}\n\n"
      end
    end
    puts "Press any key to return to the user menu"
    gets.chomp
  else
    puts 'Invalid input please try again'
  end
end


def list_user
  system 'clear'
  puts "Here is a list of the current users:\n"
  User.all.each do | user|
    puts "#{user.id}) #{user.name}"
  end
end

welcome










