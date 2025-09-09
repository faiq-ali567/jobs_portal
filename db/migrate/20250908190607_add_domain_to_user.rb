class AddDomainToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subdomain, :string, index: { unique: true }
  end
end
