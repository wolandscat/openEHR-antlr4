package org.openehr.aqlReader;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.antlr4.*;
import org.openehr.common.SyntaxReader;

public class AqlReader extends SyntaxReader<AqlLexer, AqlParser> {

    // ---------------------- Creation ----------------------

    public AqlReader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Implementation ----------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new AqlLexer (stream);
        parser = new AqlParser (new CommonTokenStream (lexer));
    }

    protected void doParse(int lineOffset) {
        AqlParser.AqlQueryContext aqlQuery = parser.aqlQuery();

        // don't bother with traversal if artefact not well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            AqlParserBaseListener reader =  new AqlParserBaseListener();
            walker.walk (reader, aqlQuery);
        }
    }

}
