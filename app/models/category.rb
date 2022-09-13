# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
    has_many :tasks

    # validar informacion en blanco
    validates :name, :description, presence: true
    # Validar que el campo nombre sea unico
    validates :name, uniqueness: { case_sensitive: false }
end
