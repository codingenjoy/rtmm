<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8"
		standalone="yes"></xsl:output>

	<xsl:template match="/">
		<div>
			<ol class="MainMenu">
				<xsl:apply-templates select="menu/item"></xsl:apply-templates>
			</ol>
		</div>
	</xsl:template>

	<xsl:template match="menu/item">

		<li>
			<xsl:attribute name="auchanId">
			<xsl:value-of select="@id"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="onclick">
		        <xsl:value-of select="concat('onMenuItemClick(',@id, ')')"></xsl:value-of>
		        </xsl:attribute>
			<a>
				<xsl:attribute name="title">
					<xsl:value-of select="@title"></xsl:value-of>
					</xsl:attribute>
				<xsl:choose>
					<xsl:when test="@isselected='true'">
						<xsl:attribute name="class">
		        <xsl:value-of select="concat(@class,' ',@class,'_on')"></xsl:value-of>
		        </xsl:attribute>

					</xsl:when>

					<xsl:otherwise>
						<xsl:attribute name="class">
		        <xsl:value-of select="@class"></xsl:value-of>
		        </xsl:attribute>
					</xsl:otherwise>

				</xsl:choose>
				<span>
					<xsl:value-of select="@title"></xsl:value-of>
				</span>

			</a>
		</li>

	</xsl:template>
</xsl:stylesheet>