require 'rails_helper'

RSpec.describe Company, type: :model do
  let!(:company) { create(:company) }

  describe 'Associations' do
    it { is_expected.to have_many(:units).dependent(:destroy) }
    it { is_expected.to have_many(:users_companies_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:users_companies_relationships) }
    it { is_expected.to have_many(:tickets).through(:units) }
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(company).to be_valid
    end

    it 'is not valid with empty name field' do
      company.name = nil
      expect(company).to_not be_valid
      expect(company.errors[:name]).to include('can not be blank')
    end

    it 'is not valid with empty email field' do
      company.email = nil
      expect(company).to_not be_valid
      expect(company.errors[:email]).to include('can not be blank')
    end

    it 'is not valid with invalid email format' do
      company.email = 'example_domain'
      expect(company).to_not be_valid
    end

    it 'is not valid with incorrect phone number' do
      company.phone = '123'
      expect(company).to_not be_valid
      expect(company.errors[:phone])
        .to include('is too short (minimum is 6 characters)')

      company.phone = '123144632p'
      expect(company).to_not be_valid
      expect(company.errors[:phone])
        .to include('is invalid: must be from 6 to 20 digits long')
    end

    it 'is valid with blank or correct phone number' do
      company.phone = '+109912312'
      expect(company).to be_valid

      company.phone = nil
      expect(company).to be_valid
    end
  end
end
