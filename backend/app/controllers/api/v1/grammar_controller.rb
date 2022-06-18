module Api
  module V1
    class GrammarController < ApplicationController
      before_action :authenticate_request
      before_action :set_grammar, only: [:show, :update]

      def index
        page = params[:page].nil? ? 1 : params[:page]
        limit = params[:limit].nil? ? 100 : params[:limit]

        @grammars = Grammar.all.page(page).per(limit)
        render json: GrammarSerializer.new(@grammars).serializable_hash
      end

      def show
        render json: GrammarSerializer.new(@grammar).serializable_hash
      end

      def update
        if @grammar.update(grammar_params)
          render json: @grammar
        else
          render json: @grammar.errors, status: :unprocessable_entity
        end
      end

      # { query: "까", page: 1 }
      def search
        @grammars = Grammar.search(params[:query], params[:page])

        render json: @grammars
      end

      private

      def set_grammar
        @grammar = Grammar.find(params[:id])
      end

      def grammar_params
        params.require(:grammar).permit(:name, :category_en, :description_en, :additional_info)
      end
    end
  end
end
