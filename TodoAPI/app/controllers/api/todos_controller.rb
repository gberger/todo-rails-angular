module Api
  class TodosController < ApiController
    # GET /api/todos
    def index
      @todos = Todo.owned_by(current_user).order(order_param)

      render json: @todos
    end

    # GET /api/todos/1
    def show
      @todo = Todo.find(params[:id])

      if @todo.user == current_user
        render json: @todo
      else
        head :unauthorized
      end
    end

    # POST /api/todos
    def create
      @todo = Todo.new(todo_params)
      @todo.user = current_user

      if @todo.save
        render json: @todo, status: :created
      else
        render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # PATCH/PUT /api/todos/1
    def update
      @todo = Todo.find(params[:id])

      if @todo.user == current_user
        if @todo.update(todo_params)
          render json: @todo
        else
          render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
        end
      else
        head :unauthorized
      end
    end

    # DELETE /api/todos/1
    def destroy
      @todo = Todo.find(params[:id])

      if @todo.user == current_user
        @todo.destroy
        head :no_content
      else
        head :unauthorized
      end
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