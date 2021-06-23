class Todo < ApplicationRecord
  include AASM

  belongs_to :user

  validates :title, presence: true

  after_create :set_new_priority

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

  def set_new_priority
    self.priority = Todo.maximum(:priority) + 1
    self.save
  end
end
