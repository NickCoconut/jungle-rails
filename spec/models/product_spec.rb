require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do

    category = Category.new(name: "pets")
    product = Product.new(id: 200, name: "costume", price: 30, quantity: 10, category: category)

    it "saves correctly when all fields are set" do
      product.saves
      expect(Product.find_by(name: "costume")).not_to be_nil
    end

    it "does not save once name is not set and validated" do
      product.name = be_nil
      product.save
      expect(Product.find_by(id: 200)).to be_nil
    end

    it "does not save once price is not set and validated" do
      product.price = nil 
      product.save
      expect(Product.find_by(name: "costume")).to be_nil
    end

    it "does not save once quantity is not set and validated" do
      product.quantity = nil
      product.save
      expect(Product.find_by(name: "costume")).to be_nil
    end

    it "does not save once category is not set and validated" do 
      product.category = nil
      product.save
      expect(Product.find_by(name: "costome")).to be_nil
    end
  end

end
