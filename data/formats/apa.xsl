<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:template match="root">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Times-Roman" font-size="12pt" line-height="2">
      <fo:layout-master-set>
        
        <fo:simple-page-master master-name="Cover" margin="1in" page-height="11in" page-width="8.5in">
          <fo:region-body />
        </fo:simple-page-master>
        <fo:page-sequence-master master-name="CoverPage">
          <fo:single-page-master-reference master-reference="Cover"/>
        </fo:page-sequence-master>
        
        <fo:simple-page-master master-name="Page"  margin="1in" page-height="11in" page-width="8.5in">
          <fo:region-body />
          <fo:region-before extent="1in"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <fo:page-sequence master-reference="CoverPage">
        <fo:flow flow-name="xsl-region-body">
          <fo:block-container margin-top="-0.5in">
            <fo:block absolute-position="fixed" left="0" top="0">
              Running Head: <xsl:value-of select="RunningHead" />
            </fo:block>
            <fo:block absolute-position="fixed" right="0" margin-top="-25px" text-align="end" width="10px">
              <fo:page-number />
            </fo:block>
          </fo:block-container>
          <fo:block text-align="center" page-break-after="always" margin-top="3in">
            <fo:block><xsl:value-of select="Title" /></fo:block>
            <fo:block><xsl:value-of select="Name" /></fo:block>
            <fo:block><xsl:value-of select="School" /></fo:block>
            <fo:block><xsl:value-of select="Course" /></fo:block>
            <fo:block><xsl:value-of select="Instructor" /></fo:block>
            <fo:block><xsl:value-of select="DueDate" /></fo:block>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>
      
      
      <fo:page-sequence master-reference="Page">
        <fo:static-content flow-name="xsl-region-before">
          <fo:block-container margin-top="-0.5in">
            <fo:block absolute-position="fixed" left="0" top="0">
              <xsl:value-of select="RunningHead" />
            </fo:block>
            <fo:block absolute-position="fixed" right="0" margin-top="-25px" text-align="end" width="10px">
              <fo:page-number />
            </fo:block>
          </fo:block-container>
        </fo:static-content>
        
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates select="Abstract" />
          <xsl:apply-templates select="Body" />
          <xsl:apply-templates select="References" />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>
  
  <xsl:template match="b|strong">
    <fo:inline font-weight="bold">
      <xsl:apply-templates select="*|text()"/>
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="Abstract">
    <fo:block page-break-after="always">
      <fo:block text-align="center">Abstract</fo:block>
      <xsl:apply-templates select="*|text()"/>
      <fo:block text-align="center">
        <fo:inline font-style="italic">Keywords:</fo:inline> <xsl:value-of select="../AbstractKeywords" />
      </fo:block>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="Abstract/p">
    <fo:block>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="Body">
    <fo:block page-break-after="always">
      <fo:block text-align="center"><xsl:value-of select="../Title" /></fo:block>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="Body/p">
    <fo:block text-indent="0.5in">
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="References">
    <fo:block page-break-after="always">
      <fo:block text-align="center">References</fo:block>
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="h1">
    <fo:block text-align="center" font-weight="bold">
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="h2">
    <fo:block font-weight="bold">
      <xsl:apply-templates select="*|text()"/>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="em|i">
    <fo:inline font-style="italic">
      <xsl:apply-templates select="*|text()"/>
    </fo:inline>
  </xsl:template>
</xsl:stylesheet>