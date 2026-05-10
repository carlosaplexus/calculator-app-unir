<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" />

<xsl:template match="/">
<html>
<head>
    <title>JUnit Test Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background: #f5f7fa;
            color: #333;
        }
        h1 {
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        .summary-box {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .summary-item {
            font-size: 18px;
            margin: 8px 0;
        }
        .summary-item span {
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background: #ffffff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th {
            background: #3498db;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ecf0f1;
        }
        tr:nth-child(even) {
            background: #f2f6fa;
        }
        .ok {
            color: #27ae60;
            font-weight: bold;
        }
        .fail {
            color: #e74c3c;
            font-weight: bold;
        }
        .error-box {
            background: #fdecea;
            border-left: 5px solid #e74c3c;
            padding: 10px;
            margin-top: 10px;
            white-space: pre-wrap;
            font-family: monospace;
        }
    </style>
</head>

<body>

<h1>JUnit Test Report</h1>

<div class="summary-box">
    <div class="summary-item">Total tests: <span><xsl:value-of select="testsuite/@tests"/></span></div>
    <div class="summary-item">Failures: <span><xsl:value-of select="testsuite/@failures"/></span></div>
    <div class="summary-item">Errors: <span><xsl:value-of select="testsuite/@errors"/></span></div>
    <div class="summary-item">Time: <span><xsl:value-of select="testsuite/@time"/> s</span></div>
</div>

<table>
    <tr>
        <th>Test Case</th>
        <th>Class</th>
        <th>Status</th>
        <th>Time (s)</th>
        <th>Details</th>
    </tr>

    <xsl:for-each select="testsuite/testcase">
        <tr>
            <td><xsl:value-of select="@name"/></td>
            <td><xsl:value-of select="@classname"/></td>

            <td>
                <xsl:choose>
                    <xsl:when test="failure">
                        <span class="fail">FAILED</span>
                    </xsl:when>
                    <xsl:when test="error">
                        <span class="fail">ERROR</span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span class="ok">OK</span>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            <td><xsl:value-of select="@time"/></td>

            <td>
                <xsl:if test="failure">
                    <div class="error-box">
                        <xsl:value-of select="failure"/>
                    </div>
                </xsl:if>
                <xsl:if test="error">
                    <div class="error-box">
                        <xsl:value-of select="error"/>
                    </div>
                </xsl:if>
            </td>
        </tr>
    </xsl:for-each>
</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>