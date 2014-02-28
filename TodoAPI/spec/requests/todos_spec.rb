require 'spec_helper'

describe "Todos" do
  context "without API key" do
    describe "GET /api/todos" do
      it "denies access" do
        get api_todos_path
        expect(response.status).to eq(401)
      end
    end

    describe "POST /api/todos" do
      it "denies access" do
        post api_todos_path
        expect(response.status).to eq(401)
      end
    end

    describe "GET /api/todos/:id" do
      it "denies access" do
        get api_todo_path(1)
        expect(response.status).to eq(401)
      end
    end

    describe "PATCH/PUT /api/todos/:id" do
      it "denies access" do
        patch api_todo_path(1)
        expect(response.status).to eq(401)
      end
    end

    describe "DELETE /api/todos/:id" do
      it "denies access" do
        delete api_todo_path(1)
        expect(response.status).to eq(401)
      end
    end
  end

  context "with incorrect API key" do
    before(:each) do
      @user1 = create(:user)
      @user2 = create(:user)
      @todo = create(:todo, user: @user1)
      @headers = {'ApiKey' => @user2.api_key}
    end

    describe "GET /api/todos/:id" do
      it "deny access" do
        get api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(401)
      end
    end

    describe "PATCH/PUT /api/todos/:id" do
      it "deny access" do
        patch api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(401)
      end
    end

    describe "DELETE /api/todos/:id" do
      it "deny access" do
        delete api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(401)
      end
    end
  end

  context "with correct API key" do
    before(:each) do
      @user = create(:user)
      @todo = create(:todo, user: @user)
      @headers = {'ApiKey' => @user.api_key}
    end

    describe "GET /api/todos" do
      it "allows access" do
        get api_todos_path, nil, @headers
        expect(response.status).to eq(200)
      end

      it "retrieves the user's todos" do
        other_user = create(:user)
        other_todo = create(:todo, user: other_user)
        get api_todos_path, nil, @headers
        expect(json.length).to be(1)
        expect(json[0]['text']).to eq(@todo.text)
      end
    end

    describe "POST /api/todos" do
      it "allows access" do
        post api_todos_path, attributes_for(:todo), @headers
        expect(response.status).to eq(201)
      end

      it "creates a new todo" do
        expect {post api_todos_path, attributes_for(:todo), @headers}
        .to change{Todo.count}.by(1)
      end

      it "creates a new todo that belongs to the user" do
        post api_todos_path, attributes_for(:todo), @headers
        expect(assigns(:todo).user).to eq(@user)
      end
    end

    describe "GET /api/todos/:id" do
      it "allows access" do
        get api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(200)
      end

      it "retrieves the given todo" do
        get api_todo_path(@todo.id), nil, @headers
        expect(json['text']).to eq(@todo.text)
      end
    end

    describe "PATCH/PUT /api/todos/:id" do
      it "allows access" do
        patch api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(200)
      end

      it "modifies the given todo" do
        patch api_todo_path(@todo.id), {completed: true}, @headers
        expect(assigns(:todo).completed).to be_true
      end
    end

    describe "DELETE /api/todos/:id" do
      it "allows access" do
        delete api_todo_path(@todo.id), nil, @headers
        expect(response.status).to eq(204)
      end

      it "creates a new todo" do
        expect {delete api_todo_path(@todo.id), nil, @headers}
        .to change{Todo.count}.by(-1)
      end
    end
  end

end
