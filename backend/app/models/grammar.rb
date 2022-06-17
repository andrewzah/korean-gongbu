class Grammar < ApplicationRecord
  def self.search(search, page = 1)
    wildcard_search = "%#{search}%"

    where("name LIKE :search", search: wildcard_search)
      .order(:name)
      .page(page)
  end
end
