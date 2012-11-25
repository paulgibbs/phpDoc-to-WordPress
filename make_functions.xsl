<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wp="http://wordpress.org/export/1.2/">
	<xsl:output indent="yes" cdata-section-elements="category"/>
	<xsl:output indent="yes" cdata-section-elements="wp:meta_value"/>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="/project">
		<rss version="2.0" xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:wp="http://wordpress.org/export/1.2/">
			<!-- WP Importer meta -->
			<channel>
				<title>Example Site</title>
				<link>http://example.com</link>
				<description>Just another WordPress site</description>
				<language>en-US</language>
				<wp:wxr_version>1.2</wp:wxr_version>
				<wp:base_site_url>http://example.com</wp:base_site_url>
				<wp:base_blog_url>http://example.com</wp:base_blog_url>
				<generator>http://github.com/paulgibbs/phpdoc-to-wordpress</generator>

				<!-- List functions -->
				<xsl:apply-templates select="/project/file/function"/>

				<!-- List class methods -->
				<xsl:apply-templates select="/project/file/class/method"/>
			</channel>
		</rss>
	</xsl:template>

	<!-- Function template -->
	<xsl:template match="function">
		<item>

			<!-- Static nodes -->
			<description></description>
			<excerpt:encoded><![CDATA[]]></excerpt:encoded>
			<guid isPermaLink="false"></guid>
			<wp:comment_status>closed</wp:comment_status>
			<wp:is_sticky>0</wp:is_sticky>
			<wp:menu_order>0</wp:menu_order>
			<wp:ping_status>closed</wp:ping_status>
			<wp:post_name></wp:post_name>
			<wp:post_parent>0</wp:post_parent>
			<wp:post_password></wp:post_password>
			<wp:post_type>page</wp:post_type>
			<wp:status>publish</wp:status>

			<!-- Set title and dates -->
			<title><xsl:value-of select="name"/></title>
			<wp:post_date><xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/></wp:post_date>
			<wp:post_date_gmt>
				<xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] ')"/>
				<xsl:value-of select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime()), '[H01]:[m01]:[s01]')"/>
			</wp:post_date_gmt>

			<!-- The page content -->
			<content:encoded>
				<!-- Hack to get a single CDATA tag instead of using cdata-section-elements -->
				<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>

				<!-- Short description and 'more' tag -->
				<xsl:value-of select="normalize-space(docblock/description)"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<!--more-->]]>&#xa;</xsl:text>

				<!-- Function return type -->
				<h3>Description</h3><xsl:text>&#xa;</xsl:text>
				<xsl:choose>
					<xsl:when test="'' != docblock/tag[@name='return']/@type">
						<xsl:value-of select="docblock/tag[@name='return']/@type" disable-output-escaping="yes"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>void </xsl:text>
					</xsl:otherwise>
				</xsl:choose>

				<!-- Function name -->
				<strong><xsl:value-of select="name"/></strong>

				<!-- Basic function arguments -->
				<xsl:text> ( </xsl:text>
					<xsl:apply-templates select="argument"/>
				<xsl:text>)&#xa;&#xa;</xsl:text>

				<!-- Long description -->
				<xsl:value-of select="normalize-space(docblock/long-description)" disable-output-escaping="yes"/><xsl:text>&#xa;&#xa;</xsl:text>

				<!-- Detailed function arguments and descriptions -->
				<xsl:if test="'' != docblock/tag[@name='param']">
					<h3>Parameters</h3>
					<dl>
						<xsl:for-each select="docblock/tag[@name='param']">
							<dt><xsl:value-of select="@variable"/></dt>
							<dd><xsl:value-of select="@description"/></dd>
						</xsl:for-each>
					</dl><xsl:text>&#xa;&#xa;</xsl:text>
				</xsl:if>

				<!-- Return value -->
				<h3>Return Values</h3><xsl:text>&#xa;</xsl:text>
				<xsl:choose>
					<xsl:when test="'' != docblock/tag[@name='return']/@description">
						<xsl:value-of select="docblock/tag[@name='return']/@description"/>
					</xsl:when>
					<xsl:when test="'' != docblock/tag[@name='return']/@type">
						<xsl:value-of select="docblock/tag[@name='return']/@type"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>void</xsl:text>						
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>&#xa;&#xa;</xsl:text>

				<!-- @see -->
				<xsl:if test="'' != docblock/tag[@name='see']/@description">
					<h3>See Also</h3><xsl:text>&#xa;</xsl:text>
					<ul>
						<li><xsl:apply-templates select="docblock/tag[@name='see']"/></li>
					</ul>
				</xsl:if>

				<!-- Hack to get a single CDATA tag instead of using cdata-section-elements -->
				<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
			</content:encoded>

			<!-- Custom taxonomy meta -->
			<xsl:apply-templates select="./docblock/tag[@name='since']"/>

		</item>
	</xsl:template>

	<!-- Method template -->
	<xsl:template match="method">
		<item>

			<!-- Static nodes -->
			<description></description>
			<excerpt:encoded><![CDATA[]]></excerpt:encoded>
			<guid isPermaLink="false"></guid>
			<wp:comment_status>closed</wp:comment_status>
			<wp:is_sticky>0</wp:is_sticky>
			<wp:menu_order>0</wp:menu_order>
			<wp:ping_status>closed</wp:ping_status>
			<wp:post_parent>0</wp:post_parent>
			<wp:post_password></wp:post_password>
			<wp:post_type>page</wp:post_type>
			<wp:status>publish</wp:status>

			<!-- Set title and dates -->
			<title><xsl:value-of select="name"/></title>
			<wp:post_date><xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/></wp:post_date>
			<wp:post_date_gmt>
				<xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] ')"/>
				<xsl:value-of select="format-dateTime(adjust-dateTime-to-timezone(current-dateTime()), '[H01]:[m01]:[s01]')"/>
			</wp:post_date_gmt>

			<!-- Prefix the post's name with the class' name to avoid conflicts -->
			<wp:post_name><xsl:value-of select="concat(../name, '_', name)"/></wp:post_name>

			<!-- The page content -->
			<content:encoded>
				<!-- Hack to get a single CDATA tag instead of using cdata-section-elements -->
				<xsl:text disable-output-escaping="yes">&lt;![CDATA[</xsl:text>

				<!-- Short description and 'more' tag -->
				<xsl:value-of select="normalize-space(docblock/description)"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<!--more-->]]>&#xa;</xsl:text>

				<!-- Method return type -->
				<h3>Description</h3><xsl:text>&#xa;</xsl:text>
				<xsl:choose>
					<xsl:when test="'' != docblock/tag[@name='return']/@type">
						<xsl:value-of select="docblock/tag[@name='return']/@type" disable-output-escaping="yes"/>
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>void </xsl:text>
					</xsl:otherwise>
				</xsl:choose>

				<!-- Method abstract/static/final keywords -->
				<xsl:choose>
					<xsl:when test="'true' = @final">
						<xsl:text>final </xsl:text>
					</xsl:when>
					<xsl:when test="'true' = @static">
						<xsl:text>static </xsl:text>
					</xsl:when>
					<xsl:when test="'true' = @abstract">
						<xsl:text>abstract </xsl:text>
					</xsl:when>
				</xsl:choose>

				<!-- Method visibilty -->
				<xsl:value-of select="@visibility"/>
				<xsl:text> </xsl:text>

				<!-- Method name -->
				<strong><xsl:value-of select="name"/></strong>

				<!-- Basic method arguments -->
				<xsl:text> ( </xsl:text>
					<xsl:apply-templates select="argument"/>
				<xsl:text>)&#xa;&#xa;</xsl:text>

				<!-- Long description -->
				<xsl:value-of select="normalize-space(docblock/long-description)" disable-output-escaping="yes"/><xsl:text>&#xa;&#xa;</xsl:text>

				<!-- Detailed method arguments and descriptions -->
				<xsl:if test="'' != docblock/tag[@name='param']">
					<h3>Parameters</h3>
					<dl>
						<xsl:for-each select="docblock/tag[@name='param']">
							<dt><xsl:value-of select="@variable"/></dt>
							<dd><xsl:value-of select="@description"/></dd>
						</xsl:for-each>
					</dl><xsl:text>&#xa;&#xa;</xsl:text>
				</xsl:if>

				<!-- Return value -->
				<h3>Return Values</h3><xsl:text>&#xa;</xsl:text>
				<xsl:choose>
					<xsl:when test="'' != docblock/tag[@name='return']/@description">
						<xsl:value-of select="docblock/tag[@name='return']/@description"/>
					</xsl:when>
					<xsl:when test="'' != docblock/tag[@name='return']/@type">
						<xsl:value-of select="docblock/tag[@name='return']/@type"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>void</xsl:text>						
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>&#xa;&#xa;</xsl:text>

				<!-- @see -->
				<xsl:if test="'' != docblock/tag[@name='see']/@description">
					<h3>See Also</h3><xsl:text>&#xa;</xsl:text>
					<ul>
						<li><xsl:apply-templates select="docblock/tag[@name='see']"/></li>
					</ul>
				</xsl:if>

				<!-- Hack to get a single CDATA tag instead of using cdata-section-elements -->
				<xsl:text disable-output-escaping="yes">]]&gt;</xsl:text>
			</content:encoded>

			<!-- Store this method's class in post meta -->
			<wp:postmeta>
				<wp:meta_key>_ptw_class</wp:meta_key>
				<wp:meta_value><xsl:value-of select="../name"/></wp:meta_value>
			</wp:postmeta>

			<!-- Store post meta to mark this as a method -->
			<wp:postmeta>
				<wp:meta_key>_ptw_type</wp:meta_key>
				<wp:meta_value>method</wp:meta_value>
			</wp:postmeta>

			<!-- Custom taxonomy meta -->
			<xsl:apply-templates select="./docblock/tag[@name='since']"/>

		</item>
	</xsl:template>

	<!-- Functions: basic arguments -->
	<xsl:template match="argument">
		<!-- Variable type -->
		<xsl:variable name="var_type" select="name"/>
 		<xsl:value-of select="../docblock/tag[@variable=$var_type]/@type"/>
		<xsl:text> </xsl:text>

 		<!-- Variable name and default value -->
		<xsl:choose>
			<xsl:when test="'' != default">
				<xsl:value-of select="concat(name, ' = ', default, ', ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(name, ', ')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Functions: custom taxonomies -->
	<xsl:template match="function/docblock/tag[@name='since']">
		<category domain="contexts" nicename="developer">Developer</category>
		<category domain="types" nicename="functions">Functions</category>

		<category>
			<xsl:attribute name="domain">versions</xsl:attribute>
			<xsl:attribute name="nicename">
				<xsl:value-of select="replace(replace(replace(lower-case(@description), '[^%a-z0-9 _-]', ''), '\s+', ''), '-+', '')" />
			</xsl:attribute>
			<xsl:value-of select="@description"/>
		</category>
	</xsl:template>

	<!-- Methods: custom taxonomies -->
	<xsl:template match="method/docblock/tag[@name='since']">
		<category domain="contexts" nicename="developer">Developer</category>
		<category domain="types" nicename="methods">Methods</category>

		<category>
			<xsl:attribute name="domain">versions</xsl:attribute>
			<xsl:attribute name="nicename">
				<xsl:value-of select="replace(replace(replace(lower-case(@description), '[^%a-z0-9 _-]', ''), '\s+', ''), '-+', '')" />
			</xsl:attribute>
			<xsl:value-of select="@description"/>
		</category>
	</xsl:template>

	<!-- Functions & Methods: See Also -->
	<xsl:template match="docblock/tag[@name='see']">
		<xsl:value-of select="replace(replace(@description, '[{}\\]', ''), 'global', '')"/>
	</xsl:template>

	<!-- Eats up loose text for breakfast -->
	<xsl:template match="text()"/>

</xsl:stylesheet>
