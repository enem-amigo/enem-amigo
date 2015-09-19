class CreateUsers < ActiveRecord::Migration
      def change
            create_table :users do |t|
                  t.string :users_name
                  t.string :name
                  t.string :email
                  t.string  :level

                  t.timestamps null: false
            end
      end
end
