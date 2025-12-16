module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user, except: [ :index, :show ]
      def index
        render json: Book.all
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: book, status: :created
        else
          render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :price)
      end

      def authenticate_user
        header = request.headers["Authorization"]
        token = header.split(" ").last if header
        begin
          decoded = JWT.decode(token, "your_secret_key", "HS256")
          @current_user = User.find(decoded[0]["user_id"])
        rescue JWT::DecodeError
          render json: { error: "Unauthorized" }, status: :unauthorized

        end
      end
    end
  end
end
