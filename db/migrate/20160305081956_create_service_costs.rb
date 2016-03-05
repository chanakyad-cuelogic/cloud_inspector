class CreateServiceCosts < ActiveRecord::Migration
  def change
    create_table :service_costs do |t|
      t.string :region
      t.json :ec2_costs
      t.json :ebs_costs
      t.json :eip_costs
      t.json :elb_costs
      t.json :rds_costs

      t.timestamps null: false
    end
  end
end
