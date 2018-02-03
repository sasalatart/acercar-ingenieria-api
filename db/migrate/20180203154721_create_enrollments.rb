class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.references :user, foreign_key: true
      t.belongs_to :enrollable, polymorphic: true

      t.timestamps
    end
    add_index :enrollments, %i[enrollable_id enrollable_type]
  end
end
