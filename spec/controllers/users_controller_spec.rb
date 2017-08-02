require 'rails_helper'

describe UsersController do

  describe "get users/new " do
    it "responds 200" do
      get :new
      expect(response.status).to eq(200)
    end

    it "sends to account creation page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post developers" do
    context "valid params" do
      before(:each) do
        post :create, params: { user: {first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        user_type: 'dev',
        email: Faker::Internet.safe_email,
        password: Faker::Internet.password,
        website: Faker::Internet.url,
        description: Faker::StarWars.quote,
        phone: '356-456-5555'
        }
      }
      end
      it "responds 302" do
        expect(response).to have_http_status(302)
      end

      it "creates a new developer in the database" do
        expect{post :create, params: { user: {first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
         }
        }.to change{User.where(user_type:'dev').count}.by(1)
      end

      it "assigns the newly created developer as @developer" do
        expect(assigns[:user]).to eq User.last
      end

      it "redirects to root" do
        expect(response).to redirect_to root_path
      end
    end
    context "invalid params" do
      before(:each) do
        post :create, params: { user: {first_name: '',
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
        }
      end

      it "responds with status 422" do
        expect(response).to have_http_status(422)
      end

      it "does not create a new developer in database" do
        expect{post :create, params: { user: {first_name: '',
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
         }
       }.not_to change{User.where(user_type:'dev').count}
      end

      it "assigns the unsaved developer as @user" do
        expect(assigns[:user]).to be_a_new(User)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "post organization" do
    context "valid params" do
      before(:each) do
        post :create, params: { user: {org_name: Faker::Company.name,
        street_address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zip: '98101',
        user_type: 'org',
        email: Faker::Internet.safe_email,
        password: Faker::Internet.password,
        website: Faker::Internet.url,
        description: Faker::StarWars.quote,
        phone: '356-456-5555'
        }
      }
      end

      it "responds 302" do
        expect(response).to have_http_status(302)
      end

      it "creates a new organization in the database" do
        expect{post :create, params: { user: {org_name: Faker::Company.name,
          street_address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: '98101',
          user_type: 'org',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
         }
       }.to change{User.where(user_type:'org').count}.by(1)
      end

      it "assigns the newly created organization as @organization" do
        expect(assigns[:user]).to eq User.last
      end

      it "redirects to root" do
        expect(response).to redirect_to root_path
      end
    end

    context "invalid params" do
      before(:each) do
        post :create, params: { user: {org_name: '',
          street_address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: '98101',
          user_type: 'org',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
        }
      end

      it "responds with status 422" do
        expect(response).to have_http_status(422)
      end

      it "does not create a new organization in database" do
        expect{post :create, params: { user: {org_name: '',
          street_address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: '98101',
          user_type: 'org',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
         }
       }.not_to change{User.where(user_type:'org').count}
      end

      it "assigns the unsaved organization as @user" do
        expect(assigns[:user]).to be_a_new(User)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  context 'get #show' do
    let(:user) { FactoryGirl.create(:organization, ein: '142007220')}
    let(:user_no_EIN) { FactoryGirl.create(:organization, ein: '')}
    let(:user_wrong_EIN) { FactoryGirl.create(:organization, ein: '000000000')}
    it 'responds 200' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status 200
    end

    it 'renders show page' do
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end

    it 'assigns an EIN name' do
      get :show, params: { id: user.id }
      expect(assigns[:ein_name]).to eq 'PRO PUBLICA INC'
    end

    it 'assigns "n/a" as EIN name when EIN empty' do
      get :show, params: { id: user_no_EIN.id }
      expect(assigns[:ein_name]).to eq 'N/A'
    end

    it 'assigns error message as EIN name when EIN not found' do
      get :show, params: { id: user_wrong_EIN.id }
      expect(assigns[:ein_name]).to eq "Could not find matching organization for EIN"
    end

  end

  describe 'GET#edit ' do
    context 'developer profile' do
      let(:user) { FactoryGirl.create(:developer) }
      before(:each) do
        login_user(user)
      end
      after(:each) do
        logout_user
      end

      it 'has response 200' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status 200
      end

      it 'renders an edit view' do
        get :edit, params: { id: user.id }
        expect(response).to render_template('edit')
      end
    end
    context 'organization profile' do
      let(:user) { FactoryGirl.create(:organization) }
      before(:each) do
        login_user(user)
      end
      after(:each) do
        logout_user
      end

      it 'has response 200' do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status 200
      end

      it 'renders an edit view' do
        get :edit, params: { id: user.id }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'PUT#update' do
    context 'Developer profile' do
      let!(:new_user) { FactoryGirl.create(:developer) }
      before(:each) do
        login_user(new_user)
      end
      after(:each) do
        logout_user
      end

      it 'updates a developer with valid parameters' do
        patch :update, params: { id: new_user.id, user: { first_name: 'Jose',
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          } }
        new_user.reload
        expect(new_user.first_name).to eq('Jose')
      end

      it 'does not update a developer with invalid parameters' do
        patch :update, params: { id: new_user.id, user: { first_name: nil,
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          } }
        new_user.reload
        expect(new_user.first_name).to render_template('edit')
      end
    end

    context 'organization profile' do
      let!(:new_org) { FactoryGirl.create(:organization) }
      before(:each) do
        login_user(new_org)
      end
      after(:each) do
        logout_user
      end

      it 'updates a organization with valid parameters' do
        patch :update, params: { id: new_org.id, user: { org_name: 'Awesome Co.',
          street_address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: '98101',
          user_type: 'org',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
        }
        new_org.reload
        expect(new_org.org_name).to eq('Awesome Co.')
      end

      it 'does not update a developer with invalid parameters' do
        patch :update, params: { id: new_org.id, user: { org_name: nil,
          street_address: Faker::Address.street_address,
          city: Faker::Address.city,
          state: Faker::Address.state_abbr,
          zip: '98101',
          user_type: 'org',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.url,
          description: Faker::StarWars.quote,
          phone: '356-456-5555'
          }
        }
        new_org.reload
        expect(new_org.org_name).to render_template(:edit)
      end
    end
  end

end
