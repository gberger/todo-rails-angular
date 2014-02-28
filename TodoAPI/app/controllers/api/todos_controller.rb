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

      render json: @todo
    end

    # POST /api/todos
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

    # PATCH/PUT /api/todos/1
    def update
      @todo = Todo.owned_by(current_user).find(params[:id])

      if @todo.update(todo_params)
        render json: @todo
      else
        render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # DELETE /api/todos/1
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