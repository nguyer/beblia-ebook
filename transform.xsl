<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <!-- Default book names from external file -->
    <xsl:variable name="book-names" select="document('book-names.xml')" />
    <html>
      <head>
        <title><xsl:value-of select="bible/@translation"/></title>
        <link rel="stylesheet" href="styles.css" />

        <!-- Uncomment this line to produce a paragraph style text body instead of the line by line style -->
        <!-- <link rel="stylesheet" href="paragraph.css" /> -->
      </head>
      <body>
        <!-- Book title -->
        <h1 class="title"><xsl:value-of select="bible/@translation" /></h1>

        <!-- Table of contents -->
        <ul id="toc" class="bible-book-list">
          <xsl:for-each select="bible/testament/book">
            <xsl:variable name="book-number" select="position()" />
            <li class="bible-book-link">
              <a href="#bible-book-{position()}">
                <xsl:choose>
                  <xsl:when test="@name">
                    <xsl:value-of select="@name" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of
                      select="$book-names/books/book[$book-number]"
                    />
                  </xsl:otherwise>
                </xsl:choose>
              </a>
            </li>
          </xsl:for-each>
        </ul>

        <!-- Book -->
        <xsl:for-each select="bible/testament/book">
          <xsl:variable name="book-number" select="position()" />
          <h2 id="bible-book-{$book-number}">
            <a href="#toc">
              <xsl:choose>
                <xsl:when test="@name">
                  <xsl:value-of select="@name" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$book-names/books/book[$book-number]" />
                </xsl:otherwise>
              </xsl:choose>
            </a>
          </h2>

          <!-- Book table of contents / chapter list -->
          <div class="bible-chapter-list">
            <xsl:for-each select="chapter">
              <xsl:variable name="chapter-number" select="position()" />
              <div class="bible-chapter-link">
                <a href="#bible-book{$book-number}-chapter{$chapter-number}">
                  <xsl:value-of select="position()" />
                </a>
              </div>
            </xsl:for-each>
          </div>

          <!-- Chapter -->
          <xsl:for-each select="chapter">
            <xsl:variable name="chapter-number" select="position()" />
            <div class="bible-chapter">
              <h3
                id="bible-book{$book-number}-chapter{$chapter-number}"
                class="bible-chapter-number"
              >
                <a href="#bible-book-{$book-number}">
                  <xsl:value-of select="@number" />
                </a>
              </h3>

              <!-- Verse -->
              <xsl:for-each select="verse">
                <span class="bible-verse">
                  <span class="bible-verse-number">
                    <xsl:value-of select="@number"
                  /></span>
                  <xsl:value-of select="current()" />
                </span>
              </xsl:for-each>
            </div>
          </xsl:for-each>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
