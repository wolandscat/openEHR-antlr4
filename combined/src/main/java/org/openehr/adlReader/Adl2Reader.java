package org.openehr.adlReader;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr4.*;
import org.openehr.common.SyntaxReader;

public class Adl2Reader extends SyntaxReader<Adl2Lexer, Adl2Parser> {

    // ---------------------- Creation ----------------------

    public Adl2Reader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Access ----------------------

    public IANTLRParserErrors getErrors() {
        return errorCollector;
    }

    // ---------------------- Implementation ----------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new Adl2Lexer (stream);
        parser = new Adl2Parser (new CommonTokenStream (lexer));
    }

    protected void doParse (int lineOffset) {
        // set up the top-level Error collector that will collect
        // errors from subordinate parts, each with its own syntax
        errorCollector = new Adl2ReaderErrorCollector();
        errorCollector.setAdlErrors (errors);

        // do the parse
        Adl2Parser.AdlObjectContext adlObjectCtx = parser.adlObject();

        // perform second level parsing if artefact well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            Adl2ReaderListener reader =  new Adl2ReaderListener (logging, keepAntlrErrors, errorCollector, lineOffset);
            walker.walk (reader, adlObjectCtx);
        }
    }

    private Adl2ReaderErrorCollector errorCollector;
}
