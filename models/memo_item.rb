class MemoItem < ActiveRecord::Base
  validates :body, presence: true
end
