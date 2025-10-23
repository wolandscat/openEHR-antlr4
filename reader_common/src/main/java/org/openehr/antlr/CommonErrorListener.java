package org.openehr.antlr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.antlr.v4.runtime.ANTLRErrorListener;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.Interval;

import java.util.BitSet;

public class CommonErrorListener implements ANTLRErrorListener {

    private boolean logEnabled = true;

    private static final Logger logger = LoggerFactory.getLogger(CommonErrorListener.class);
    private final ANTLRParserErrors errors;
    private int lineNumberOffset = 0;

    private String tag = "";
    private String tagStr = "";

    public CommonErrorListener() {
        errors = new ANTLRParserErrors();
    }

    public CommonErrorListener(ANTLRParserErrors errors) {
        this.errors = errors;
    }

    /**
     *
     * @param errors
     * @param tag A string tag to distinguish this listener from others
     *            in use in the same overall parse, usually for different
     *            language sections of the same top-level file
     */
    public CommonErrorListener(ANTLRParserErrors errors, String tag, int lineNumberOffset) {
        this.errors = errors;
        this.tag = tag;
        this.tagStr = "[" + tag + "] ";
        this.lineNumberOffset = lineNumberOffset;
    }

    public boolean isLogEnabled() {
        return logEnabled;
    }

    public int lineNumber(int l) {
        return lineNumberOffset + l;
    }
    public void setLogEnabled (boolean logEnabled) {
        this.logEnabled = logEnabled;
    }

    @Override
    public void syntaxError (Recognizer<?,?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
        String error = String.format("syntax error at %d:%d: %s. msg: %s", lineNumber(line), charPositionInLine, offendingSymbol, msg);
        if(logEnabled) {
            logger.warn (tagStr + error);
        }
        if (offendingSymbol != null) {
            String offendingSymbolString = offendingSymbol.toString();
            errors.addError (tag, error, msg, lineNumber(line), charPositionInLine, offendingSymbolString.length(), offendingSymbolString);
        } else {
            errors.addError (tag, error, msg, lineNumber(line), charPositionInLine);
        }
    }

    @Override
    public void reportAmbiguity (Parser recognizer, DFA dfa, int startIndex, int stopIndex, boolean exact, BitSet ambigAlts, ATNConfigSet configs) {
        String input = recognizer.getInputStream().getText(new Interval(startIndex, stopIndex));
        String warning = String.format("FULL AMBIGUITY: %d-%d, exact: %b, input: %s", startIndex, stopIndex, exact, input);
        if(logEnabled) {
            logger.debug (tagStr + warning);
        }
        errors.addWarning (tag, warning);
    }

    @Override
    public void reportAttemptingFullContext (Parser recognizer, DFA dfa, int startIndex, int stopIndex, BitSet conflictingAlts, ATNConfigSet configs) {
        String input = recognizer.getInputStream().getText(new Interval(startIndex, stopIndex));
        if(logEnabled) {
            logger.debug (tagStr + "FULL CONTEXT: {}-{}, alts: {}, {}", startIndex, stopIndex, conflictingAlts, input);
        }
    }

    @Override
    public void reportContextSensitivity (Parser recognizer, DFA dfa, int startIndex, int stopIndex, int prediction, ATNConfigSet configs) {
        if(logEnabled) {
            logger.debug (tagStr + "CONTEXT SENSITIVITY: {}-{}, prediction: {}", startIndex, stopIndex, prediction);
        }
    }

    public ANTLRParserErrors getErrors() {
        return errors;
    }
}
