class Result < ApplicationRecord
    validates :wpm, presence: true

    belongs_to :user
end
