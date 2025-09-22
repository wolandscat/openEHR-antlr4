package org.openehr.cadlReader;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr4.Cadl14Lexer;
import org.openehr.antlr4.Cadl14Parser;
import org.openehr.common.SyntaxReader;

public class Cadl14Reader extends SyntaxReader<Cadl14Lexer, Cadl14Parser> {

    // -------------- Creation ------------------

    public Cadl14Reader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Access ----------------------

    public IANTLRParserErrors getErrors() { return errorCollector; }

    // -------------- Implementation ------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new Cadl14Lexer (stream);
        parser = new Cadl14Parser (new CommonTokenStream (lexer));
    }

    protected void doParse(int lineOffset) {
        // set up the top-level Error collector that will collect
        // errors from subordinate parts, each with its own syntax
        errorCollector = new Cadl14ReaderErrorCollector();
        errorCollector.setCadlErrors (errors);

        // do the parse
        Cadl14Parser.CComplexObjectContext ccoObjectCtx = parser.cComplexObject();

        // don't bother with traversal if artefact not well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            Cadl14ReaderListener reader =  new Cadl14ReaderListener(logging, keepAntlrErrors, errorCollector, lineOffset);
            walker.walk (reader, ccoObjectCtx);
        }
    }
    private Cadl14ReaderErrorCollector errorCollector;

}
