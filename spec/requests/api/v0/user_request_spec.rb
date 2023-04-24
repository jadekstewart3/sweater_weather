require "rails_helper"

RSpec.describe "Users API" do 
  describe "Create User" do
    describe "When Successful" do 
      it "can create a new user" do 
        user_params = ({ email: "fiona_hearts_cake@gmail.com",
                        password: "password",
                        password_confirmation: "password"})

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)
        created_user = User.last

        expect(response).to be_successful
        expect(response).to have_http_status(201)
        expect(created_user.email).to eq("fiona_hearts_cake@gmail.com")
      end

      it "saves email as downcased" do 
        user_params = ({ email: "FIONA_HEARTS_CAKE@GMAIL.COM",
                      password: "password",
                      password_confirmation: "password"})

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)
        created_user = User.last

        expect(response).to be_successful
        expect(response).to have_http_status(201)
        expect(created_user.email).to eq("fiona_hearts_cake@gmail.com")
      end
    end

    describe "When unsuccessful" do
      it "does not allow a user to be created with an invalid email" do 
        user_params = ({
          email: "abc",
          password: "password123",
          password_confirmation: "password123"
        })

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.keys).to match([:message, :errors])
        expect(response_body[:message]).to be_a(String)
        expect(response_body[:errors]).to be_an(Array)

        response_body[:errors].each do |error|
          expect(error).to be_a Hash
          expect(error.keys).to match([:status, :title])

          expect(error[:status]).to be_a String
          expect(error[:status]).to eq("400")

          expect(error[:title]).to be_a String
          expect(error[:title]).to eq("Email is invalid")
        end
      end

      it "does not create a user if the password and password confirmation do not match" do 
        user_params = ({
          email: "fiona_hearts_cake@gmail.com",
          password: "password123",
          password_confirmation: "password12"
        })

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.keys).to match([:message, :errors])
        expect(response_body[:message]).to be_a(String)
        expect(response_body[:errors]).to be_an(Array)

        response_body[:errors].each do |error|
          expect(error).to be_a Hash
          expect(error.keys).to match([:status, :title])

          expect(error[:status]).to be_a String
          expect(error[:status]).to eq("400")

          expect(error[:title]).to be_a String
          expect(error[:title]).to eq("Password confirmation doesn't match Password")
        end
      end

      it "does not create a user if the email has already been taken" do 
        user = User.create!(email: "funky_pop_rocks@gmail.com", password: "password", password_confirmation: "password")

        user_params = ({
          email: user.email,
          password: "password123",
          password_confirmation: "password123"
        })

        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/users", headers: headers, params: JSON.generate(user_params)

        expect(response).to have_http_status(404)
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body.keys).to match([:message, :errors])
        expect(response_body[:message]).to be_a(String)
        expect(response_body[:errors]).to be_an(Array)

        response_body[:errors].each do |error|
          expect(error).to be_a Hash
          expect(error.keys).to match([:status, :title])

          expect(error[:status]).to be_a String
          expect(error[:status]).to eq("400")

          expect(error[:title]).to be_a String
          expect(error[:title]).to eq("Email has already been taken")
        end
      end
    end
  end

  describe "User login" do 
    describe "When successful" do 
      before :each do 
        @user = User.create!(email: "octocat33@gmail.com", password: "password", password_confirmation: "password")
      end

      it "authenticates a user when given valid credentials" do 
        user_params = ({
                          email: @user.email,
                          password: @user.password
                       })
        headers = { "CONTENT_TYPE" => "application/json"}

        post "/api/v0/sessions", headers: headers, params: JSON.generate(user_params)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful

        expect(response_body).to have_key(:data)
        expect(response_body[:data]).to be_a(Hash)

        expect(response_body[:data]).to have_key(:id)
        expect(response_body[:data][:id]).to be_a(String)

        expect(response_body[:data]).to have_key(:type)
        expect(response_body[:data][:type]).to be_a(String)

        expect(response_body[:data]).to have_key(:attributes)
        expect(response_body[:data][:attributes]).to be_a(Hash)

        expect(response_body[:data][:attributes]).to have_key(:email)
        expect(response_body[:data][:attributes][:email]).to be_a(String)

        expect(response_body[:data][:attributes]).to have_key(:api_key)
        expect(response_body[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    describe "When unsuccessful" do 
      before :each do 
        @user = User.create!(email: "octocat33@gmail.com", password: "password", password_confirmation: "password")
      end

      it "does not authenticate with no credentials" do 
        user_params = ({
                          email: "",
                          password: ""
                        })
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/sessions", headers: headers, params: JSON.generate( user: user_params )
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response_body).to have_key(:message)
        expect(response_body).to have_key(:errors)

        expect(response_body[:message]).to eq("your query could not be completed")

        response_body[:errors].each do |error|
          expect(error[:status]).to eq(401)
          expect(error[:title]).to eq("Invalid credentials")
        end
      end

      it "does not authenticate a user with the incorrect email" do 
        user_params = ({
                          email: "this_is_not_right@gmail.com",
                          password: @user.password
                        })
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/sessions", headers: headers, params: JSON.generate( user: user_params )
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response_body).to have_key(:message)
        expect(response_body).to have_key(:errors)

        expect(response_body[:message]).to eq("your query could not be completed")

        response_body[:errors].each do |error|
          expect(error[:status]).to eq(401)
          expect(error[:title]).to eq("Invalid credentials")
        end
      end

      it "does not authenticate a user with the incorrect password" do 
        user_params = ({
                          email: @user.email,
                          password: "bad_pass"
                        })
        headers = { "CONTENT_TYPE" => "application/json" }

        post "/api/v0/sessions", headers: headers, params: JSON.generate( user: user_params )
        
        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response_body).to have_key(:message)
        expect(response_body).to have_key(:errors)

        expect(response_body[:message]).to eq("your query could not be completed")

        response_body[:errors].each do |error|
          expect(error[:status]).to eq(401)
          expect(error[:title]).to eq("Invalid credentials")
        end
      end
    end
  end
end