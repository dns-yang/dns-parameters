<?xml version="1.0" standalone="yes"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
            xmlns:iana="http://www.iana.org/assignments"
            version="1.0">
  <output method="text"/>
  <strip-space elements="*"/>

  <variable name="dq">"</variable>
  <variable name="sq">'</variable>
  <variable name="lf">&#xA;</variable>

  <variable name="module-intro">
    <text>module dns-yang-tsig-algorithms {
  yang-version 1.1;
  namespace "urn:dns-yang:params:xml:ns:yang:dns-yang-tsig-algorithms";
  prefix tsig;

  organization
    "DNS-YANG project";

  contact
    "https://github.com/dns-yang/dns-parameters";

  description
    "This YANG module translates IANA registry 'Secret Key Transaction
     Authentication for DNS (TSIG) Algorithm Names' to a set of YANG
     identities.";

  reference
    "IANA: Secret Key Transaction Authentication for DNS (TSIG)
     Algorithm Names.
     http://www.iana.org/assignments/tsig-algorithm-names";</text>
     <text>&#xA;&#xA;</text>
  </variable>

  <template name="identity">
    <param name="id"/>
    <param name="base" select="'tsig-algorithm'"/>
    <value-of select="concat('  identity ', $id, ' {&#xA;')"/>
    <value-of select="concat('    base ', $base, ';&#xA;')"/>
    <variable name="xrefs" select="iana:xref[@type!='note']"/>
    <if test="$xrefs">
      <text>    reference&#xA;      "</text>
      <if test="count($xrefs)&gt;1">- </if>
      <apply-templates select="iana:xref[@type!='note']"/>
    </if>
    <text>  }&#xA;&#xA;</text>
  </template>

  <template match="/">
    <value-of select="$module-intro"/>
    <apply-templates select="iana:registry[@id='tsig-algorithm-names']"/>
    <text>}&#xA;</text>
  </template>

  <template match="iana:registry[@id='tsig-algorithm-names']">
    <apply-templates select="iana:updated"/>
    <apply-templates
        select="iana:registry[@id='tsig-algorithm-names-1']"/>
  </template>

  <template match="iana:updated">
    <value-of select="concat('  revision ', ., ';&#xA;')"/>
  </template>

  <template match="iana:registry[@id='tsig-algorithm-names-1']">
    <text>
  /* Identities */

  identity tsig-algorithm {
    description
      "Base identity from which specific TSIG Algorithms are
       derived.";
    }&#xA;&#xA;</text>
    <apply-templates select="iana:record"/>
  </template>

  <template match="iana:record">
    <call-template name="identity">
      <with-param name="id" select="iana:name"/>
    </call-template>
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
    <choose>
      <when test="position()=last()">
        <text>";&#xA;</text>
      </when>
      <otherwise>
        <text>&#xA;       - </text>
      </otherwise>
    </choose>
  </template>

  <template match="iana:person">
    <value-of select="concat(iana:name, ' &lt;', iana:uri, '&gt;')"/>
  </template>

</stylesheet>
