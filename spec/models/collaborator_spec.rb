 require 'rails_helper'
 
 RSpec.describe Collaborator, type: :model do
   it { is_expected.to have_many :users }
   it { is_expected.to have_many(:wikis).through(:users) }
 end