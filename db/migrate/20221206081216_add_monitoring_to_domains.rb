class AddMonitoringToDomains < ActiveRecord::Migration[7.0]
  def change
    add_column :domains, :monitoring, :boolean, default: false
  end
end
