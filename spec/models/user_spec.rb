require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validatations" do
    user = User.create({first_name: "Nick", last_name: "Guan", email: "nick@gmail.com", password: "coco", password_confirmation: "coco"})
    it "saves when all fields are set" do
      user.save
      expect(User.find_by(last_name: "Guan")).not_to be_nil
    end

    it "should have password matching password_confirmation" do
      user.password = "coco"
      user.password_confirmation = "Coco"
      user.save
      expect(user.password).not_to eq(user.password)
    end

    it "should not allow user to enter same email" do
      user2 = user
      user2.email = "nick@gmail.com"
      user2.save
      expect(User.find_by(id: 2)).to be_nil
    end

    it "should not save when emai is not set and validated" do
      user2 = user
      user2.email = nil
      user2.save
      expect(User.find_by(id:2)).to be_nil
  end

  it "should not save when first_name is not set and validated" do
    user2 = user
    user.first_name = nil
    user2.save
    expect(User.find_by(id:2)).to be_nil
  end

  it 'should not save correctly once last_name is not set and validated' do
    user2 = user
    user2.last_name = nil
    user2.save
    expect(User.find_by(id: 2)).to be_nil
  end

  it 'must have a password of at least 3 characters' do
    user2 = user
    user2.password = "12"
    user2.password_confirmation = "12"
    user2.save
    expect(User.find_by(id: 2)).to be_nil
  end

end

  describe "authenticate_with_credentials" do
    user = User.create({first_name: "Nick", last_name: "Guan", email: "nick@gmail.com", password: "coco", password_confirmation: "coco"})
    
    it "should authenticate user when fields are entered correctly" do
      user2 = User.authenticate_with_credentials(user.email, user.password)
      expect(user2).not_to be_nil
    end

    it "should not authenticate when password is not correct" do
      user2 = User.authenticate_with_credentials(user.email, "hello")
      expect(user2).to be_nil
    end

    it "should not authenticate when user's email does not exist" do
      user2 = User.authenticate_with_credentials("coco@gmail.com", "hello")
      expect(user2).to be_nil
    end

    it "should authenticate user despite the casing" do 
      user2 = User.authenticate_with_credentials("NiCK@gmail.com", user.password)
      expect(user2).not_to be_nil
    end

    it "should authenticate the user despite spaces" do
      user2 = User.authenticate_with_credentials(" nick@gmail.com ", user.password)
      expect(user2).not_to be_nil
    end

  end
  
end
