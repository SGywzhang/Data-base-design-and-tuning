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
					(select xmlagg(xmlelement
					(	
						name "item",
						xmlelement(name "id",i.i_id),
						xmlelement(name "im_id",i.i_im_id),
						xmlelement(name "name",i.i_name),
						xmlelement(name "price",i.i_price),
						xmlelement(name "qty",s.s_qty)
					)) from warehouse w inner join stock s on warehouse.w_id = s.w_id
                 		 inner join item i on s.i_id = i.i_id where warehouse.w_id = s.w_id and s.i_id = i.i_id) 
				)
			)
		) 
	), version 1.0, standalone yes
) from warehouse
) to '/home/cs4221/Desktop/test.xml'
