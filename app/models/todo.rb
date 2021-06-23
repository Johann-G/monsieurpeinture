class Todo < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, presence: true

  aasm column: 'status' do
    state :not_done, initial: true
    state :done

    event :do_task do
      transitions from: :not_done, to: :done
    end

    event :undo_task do
      transitions from: :done, to: :not_done
    end
  end
end
