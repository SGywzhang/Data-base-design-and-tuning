copy(
	select xmlroot
	(
		xmlelement
		(
			name "warehouses",
			xmlagg
			(
				xmlelement
				(
					name "warehouse",
					xmlelement(name "id",warehouse.w_id),
					xmlelement(name "name",warehouse.w_name),
					xmlelement
					(
						name "address",
						xmlelement(name "street",warehouse.w_street),
						xmlelement(name "city",warehouse.w_city),
						xmlelement(name "country",warehouse.w_country)
					),
					xmlelement
					(
						name "items",	
						(
							select xmlagg
							(
								xmlelement
								(	
									name "item",
									xmlelement(name "id",item.i_id),
									xmlelement(name "im_id",item.i_im_id),
									xmlelement(name "name",item.i_name),
									xmlelement(name "price",item.i_price),
									xmlelement(name "qty",stock.s_qty)
								)
								order by item.i_id
							)  
							from stock , item where stock.w_id = warehouse.w_id and stock.i_id = item.i_id
						)
					)
				)
			order by warehouse.W_id) 
		), version '1.0" encoding = "utf-8' 
	) from warehouse
) to '/home/cs4221/Desktop/q1.xml'
