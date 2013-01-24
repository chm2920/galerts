class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.integer :alert_id
      t.string :summary
      t.datetime :received_at
      t.text :body

      t.timestamps
    end
  end
end
