package org.openehr.cadlReader;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr4.*;
import org.openehr.common.SyntaxReader;

public class Cadl2Reader extends SyntaxReader<Cadl2Lexer, Cadl2Parser> {

    // -------------- Creation ------------------

    public Cadl2Reader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Access ----------------------

    public IANTLRParserErrors getErrors() {
        return errorCollector;
    }

    // -------------- Implementation ------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new Cadl2Lexer (stream);
        parser = new Cadl2Parser (new CommonTokenStream (lexer));
    }

    protected void doParse (int lineOffset) {
        // set up the top-level Error collector that will collect
        // errors from subordinate parts, each with its own syntax
        errorCollector = new Cadl2ReaderErrorCollector();
        errorCollector.setCadlErrors (errors);

        // do the parse
        Cadl2Parser.CComplexObjectContext ccoObjectCtx = parser.cComplexObject();

        // traverse if artefact well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            Cadl2ReaderListener reader =  new Cadl2ReaderListener (logging, keepAntlrErrors, errorCollector, lineOffset);
            walker.walk (reader, ccoObjectCtx);
        }
    }

    private Cadl2ReaderErrorCollector errorCollector;
}
