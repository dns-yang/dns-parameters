<?xml version="1.0" standalone="yes"?>
<stylesheet xmlns="http://www.w3.org/1999/XSL/Transform"
            xmlns:iana="http://www.iana.org/assignments"
	    xmlns:yin="urn:ietf:params:xml:ns:yang:yin:1"
	    xmlns:html="http://www.w3.org/1999/xhtml"
            version="1.0">
  <output method="xml"/>
  <strip-space elements="*"/>
  <include href="iana-common.xsl"/>
  
  <template match="/">
    <element name="yin:module">
      <attribute name="name">iana-dns-class-rr-type</attribute>
      <call-template name="yang-version"/>
      <element name="yin:namespace">
	<attribute name="uri">
	  <text>urn:ietf:params:xml:ns:yang:iana-dns-class-rr-type</text>
	</attribute>
      </element>
      <element name="yin:prefix">
	<attribute name="value">dnsct</attribute>
      </element>
      <element name="yin:organization">
	<element name="yin:text">Internet Assigned Numbers Authority
	(IANA)</element>
      </element>
      <element name="yin:contact">
	<element name="yin:text">
	  <element name="html:p">Internet Assigned Numbers
	  Authority</element>
	  <element name="html:p">4676 Admiralty Way, Suite
	  330<element name="html:br"/>
	  Marina del Rey, CA 90292</element>
	  <element name="html:p">Tel: +1 310 823 9358</element>
	  <element
	      name="html:p">&lt;mailto:iana@iana.org&gt;</element>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">
	  <element name="html:p">This YANG module translates IANA
	  registries 'DNS CLASSes' and 'Resource Record (RR) TYPEs' to
	  YANG derived types.</element>
	  <element name="html:p">Copyright © 2020 IETF Trust and the
	  persons identified as authors of the code. All rights
	  reserved.</element>
	  <element name="html:p">Redistribution and use in source and
	  binary forms, with or without modification, is permitted
	  pursuant to, and subject to the license terms contained in,
	  the Simplified BSD License set forth in Section 4.c of the
	  IETF Trust's Legal Provisions Relating to IETF Documents
	  (https://trustee.ietf.org/license-info).</element>
	  <element name="html:p"> This initial version of this YANG
	  module was generated from the corresponding IANA registries
	  using a XSLT stylesheet from Appendix A of RFC XXXX
	  (https://tools.ietf.org/html/rfcXXXX); see the RFC itself
	  for full legal notices.</element>
	</element>
      </element>
      <apply-templates select="iana:registry" mode="meta"/>
      <apply-templates select="iana:registry[@id='dns-parameters']"/>
    </element>
  </template>

  <template match="iana:registry[@id='dns-parameters']">
    <apply-templates select="iana:updated"/>
    <comment>Typedefs</comment>
    <apply-templates
        select="iana:registry[@id='dns-parameters-2']"/>
    <apply-templates
        select="iana:registry[@id='dns-parameters-4']"/>
  </template>

  <template match="iana:registry[@id='dns-parameters-2']">
    <element name="yin:typedef">
      <attribute name="name">dns-class-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
            select="iana:record[not(iana:description='Unassigned' or
                    starts-with(iana:description,'Reserved'))]"
            mode="class"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">This enumeration type defines
	mnemonic names and corresponding numeric values of DNS
	classes.</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">RFC 6895: Domain Name System (DNS)
	IANA Considerations</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">dns-class</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint16</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">dns-class-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">This type allows for referring to a
	DNS class using either the assigned mnemonic name or numeric
	value.</element>
      </element>
    </element>
  </template>

  <template match="iana:registry[@id='dns-parameters-4']">
    <element name="yin:typedef">
      <attribute name="name">rr-type-name</attribute>
      <element name="yin:type">
	<attribute name="name">enumeration</attribute>
	<apply-templates
	    select="iana:record[iana:type!='Unassigned' and
		    iana:type!='Private use' and iana:type!='Reserved']"
	    mode="rr-type"/>
      </element>
      <element name="yin:description">
	<element name="yin:text">This enumeration type defines
	mnemonic names and corresponding numeric values of DNS
	resource record types.</element>
      </element>
      <element name="yin:reference">
	<element name="yin:text">
	  <element name="html:ul">
	    <element name="html:li">RFC 6895: Domain Name System (DNS)
	    IANA Considerations</element>
	    <element name="html:li">RFC 1035: Domain Names -
	    Implementation and Specification</element>
	  </element>
	</element>
      </element>
    </element>
    <element name="yin:typedef">
      <attribute name="name">rr-type</attribute>
      <element name="yin:type">
	<attribute name="name">union</attribute>
	<element name="yin:type">
	  <attribute name="name">uint16</attribute>
	</element>
	<element name="yin:type">
	  <attribute name="name">rr-type-name</attribute>
	</element>
      </element>
      <element name="yin:description">
	<element name="yin:text">This type allows for referring to a
	DNS resource record type using either the assigned mnemonic
	name or numeric value.</element>
      </element>
    </element>
  </template>

  <template match="iana:record" mode="class">
    <call-template name="enum">
      <with-param name="id">
	<choose>
          <when test="contains(iana:description,'(')">
            <value-of select="substring-before(substring-after(
                              iana:description, '('), ')')"/>
          </when>
          <otherwise>
            <value-of
		select="substring-after(iana:description, ' ')"/>
          </otherwise>
	</choose>
      </with-param>
    </call-template>
  </template>

  <template match="iana:record" mode="rr-type">
    <call-template name="enum">
      <with-param name="id" select="iana:type"/>
    </call-template>
  </template>

</stylesheet>
