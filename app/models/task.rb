# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  code        :string
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :paticipating_users, class_name: 'Participant'
  has_many :participants, through: :paticipating_users, source: :user

  validates :paticipating_users, presence: true

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :due_date_validity

  def due_date_validity
    # validar que el campo exista
    return if due_date.blank?
    #validar que la fecha no este en el pasado
    return if due_date > Date.today
    # si las condiciones anteriores no se cumplen entonces
    errors.add :due_date, I18n.t('task.errors.invalid.due_date')
  end
end
