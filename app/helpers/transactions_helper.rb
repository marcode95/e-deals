module TransactionsHelper
  def total_transaction_sum
    sum = 0
    @owntransactions.each do |transaction|
      sum += transaction.amount
    end
    sum
  end

  def total_external_transaction_sum
    sum = 0
    @owntransactions.each do |transaction|
      sum += transaction.amount if transaction.groups.empty?
    end
    sum
  end

  def eurofy(amount)
    amount = if amount < 10
               amount.to_s.insert(0, '0,0').insert(-1, '€')
             elsif amount < 100
               amount.to_s.insert(0, '0,').insert(-1, '€')
             else
               amount.to_s.insert(-3, ',').insert(-1, '€')
             end

    amount.gsub!(',00', '') if amount[-3..-2] == '00'
    amount
  end

  def no_groups?(trans)
    render partial: 'single-transactions', locals: { transaction: trans } if trans.groups.empty?
  end

  def trans_img_attached?(trans)
    if trans.groups.first&.image&.attached?
      render partial: 'single-image', locals: { transaction: trans }
    else
      render partial: 'groups/no-image'
    end
  end
end
