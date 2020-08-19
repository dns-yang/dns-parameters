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
      <attribute name="name">dns-yang-dnssec-algorithms</attribute>
      <call-template name="yang-version"/>
      <element name="yin:namespace">
	<attribute name="uri">
	  <value-of
	      select="concat($dns-yang-uri, 'dns-yang-dnssec-algorithms')"/>
	</attribute>
      </element>
      <element name="yin:prefix">
	<attribute name="value">tsig</attribute>
      </element>
      <call-template name="dns-yang-org-con"/>
      <element name="yin:description">
	<element name="yin:text">This YANG module translates IANA
	registry 'Domain Name System Security (DNSSEC) Algorithm
	Numbers' to a set of YANG identities.</element>
      </element>
      <apply-templates select="iana:registry" mode="meta"/>
      <apply-templates select="iana:registry[@id='dns-sec-alg-numbers']"/>
    </element>
  </template>

  <template match="iana:registry[@id='dns-sec-alg-numbers']">
    <apply-templates select="iana:updated"/>
    <comment>Identities</comment>
    <element name="yin:identity">
      <attribute name="name">dnssec-algorithm</attribute>
      <element name="yin:description">
	<element name="yin:text">Base identity from which specific
	DNSSEC Algorithms are derived.</element>
      </element>
    </element>
    <element name="yin:identity">
      <attribute name="name">zone-signing</attribute>
      <element name="yin:base">
	<attribute name="name">dnssec-algorithm</attribute>
      </element>
      <element name="yin:description">
	<element name="yin:text">This identity represents algorithms
	that are intended for zone signing.</element>
      </element>
    </element>
    <element name="yin:identity">
      <attribute name="name">transaction-security</attribute>
      <element name="yin:base">
	<attribute name="name">dnssec-algorithm</attribute>
      </element>
      <element name="yin:description">
	<element name="yin:text">This identity represents
	algorithms that are intended for transaction security
	mechanisms (SIG(0) and TSIG).</element>
      </element>
    </element>
    <apply-templates
        select="iana:registry[@id='dns-sec-alg-numbers-1']/
		iana:record[iana:mnemonic]"/>
  </template>

  <template match="iana:record">
    <element name="yin:identity">
      <attribute name="name">
	<value-of select="iana:mnemonic"/>
      </attribute>
      <if test="contains(iana:description, 'deprecated')">
	<element name="yin:status">
	  <attribute name="value">obsolete</attribute>
	</element>
      </if>
      <if test="iana:signing != 'Y' and iana:transsec != 'Y'">
	<element name="yin:base">
	  <attribute name="name">dnssec-algorithm</attribute>
	</element>
      </if>
      <if test="iana:signing = 'Y'">
	<element name="yin:base">
	  <attribute name="name">zone-signing</attribute>
	</element>
      </if>
      <if test="iana:transsec = 'Y'">
	<element name="yin:base">
	  <attribute name="name">transaction-security</attribute>
	</element>
      </if>
      <element name="yin:description">
	<element name="yin:text">
	  <html:p>
	    <value-of select="iana:description"/>
	  </html:p>
	  <html:p>
	    <text>The assigned numeric code of this algorithm is </text>
	    <value-of select="iana:number"/>
	  </html:p>
	</element>
      </element>
      <call-template name="references"/>
    </element>
  </template>

</stylesheet>
