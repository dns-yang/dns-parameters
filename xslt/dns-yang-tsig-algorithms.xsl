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
      <attribute name="name">dns-yang-tsig-algorithms</attribute>
      <call-template name="yang-version"/>
      <element name="yin:namespace">
	<attribute name="uri">
	  <value-of
	      select="concat($dns-yang-uri, 'dns-yang-tsig-algorithms')"/>
	</attribute>
      </element>
      <element name="yin:prefix">
	<attribute name="value">tsig</attribute>
      </element>
      <call-template name="dns-yang-org-con"/>
      <element name="yin:description">
	<element name="yin:text">This YANG module translates IANA
	registry 'Secret Key Transaction Authentication for DNS (TSIG)
	Algorithm Names' to a set of YANG identities.</element>
      </element>
      <apply-templates select="iana:registry" mode="meta"/>
      <apply-templates select="iana:registry[@id='tsig-algorithm-names']"/>
    </element>
  </template>

  <template match="iana:registry[@id='tsig-algorithm-names']">
    <apply-templates select="iana:updated"/>
    <comment>Identities</comment>
    <element name="yin:identity">
      <attribute name="name">tsig-algorithm</attribute>
      <element name="yin:description">
	<element name="yin:text">Base identity from which specific
	TSIG Algorithms are derived.</element>
      </element>
    </element>
    <apply-templates
        select="iana:registry[@id='tsig-algorithm-names-1']/
		iana:record"/>
  </template>

  <template match="iana:record">
    <call-template name="identity">
      <with-param name="id" select="iana:name"/>
      <with-param name="base">tsig-algorithm</with-param>
    </call-template>
  </template>

</stylesheet>
