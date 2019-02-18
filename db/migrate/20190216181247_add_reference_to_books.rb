class AddReferenceToBooks < ActiveRecord::Migration[5.2]
  def change
  	add_reference :books, :author, foreign_key: true
  	add_reference :books, :publisher, polymorphic: true
  end
end
