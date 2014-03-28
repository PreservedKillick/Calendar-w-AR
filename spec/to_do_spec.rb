require 'spec_helper'

describe ToDo do
  it {should belong_to :user}
  it {should have_many :notes}
end
