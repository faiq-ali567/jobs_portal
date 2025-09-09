require 'rails_helper'
require 'securerandom'

RSpec.describe User, type: :model do
  def build_user(attrs = {})
    defaults = {
      email: 'u@u.com',
      password: 'password',
      password_confirmation: 'password',
      jti: SecureRandom.uuid
    }
    described_class.new(defaults.merge(attrs))
  end

  context 'validations and basics' do
    it 'is valid with email, password and jti' do
      user = build_user
      expect(user).to be_valid
    end

    it 'is invalid without email' do
      user = build_user(email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end

    it 'requires a minimum password length' do
      user = build_user(password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it 'enforces email uniqueness in a case insensitive way' do
      described_class.create!(
        email: 'taken@example.com',
        password: 'password',
        password_confirmation: 'password',
        jti: SecureRandom.uuid
      )
      dup = build_user(email: 'TAKEN@example.com')
      expect(dup).not_to be_valid
      expect(dup.errors[:email]).to include(a_string_matching(/taken/i))
    end
  end

  context 'defaults and normalization' do
    it 'downcases email on save' do
      user = build_user(email: 'UPPER@Example.COM')
      user.save!
      expect(user.email).to eq 'upper@example.com'
    end

    it 'sets role default to 0 at the database level' do
      user = described_class.create!(
        email: 'roletest@example.com',
        password: 'password',
        password_confirmation: 'password',
        jti: SecureRandom.uuid
      )
      expect(user[:role]).to eq "candidate"
    end
  end

  context 'jwt jti' do
    it 'has a jti value after create' do
      user = build_user
      user.save!
      expect(user.jti).to be_present
    end
  end
end
