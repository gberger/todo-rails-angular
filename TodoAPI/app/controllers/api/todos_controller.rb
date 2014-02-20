module Api
  class TodosController < ApiController
    # GET /todos
    # GET /todos.json
    def index
      @todos = Todo.owned_by(current_user).order(order_param)

      render json: @todos
    end

    # GET /todos/1
    # GET /todos/1.json
    def show
      @todo = Todo.find(params[:id])

      render json: @todo
    end

    # POST /todos
    # POST /todos.json
    def create
      puts params.inspect
      @todo = Todo.new(todo_params)
      @todo.user = current_user

      if @todo.save
        render json: @todo, status: :created
      else
        render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # PATCH/PUT /todos/1
    # PATCH/PUT /todos/1.json
    def update
      @todo = Todo.owned_by(current_user).find(params[:id])

      if @todo.update(todo_params)
        render json: @todo
      else
        render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # DELETE /todos/1
    # DELETE /todos/1.json
    def destroy
      @todo = Todo.owned_by(current_user).find(params[:id])
      @todo.destroy

      head :no_content
    end

    private

    def todo_params
      params.permit(:text, :priority, :completed, :due_date)
    end

    def order_param
      params[:order] or 'priority asc'
    end
  end
end