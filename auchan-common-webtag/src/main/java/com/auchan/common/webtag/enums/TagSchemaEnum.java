package com.auchan.common.webtag.enums;

public enum TagSchemaEnum {
	
	/**
	 * Enum the schema of tag.
	 * you can invoke it by 'TagSchemaEnum.schemaName(like xx.xsl).getschemaURI()'
	 * 
	 */

	MENU_TAG_XSL("/schema/topmenu.xsl"),
	SUBMENU_TAG_XSL("/schema/submenu.xsl"),
	;
	
	/**
	 * the URI of schema.
	 */
	
	private String schemaURI;

	/**
	 * Invoke the inner enum schema by the construct method.
	 * 
	 * @param schemaURI
	 */
	
	private TagSchemaEnum(String schemaURI) {

		this.schemaURI = schemaURI;
	}

     
	/**
	 *get and set the particular property of this class
	 */
	public String getSchemaURI() {
		return schemaURI;
	}
	public void setSchemaURI(String schemaURI) {
		this.schemaURI = schemaURI;
	}
	
	

}
