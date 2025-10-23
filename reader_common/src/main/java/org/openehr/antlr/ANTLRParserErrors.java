package org.openehr.antlr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pieter.bos on 19/10/15.
 */
public class ANTLRParserErrors implements IANTLRParserErrors {

    private static final Logger logger = LoggerFactory.getLogger(ANTLRParserErrors.class);

    private List<ANTLRParserMessage> errors = new ArrayList<>();
    private List<ANTLRParserMessage> warnings = new ArrayList<>();

    public void addError(String group, String error) {
        errors.add (new ANTLRParserMessage (group, error));
    }

    public void addError(String group, String error, String shortMessage, int line, int charPositionInLine) {
        errors.add (new ANTLRParserMessage (group, error, shortMessage, line, charPositionInLine));
    }

    public void addError(String group, String error, String shortMessage, int line, int charPositionInLine, Integer length, String offendingSymbol) {
        errors.add (new ANTLRParserMessage (group, error, shortMessage, line, charPositionInLine, length, offendingSymbol));
    }

    public void addWarning(String group, String error) {
        warnings.add (new ANTLRParserMessage (group, error));
    }

    public void addWarning(String group, String error, String shortMessage, int line, int charPositionInLine) {
        warnings.add (new ANTLRParserMessage (group, error, shortMessage, line, charPositionInLine));
    }

    public void addWarning(String group, String error, String shortMessage, int line, int charPositionInLine, int length, String offendingSymbol) {
        warnings.add (new ANTLRParserMessage (group, error, shortMessage, line, charPositionInLine, length, offendingSymbol));
    }

    public void logToLogger() {
        for (ANTLRParserMessage message:warnings) {
            logger.warn (message.qualifiedMessage());
        }
        for (ANTLRParserMessage message:errors) {
            logger.error (message.qualifiedMessage());
        }
    }

    public List<ANTLRParserMessage> getErrors() {
        return errors;
    }

    public void setErrors(List<ANTLRParserMessage> errors) {
        this.errors = errors;
    }

    public List<ANTLRParserMessage> getWarnings() {
        return warnings;
    }

    public void setWarnings(List<ANTLRParserMessage> warnings) {
        this.warnings = warnings;
    }

    public boolean hasNoMessages() {
        return this.getErrors().isEmpty() && this.getWarnings().isEmpty();
    }

    public boolean hasNoErrors() {
        return this.getErrors().isEmpty();
    }

    public boolean hasErrors() {
        return !getErrors().isEmpty();
    }

    public boolean hasWarnings() {
        return !getWarnings().isEmpty();
    }

    public String toString() {
        StringBuilder result = new StringBuilder();
        append(result, "Warning", warnings);
        append(result, "Error", errors);
        return result.toString();
    }

    // Append a list of messages to current String result
    private void append (StringBuilder result, String level, List<ANTLRParserMessage> messages) {
        for (ANTLRParserMessage message:messages) {
            result.append(level);
            result.append(": ");
            result.append(message.qualifiedMessage());
            result.append("\n");
        }
    }
}
