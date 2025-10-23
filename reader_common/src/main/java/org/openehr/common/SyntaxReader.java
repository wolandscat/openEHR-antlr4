package org.openehr.common;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.Parser;
import org.openehr.antlr.ANTLRParserErrors;
import org.openehr.antlr.CommonErrorListener;
import org.openehr.antlr.IANTLRParserErrors;

public abstract class SyntaxReader<L extends Lexer, P extends Parser> {

    // ---------------------- Creation ----------------------

    public SyntaxReader (boolean logging, boolean keepAntlrErrors) {
        this.logging = logging;
        this.keepAntlrErrors = keepAntlrErrors;
    }

    // ---------------------- Commands ----------------------

    /**
     * Read an archetype, with a locally created error listener and a linenumber offset
     * @param textStream source text
     */
    public void read (CharStream textStream, String tag, int lineOffset) {
        // set up error listener
        errors = new ANTLRParserErrors ();
        CommonErrorListener errorListener = new CommonErrorListener(errors, tag, lineOffset);
        errorListener.setLogEnabled (logging);

        // Create lexer and parser
        createLexerParser (textStream) ;

        // hook up error listeners
        if (!keepAntlrErrors)
            lexer.removeErrorListeners();
        lexer.addErrorListener (errorListener);
        if (!keepAntlrErrors)
            parser.removeErrorListeners();
        parser.addErrorListener (errorListener);

        // do any specific processing of the parse result
        doParse (lineOffset);
    }

    // ---------------------- Access ----------------------

    public IANTLRParserErrors getErrors() {
        return errors;
    }

    // ---------------------- Implementation ----------------------

    // template routine for descendants to implement
    protected abstract void createLexerParser (CharStream textStream) ;

    // template routine for Parser-specific processing
    protected abstract void doParse (int lineOffset) ;

    // This error collector just records errors from one kind of syntax
    // i.e. of the current artefact. For Artefacts that can have their own
    // syntax, plus subordinate parts with other syntaxes, a multi-parser
    // error collector will additionally be needed.
    protected ANTLRParserErrors errors;

    protected final boolean logging;
    protected final boolean keepAntlrErrors;

    protected L lexer;
    protected P parser;
}
