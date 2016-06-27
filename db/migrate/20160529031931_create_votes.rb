class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :user,    :null => false
      t.belongs_to :recipe,  :null => false
      t.timestamps :null => false
    end
  end
end
