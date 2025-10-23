package org.openehr.antlr;

/**
 * An error, info or warning message from the archetype parsing
 *
 * Created by pieter.bos on 19/10/15.
 */
public class ANTLRParserMessage {

    private final String group;
    private final String message;
    private String shortMessage;
    private Integer lineNumber;
    private Integer columnNumber;
    private Integer length;
    private String offendingSymbol;

    public ANTLRParserMessage(String group, String message) {
        this.group = group;
        this.message = message;
    }

    public ANTLRParserMessage(String group, String message, String shortMessage, Integer lineNumber, Integer columnNumber) {
        this.group = group;
        this.message = message;
        this.shortMessage = shortMessage;
        this.lineNumber = lineNumber;
        this.columnNumber = columnNumber;
    }

    public ANTLRParserMessage(String group, String message, String shortMessage, Integer lineNumber, Integer columnNumber, Integer length, String offendingSymbol) {
        this.group = group;
        this.message = message;
        this.shortMessage = shortMessage;
        this.lineNumber = lineNumber;
        this.columnNumber = columnNumber;
        this.length = length;
        this.offendingSymbol = offendingSymbol;
    }


    public String qualifiedMessage() {
        return "[" + group + "] " + message ;
    }

    public String getGroup() {
        return group;
    }

    public String getMessage() {
        return message;
    }

    public int getLineNumber() {
        return lineNumber;
    }

    public int getColumnNumber() {
        return columnNumber;
    }

    public String getShortMessage() {
        return shortMessage;
    }

    public Integer getLength() {
        return length;
    }

    public String getOffendingSymbol() {
        return offendingSymbol;
    }
}
