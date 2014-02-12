atom_feed do |feed|
	feed.title "who bought #{@pet.name}"
	latest_order = @pet.order.sort_by(&:updated_at).last
	feed.updated( latest_order && latest_order.updated_at)

	@pet.orders.each do |order|
		feed.entry(order) do |entry|
			entry.title "order #{order.id}"
			entry.summary :type => 'xhtml' do |xhtml|
				xhtml.p "Shipped to #{order.address}"
				xhtml.table do 
					xhtml.tr do
						xhtml.th 'Pet'
						xhtml.th 'Quantity'
						xhtml.th 'Total Price'
					end
					order.line_items.each do |item| 
						xhtml.tr do
							xhtml.td item.name
							xhtml.td item.quantity
							xhtml.td number_to_currency item.total_price
						end
					end
					xhtml.tr do 
						xhtml.th 'total', :colspan => 3
						xhtml.th number_to_currency order.line_items.map(&:total_price).sum
					end
				end
				xhtml.p "paid by #{order.pay_type}"
			end
			entry.author do |author|
				entry.name order.name
				entry.email order.email
			end
		end
	end
end

