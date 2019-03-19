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
					xmlelement
					(	
						name "item",
						xmlelement(name "id",item.i_id),
						xmlelement(name "im_id",item.i_im_id),
						xmlelement(name "name",item.i_name),
						xmlelement(name "price",item.i_price),
						xmlelement(name "qty",stock.s_qty)
					)
				)
			)
		) 
	), version '1.0" encoding = "utf-8'
) from warehouse inner join stock on warehouse.w_id = stock.w_id
                  inner join item on stock.i_id = item.i_id
) to '/home/cs4221/Desktop/test.xml'
