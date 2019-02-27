<?xml version="1.0" encoding="utf-8"?>
<!-- XSL Template for converting the XML documentation to plain text with WikiPlex markup -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="text" indent="no" encoding="utf-8" />

  <xsl:template match="/">
    <xsl:value-of select="concat('h1. ', /database/@name, ' Database Schema&#13;&#10;&#13;&#10;')" />
    <xsl:text>{toc:printable=true|style=square|maxLevel=2|indent=5px|minLevel=2|class=bigpink|exclude=[1//2]|type=list|outline=true|include=.*}</xsl:text>
    <!-- Process all tables and views -->
    <xsl:for-each select="/database/object[@type='USER_TABLE' or @type='VIEW']">
      <xsl:sort select="@schema"/>
      <xsl:sort select="@name"/>
      <xsl:call-template name="SingleDbTableOrView" />
    </xsl:for-each>
    <!-- Process all stored procedures -->
    <xsl:for-each select="/database/object[@type='SQL_STORED_PROCEDURE']">
      <xsl:sort select="@schema"/>
      <xsl:sort select="@name"/>
      <xsl:call-template name="StoredProc" />
    </xsl:for-each>
    <!-- Process all user functions -->
    <xsl:for-each select="/database/object[@type='SQL_TABLE_VALUED_FUNCTION']">
      <xsl:sort select="@schema"/>
      <xsl:sort select="@name"/>
      <xsl:call-template name="UserFunction" />
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="UserFunction">
    <xsl:value-of select="concat('{anchor:', @schema, '.', @name, '}&#13;&#10;h2. ')"/>
    <xsl:choose>
      <xsl:when test="@type='SQL_TABLE_VALUED_FUNCTION'">User Value Function </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat(@schema, '.', @name, '&#13;&#10;&#13;&#10;')"/>

    <!-- 
    <parameter is_readonly="false" is_nullable="true" /> 
    -->
    <xsl:text>|| Parameter || Type || Nullable || Comment ||&#13;&#10;</xsl:text>
    <xsl:for-each select="parameter">
      <xsl:value-of select="concat('| *', @name, '*')"/>
      <xsl:value-of select="concat(' | ', @type)"/>
      <xsl:choose>
        <xsl:when test="@max_length=-1"> (max)</xsl:when>
        <xsl:when test="@max_length='MAX'"> (max)</xsl:when>
        <xsl:when test="@type='char' or @type='varchar' or @type='binary' or @type='varbinary'">
          <xsl:value-of select="concat(' (', @max_length, ')')"/>
        </xsl:when>
        <xsl:when test="@type='nchar' or @type='nvarchar'">
          <xsl:value-of select="concat(' (', @max_length div 2, ')')"/>
        </xsl:when>
        <xsl:when test="@type='real' or @type='money' or @type='float' or @type='decimal' or @type='numeric' or @type='smallmoney'">
          <xsl:value-of select="concat(' (', @precision, ', ', @scale, ')')"/>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@is_nullable='true'"> | NULL | </xsl:when>
        <xsl:otherwise> | NOT NULL | </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@is_output='true'">_OUTPUT_ </xsl:if>
      <xsl:if test="@computed='true'">_COMPUTED_ </xsl:if>
      <xsl:if test="@is_cursor_ref='true'">_CURSOR REFERENCE_ </xsl:if>
      <xsl:if test="@has_default_value='true'">_HAS DEFAULT VALUE_ </xsl:if>
      <xsl:if test="@is_xml_document='true'">_XML DOCUMENT_ </xsl:if>
      <xsl:if test="@xml_collection_id='true'">_TYPED XML COLLECTION_ </xsl:if>
      <xsl:if test="@is_readonly='true'">_READONLY_ </xsl:if>

      <xsl:if test="@description">
        <xsl:value-of select="concat(@description, ' ')"/>
      </xsl:if>
      <xsl:text>|&#13;&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#13;&#10;</xsl:text>

    <xsl:if test="@description">
      <xsl:value-of select="concat(@description, '&#13;&#10;&#13;&#10;')" />
    </xsl:if>

    <xsl:text>{code:title=Definition|theme=FadeToGrey|linenumbers=true|language=java|firstline=0001|collapse=true}&#13;&#10;</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>{code}</xsl:text>

  </xsl:template>

  <xsl:template name="StoredProc">
    <xsl:value-of select="concat('{anchor:', @schema, '.', @name, '}&#13;&#10;h2. ')"/>
    <xsl:choose>
      <xsl:when test="@type='SQL_STORED_PROCEDURE'">Stored Procedure </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat(@schema, '.', @name, '&#13;&#10;&#13;&#10;')"/>

    <!-- 
    <parameter is_readonly="false" is_nullable="true" /> 
    -->
    <xsl:text>|| Parameter || Type || Nullable || Comment ||&#13;&#10;</xsl:text>
    <xsl:for-each select="parameter">
      <xsl:value-of select="concat('| *', @name, '*')"/>
      <xsl:value-of select="concat(' | ', @type)"/>
      <xsl:choose>
        <xsl:when test="@max_length=-1"> (max)</xsl:when>
        <xsl:when test="@max_length='MAX'"> (max)</xsl:when>
        <xsl:when test="@type='char' or @type='varchar' or @type='binary' or @type='varbinary'">
          <xsl:value-of select="concat(' (', @max_length, ')')"/>
        </xsl:when>
        <xsl:when test="@type='nchar' or @type='nvarchar'">
          <xsl:value-of select="concat(' (', @max_length div 2, ')')"/>
        </xsl:when>
        <xsl:when test="@type='real' or @type='money' or @type='float' or @type='decimal' or @type='numeric' or @type='smallmoney'">
          <xsl:value-of select="concat(' (', @precision, ', ', @scale, ')')"/>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@is_nullable='true'"> | NULL | </xsl:when>
        <xsl:otherwise> | NOT NULL | </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@is_output='true'">_OUTPUT_ </xsl:if>
      <xsl:if test="@computed='true'">_COMPUTED_ </xsl:if>
      <xsl:if test="@is_cursor_ref='true'">_CURSOR REFERENCE_ </xsl:if>
      <xsl:if test="@has_default_value='true'">_HAS DEFAULT VALUE_ </xsl:if>
      <xsl:if test="@is_xml_document='true'">_XML DOCUMENT_ </xsl:if>
      <xsl:if test="@xml_collection_id='true'">_TYPED XML COLLECTION_ </xsl:if>
      <xsl:if test="@is_readonly='true'">_READONLY_ </xsl:if>

      <xsl:if test="@description">
        <xsl:value-of select="concat(@description, ' ')"/>
      </xsl:if>
      <xsl:text>|&#13;&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#13;&#10;</xsl:text>

    <xsl:if test="@description">
      <xsl:value-of select="concat(@description, '&#13;&#10;&#13;&#10;')" />
    </xsl:if>

    <xsl:if test="notes/note">
      <xsl:text>*Notes:*&#13;&#10;</xsl:text>
      <xsl:for-each select="notes/note">
        <xsl:value-of select="."/>
        <xsl:text>|&#13;&#10;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#13;&#10;</xsl:text>
    </xsl:if>


    <xsl:text>{code:title=Definition|theme=FadeToGrey|linenumbers=true|language=java|firstline=0001|collapse=true}&#13;&#10;</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>{code}</xsl:text>

  </xsl:template>

  <xsl:template name="SingleDbTableOrView">
    <xsl:value-of select="concat('{anchor:', @schema, '.', @name, '}&#13;&#10;h2. ')"/>
    <xsl:choose>
      <xsl:when test="@type='USER_TABLE'">Table </xsl:when>
      <xsl:when test="@type='VIEW'">View </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat(@schema, '.', @name, '&#13;&#10;&#13;&#10;')"/>
    <xsl:if test="@description">
      <xsl:value-of select="concat(@description, '&#13;&#10;&#13;&#10;')" />
    </xsl:if>

    <xsl:text>|| Name || Type || Nullable || Comment ||&#13;&#10;</xsl:text>
    <xsl:for-each select="column">
      <xsl:value-of select="concat('| *', @name, '*')"/>
      <xsl:if test="primaryKey"> ^^PK^^</xsl:if>
      <xsl:value-of select="concat(' | ', @type)"/>
      <xsl:choose>
        <xsl:when test="@length=-1"> (max)</xsl:when>
        <xsl:when test="@type='char' or @type='varchar' or @type='binary' or @type='varbinary'">
          <xsl:value-of select="concat(' (', @length, ')')"/>
        </xsl:when>
        <xsl:when test="@type='nchar' or @type='nvarchar'">
          <xsl:value-of select="concat(' (', @length div 2, ')')"/>
        </xsl:when>
        <xsl:when test="@type='real' or @type='money' or @type='float' or @type='decimal' or @type='numeric' or @type='smallmoney'">
          <xsl:value-of select="concat(' (', @precision, ', ', @scale, ')')"/>
        </xsl:when>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="@nullable='true'"> | NULL | </xsl:when>
        <xsl:otherwise> | NOT NULL | </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@identity='true'">_IDENTITY_ </xsl:if>
      <xsl:if test="@computed='true'">_COMPUTED_ </xsl:if>
      <xsl:if test="default">
        <xsl:value-of select="concat('_DEFAULT ', default/@value, '_ ')"/>
      </xsl:if>
      <xsl:if test="foreignKey">
        <xsl:variable name="FK" select="foreignKey" />
        <xsl:text>_-&gt; </xsl:text>
        <xsl:value-of select="concat('[#', //object[@id=$FK/@tableId]/@schema, '.', //object[@id=$FK/@tableId]/@name, ']')"/>
        <xsl:value-of select="concat('.', foreignKey/@column, '_ ')"/>
      </xsl:if>
      <xsl:if test="@description">
        <xsl:value-of select="concat(@description, ' ')"/>
      </xsl:if>
      <xsl:text>|&#13;&#10;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#13;&#10;</xsl:text>

  <!--
  <object id="158623608" schema="dbo" name="PRFtrAuthorization" type="USER_TABLE" dateCreated="2018-06-02T23:51:22.303" dateModified="2018-07-19T15:18:53.377">
    <object id="1758629308" schema="dbo" name="EnforceSingleRole" type="SQL_TRIGGER" dateCreated="2018-07-19T15:18:53.377" dateModified="2018-07-19T15:18:53.377" />
  </object>
  -->

    <xsl:for-each select="/database/object[@type='USER_TABLE' or @type='VIEW']">
      <xsl:sort select="@schema"/>
      <xsl:sort select="@name"/>
      <xsl:call-template name="SingleDbTableOrView" />
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
