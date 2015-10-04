class Audit < Audited::Adapters::ActiveRecord::Audit

  # ransacker :admin_id do |parent|
  #   Arel::Nodes::InfixOperation.new('AND',
  #     Arel::Nodes::InfixOperation.new('=',
  #         parent.table[:user_type], 'Admin'
  #     ),
  #     parent.table[:user_id]
  #   )
  # end
  #
  # ransacker :user_id do |parent|
  #   Arel::Nodes::InfixOperation.new('AND',
  #     Arel::Nodes::InfixOperation.new('LIKE',
  #         parent.table[:user_type], 'User'
  #     ),
  #     parent.table[:user_id]
  #   )
  # end
  #
  # ransacker :company_id do |parent|
  #   Arel::Nodes::InfixOperation.new('AND',
  #     Arel::Nodes::InfixOperation.new('=',
  #       parent.table[:user_type], 'Company'
  #     ),
  #     parent.table[:user_id]
  #   )
  # end

end
