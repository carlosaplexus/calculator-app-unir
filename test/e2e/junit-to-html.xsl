<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>JUnit Report</title>
</head>

<body bgcolor="#f4f6f9" text="#333333">

    <h1 style="font-family: Arial; color: #2c3e50;">
        JUnit Test Report
    </h1>

    <table width="100%" border="1" cellpadding="8" cellspacing="0" bordercolor="#cccccc" bgcolor="#ffffff">
        <tr bgcolor="#3498db">
            <th><font color="white">Test</font></th>
            <th><font color="white">Class</font></th>
            <th><font color="white">Time</font></th>
            <th><font color="white">Status</font></th>
        </tr>

        <xsl:for-each select="//testcase">
            <tr>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of select="@classname"/></td>
                <td><xsl:value-of select="@time"/></td>

                <xsl:choose>
                    <xsl:when test="failure">
                        <td bgcolor="#fdecea"><font color="#c0392b"><b>FAILED</b></font></td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td bgcolor="#e8f8f1"><font color="#27ae60"><b>PASSED</b></font></td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
    </table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
