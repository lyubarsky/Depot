require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  describe 'when name is not present' do
    before { user.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is not unique' do
    before do
      user_with_same_name = user.dup
      user_with_same_name.save
    end
    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before { user.password = user.password_confirmation = '' }
    it { should_not be_valid }
  end

  describe 'when password does\'not match confirmation' do
    before { user.password_confirmation = 'mismatch'}
    it { should_not be_valid }
  end

  describe 'when password is too long (>72 symbols)' do
    before do
      user.password = user.password_confirmation = 'a'*73
    end
    it { should_not be_valid }
  end

  describe 'return value of authenticate method' do
    let(:found_user) { User.find_by(name: user.name) }
    before { user.save }

    describe 'user with valid password' do
      it { should eq found_user.authenticate(user.password) }
    end

    describe 'user with invalid password' do
      let(:user_with_invalid_password) { found_user.authenticate('invalid') }
      it { should_not eq user_with_invalid_password }
      specify { expect(user_with_invalid_password).to be_false }
    end
  end

  describe 'the last admin cannot be deleted' do
    before do
      begin
        user.save
        User.destroy_all
        rescue RuntimeError
      end
    end
    specify { expect(User.count).to eq 1 }
  end
end
