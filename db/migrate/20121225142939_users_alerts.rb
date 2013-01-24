class UsersAlerts < ActiveRecord::Migration
  def up
    create_table :alerts_users, :id => false do |t|
      t.integer :user_id
      t.integer :alert_id
    end
  end

  def down
  end
end
