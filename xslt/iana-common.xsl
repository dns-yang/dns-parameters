<?xml version="1.0"?>

<!-- Program name: iana-common.xsl

Common XSLT templates for transforming contents of IANA registries
into YANG modules (in YIN format).

-->

<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
            xmlns:iana="http://www.iana.org/assignments"
	    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
	    xmlns:html="http://www.w3.org/1999/xhtml"
	    version="1.0">

  <variable name="dq">"</variable>
  <variable name="sq">'</variable>
  <variable
      name="dns-yang-uri">urn:dns-yang:params:xml:ns:yang:</variable>

  <template name="yang-version">
    <element name="yin:yang-version">
      <attribute name="value">1.1</attribute>
    </element>
  </template>

  <template name="dns-yang-org-con">
    <element name="yin:organization">
      <element name="yin:text">DNS-YANG project</element>
    </element>
    <element name="yin:contact">
      <element
	  name="yin:text">https://github.com/dns-yang/dns-parameters</element>
    </element>
  </template>

  <template name="references">
    <variable name="xrefs" select="iana:xref[@type!='note']"/>
    <element name="yin:reference">
      <element name="yin:text">
	<choose>
	  <when test="count($xrefs) &gt; 1">
	    <element name="html:ul">
	      <apply-templates select="$xrefs" mode="multi"/>
	    </element>
	  </when>
	  <otherwise>
	    <apply-templates select="$xrefs"/>
	  </otherwise>
	</choose>
      </element>
    </element>
  </template>

  <template name="enum">
    <param name="id"/>
    <element name="yin:enum">
      <attribute name="name">
	<value-of select="$id"/>
      </attribute>
      <element name="yin:value">
	<attribute name="value">
	  <value-of select="iana:value"/>
	</attribute>
      </element>
      <if test="contains(iana:description, 'OBSOLETE')">
	<element name="yin:status">
	  <attribute name="value">obsolete</attribute>
	</element>
      </if>
      <apply-templates select="iana:description"/>
      <call-template name="references"/>
    </element>
  </template>

  <template name="identity">
    <param name="id"/>
    <param name="base"/>
    <element name="yin:identity">
      <attribute name="name">
	<value-of select="$id"/>
      </attribute>
      <element name="yin:base">
	<attribute name="name">
	  <value-of select="$base"/>
	</attribute>
      </element>
      <call-template name="references"/>
    </element>
  </template>

  <template match="iana:xref" mode="multi">
    <element name="html:li">
      <apply-templates select="."/>
    </element>
  </template>

  <template match="iana:xref">
    <choose>
      <when test="@type='rfc'">
        <value-of
	    select="concat('RFC ', substring-after(@data, 'rfc'))"/>
      </when>
      <when test="@type='person'">
        <apply-templates
	    select="/iana:registry/iana:people/iana:person[
		    @id=current()/@data]"/>
      </when>
      <when test="@type='text'">
        <value-of select="translate(., $dq, $sq)"/>
      </when>
      <otherwise>
        <value-of select="@data"/>
      </otherwise>
    </choose>
  </template>

  <template match="iana:person">
    <value-of select="concat(iana:name, ' &lt;', iana:uri, '&gt;')"/>
  </template>

  <template match="iana:description">
    <element name="yin:description">
      <element name="yin:text">
	<value-of select="."/>
      </element>
    </element>
  </template>

  <template match="iana:updated">
    <element name="yin:revision">
      <attribute name="date">
	<value-of select="."/>
      </attribute>
    </element>
  </template>

</stylesheet>
