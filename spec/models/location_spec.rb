require 'rails_helper'

RSpec.describe Location, type: :model do
  it {should validate_presence_of(:city)}
  it {should validate_presence_of(:state)}
  it {should validate_presence_of(:country)}
  it {should validate_presence_of(:latitude)}
  it {should validate_presence_of(:longitude)}
end
