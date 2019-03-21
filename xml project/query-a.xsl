<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
            <body>
                    <h2>  Question_3-a-Answer</h2>
                    <table  border = "1">
                            <tr bgcolor  =  "#9acd32">
                                <th>  Warehouse Name </th>
                                <th>  Item Name </th>
                                <th>  Item Qty </th>
                            </tr>
                            <xsl:for-each select=" warehouses/ warehouse/address[city='Singapore']/.././items/item[qty>975]">
                                      <tr>    
                                                         <td> <xsl:value-of select= "./../../name"/> </td>
                                                          <td><xsl:value-of select= "item_name"/></td>   
                                                          <td><xsl:value-of select= "qty"/></td>
                                       </tr>      
                            </xsl:for-each>
                    </table>
            </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
