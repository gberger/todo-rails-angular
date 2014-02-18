module Api
  module V1
    class TodosController < ApplicationController
      # GET /todos
      # GET /todos.json
      def index
        @todos = Todo.all

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

        if @todo.save
          render json: @todo, status: :created, location: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /todos/1
      # PATCH/PUT /todos/1.json
      def update
        @todo = Todo.find(params[:id])

        if @todo.update(todo_params)
          render json: @todo
        else
          render json: @todo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /todos/1
      # DELETE /todos/1.json
      def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy

        head :no_content
      end

      def todo_params
        params.require(:todo).permit(:text, :priority, :completed, :due_date)
      end
    end
  end
end