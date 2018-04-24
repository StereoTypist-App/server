class Text < ApplicationRecord
    validates :text, presence: true, format: { with: %r{\A[ A-Za-z0-9,\/\.;\?"'\-&\$!\(\))\n]+\z} }, length: {minimum: 600}
    validates :user, presence: true
    validates :title, presence: true, length: {minimum: 6, maximum: 40}

    belongs_to :user
end
