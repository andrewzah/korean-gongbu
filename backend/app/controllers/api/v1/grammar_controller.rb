module Api
  module V1
    class GrammarController < ApplicationController
      # { query: "까", page: 1 }

      def search
        @grammars = Grammar.search(params[:query], params[:page])
        pp @grammars
      end
    end
  end
end
