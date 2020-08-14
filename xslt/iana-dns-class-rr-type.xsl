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
    <text>module iana-dns-class-rr-type {
  yang-version 1.1;
  namespace "urn:ietf:params:xml:ns:yang:iana-dns-class-rr-type";
  prefix dnsct;

  organization
    "Internet Assigned Numbers Authority (IANA)";

  contact
    "        Internet Assigned Numbers Authority

     Postal: ICANN
             4676 Admiralty Way, Suite 330
             Marina del Rey, CA 90292

     Tel:    +1 310 823 9358

     &lt;mailto:iana@iana.org&gt;";

  description
    "This YANG module translates IANA registries 'DNS CLASSes' and
     'Resource Record (RR) TYPEs' to YANG derived types.

     Copyright (c) 2020 IETF Trust and the persons identified as
     authors of the code. All rights reserved.

     Redistribution and use in source and binary forms, with or
     without modification, is permitted pursuant to, and subject to
     the license terms contained in, the Simplified BSD License set
     forth in Section 4.c of the IETF Trust's Legal Provisions
     Relating to IETF Documents
     (https://trustee.ietf.org/license-info).

     This initial version of this YANG module was generated from
     the corresponding IANA registries using a XSLT stylesheet
     from Appendix A of RFC XXXX
     (https://tools.ietf.org/html/rfcXXXX); see the RFC itself for
     full legal notices.";

  reference
    "IANA 'Domain Name System (DNS) Parameters' registry
     https://www.iana.org/assignments/dns-parameters";</text>
     <text>&#xA;&#xA;</text>
  </variable>

  <template name="enum">
    <param name="id"/>
    <value-of select="concat('      enum ', $id)"/>
    <text> {&#xA;        value </text>
    <value-of select="concat(iana:value, ';&#xA;')"/>
    <if test="contains(iana:description, 'OBSOLETE')">
      <text>        status obsolete;&#xA;</text>
    </if>
    <apply-templates select="iana:description"/>
    <variable name="xrefs" select="iana:xref[@type!='note']"/>
    <if test="$xrefs">
      <text>        reference&#xA;          "</text>
      <if test="count($xrefs)&gt;1">- </if>
      <apply-templates select="iana:xref[@type!='note']"/>
    </if>
    <text>      }&#xA;</text>
  </template>

  <template match="/">
    <value-of select="$module-intro"/>
    <apply-templates select="iana:registry[@id='dns-parameters']"/>
    <text>}&#xA;</text>
  </template>

  <template match="iana:registry[@id='dns-parameters']">
    <apply-templates select="iana:updated"/>
    <apply-templates
        select="iana:registry[@id='dns-parameters-2']"/>
    <apply-templates
        select="iana:registry[@id='dns-parameters-4']"/>
  </template>

  <template match="iana:updated">
    <value-of select="concat('  revision ', ., ' {')"/>
    <text>
    description
      "Initial revision.";
    reference
      "RFC XXXX: YANG Types for DNS Classes and Resource Record
       Types";
  }

  /* Typedefs */&#xA;&#xA;</text>
  </template>

  <template match="iana:registry[@id='dns-parameters-2']">
    <text>  typedef dns-class-name {&#xA;</text>
    <text>    type enumeration {&#xA;</text>
    <apply-templates
        select="iana:record[not(iana:description='Unassigned' or
                starts-with(iana:description,'Reserved'))]"
        mode="class"/>
    <text>    }
    description
      "This enumeration type defines mnemonic names and corresponding
       numeric values of DNS classes.";
    reference
      "RFC 6895: Domain Name System (DNS) IANA Considerations";
  }
    
  typedef dns-class {
    type union {
      type uint16;
      type dns-class-name;
    }
    description
      "This type allows for referring to a DNS class using either the
       assigned mnemonic name or numeric value.";
  }&#xA;&#xA;</text>
  </template>

  <template match="iana:registry[@id='dns-parameters-4']">
    <text>  typedef rr-type-name {&#xA;</text>
    <text>    type enumeration {&#xA;</text>
    <apply-templates
        select="iana:record[iana:type!='Unassigned' and
                iana:type!='Private use' and iana:type!='Reserved']"
        mode="rr-type"/>
    <text>    }
    description
      "This enumeration type defines mnemonic names and corresponding
       numeric values of DNS resource record types.";
    reference
      "- RFC 6895: Domain Name System (DNS) IANA Considerations

       - RFC 1035: Domain Names - Implementation and Specification";
  }

  typedef rr-type {
    type union {
      type uint16;
      type rr-type-name;
    }
    description
      "This type allows for referring to a DNS resource record type
       using either the assigned mnemonic name or numeric value.";
  }&#xA;</text>
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

  <template match="iana:description">
    <text>        description&#xA;          </text>
    <value-of select="concat($dq, ., $dq, ';&#xA;')"/>
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
        <text>&#xA;           - </text>
      </otherwise>
    </choose>
  </template>

  <template match="iana:person">
    <value-of select="concat(iana:name, ' &lt;', iana:uri, '&gt;')"/>
  </template>

</stylesheet>
