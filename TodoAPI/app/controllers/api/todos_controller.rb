module Api
  class TodosController < ApiController
    # GET /api/todo
    # GET /api/todo.json
    def index
      @todos = Todo.owned_by(current_user).order(order_param)

      render json: @todos
    end

    # GET /api/todo/1
    # GET /api/todo/1.json
    def show
      @todo = Todo.find(params[:id])

      render json: @todo
    end

    # POST /api/todo
    # POST /api/todo.json
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

    # PATCH/PUT /api/todo/1
    # PATCH/PUT /api/todo/1.json
    def update
      @todo = Todo.owned_by(current_user).find(params[:id])

      if @todo.update(todo_params)
        render json: @todo
      else
        render json: {messages: @todo.errors.angular_growl_messages}, status: :bad_request
      end
    end

    # DELETE /api/todo/1
    # DELETE /api/todo/1.json
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