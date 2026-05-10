<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>JUnit Report</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        h1 { color: #444; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        th { background: #eee; }
        .fail { background: #fdd; }
        .pass { background: #dfd; }
    </style>
</head>
<body>
    <h1>JUnit Test Report</h1>

    <table>
        <tr>
            <th>Test</th>
            <th>Class</th>
            <th>Time</th>
            <th>Status</th>
        </tr>

        <xsl:for-each select="//testcase">
            <tr>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of select="@classname"/></td>
                <td><xsl:value-of select="@time"/></td>

                <xsl:choose>
                    <xsl:when test="failure">
                        <td class="fail">FAILED</td>
                    </xsl:when>
                    <xsl:otherwise>
                        <td class="pass">PASSED</td>
                    </xsl:otherwise>
                </xsl:choose>
            </tr>
        </xsl:for-each>
    </table>
</body>
</html>
</xsl:template>

</xsl:stylesheet>