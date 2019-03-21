<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
            <body>
                    <h2>  Question_3-c-Answer</h2>
                    <table  border = "1">
                            <tr bgcolor  =  "#9acd32">
                                <th>  Total  number of sunscreen in Indonesia</th>
                            </tr>
                                      <tr>    
                                              <td> <xsl:value-of select= "sum(warehouses/ warehouse/address[country='Indonesia']
                                                                                                          /.././items/item[item_name='Sunscreen']/qty)"/> </td>
                                       </tr>      
                    </table>
            </body>
    </html>
  </xsl:template>
</xsl:stylesheet>