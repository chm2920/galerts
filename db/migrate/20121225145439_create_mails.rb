class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.integer :alert_id
      t.text :body
      t.datetime :received_at

      t.timestamps
    end
  end
end
