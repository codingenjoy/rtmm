<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8"
		standalone="yes"></xsl:output>
	<xsl:template match="/">
		<div class="SideBar Bar_off 1-id" onclick="DispOrHid('1-id')" style="display:none;">
			<div class="SideBarText">
				<xsl:value-of select="menu/item/@title"></xsl:value-of>
			</div>
		</div>
		<div class="SubMenu">
			<div class="SubTool">
				<div class="Expend">
					<div class="Expend1"></div>
					<div class="Expend2"></div>
				</div>
				<div class="HiddenSub A-id" onclick="DispOrHid('A-id')"></div>
			</div>
			<ol class="SubList">
				<xsl:apply-templates select="menu/item" mode="m"></xsl:apply-templates>
			</ol>
		</div>
	</xsl:template>


	<xsl:template match="*|/" mode="m">


		<li>
			<a>

				<xsl:attribute name="id">
	<xsl:value-of select="@id"></xsl:value-of>
	</xsl:attribute>
				<xsl:attribute name="auchanId">
	<xsl:value-of select="@id"></xsl:value-of>
	</xsl:attribute>

				<xsl:choose>
					<xsl:when test="@isselected='true'">
						<xsl:attribute name="class">Sub Sub_on</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">Sub</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="not(item)">
					<xsl:attribute name="auchanurl">
	      <xsl:value-of select="@url"></xsl:value-of>      
	            </xsl:attribute>
	            </xsl:if>
                    <xsl:choose>
					<xsl:when test="not(item)">
					<span></span>
					</xsl:when>
					<xsl:otherwise>
					<span class="L1_Yes"></span>
					</xsl:otherwise>
				    </xsl:choose>
				    
				 <span class="SubText">
					<xsl:if test="not(item)">
						<xsl:attribute name="onclick">
	<xsl:value-of select="concat('onSubMenuItemClick(',@id, ')')"></xsl:value-of>
	</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="@title"></xsl:value-of>
				</span>

				<xsl:if test="not(item)">
					<span>
				<xsl:choose>
					<xsl:when test="@iscollected='true'">
						<xsl:attribute name="class">Fav Fav_On</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="class">Fav</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
					</span>

				</xsl:if>
				

			</a>
			<xsl:if test="item">
				<ol>
					<xsl:apply-templates mode="m"/>
				</ol>
			</xsl:if>
		</li>

	</xsl:template>
</xsl:stylesheet>