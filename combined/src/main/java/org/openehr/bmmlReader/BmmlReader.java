package org.openehr.bmmlReader;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.antlr4.*;
import org.openehr.common.SyntaxReader;

public class BmmlReader extends SyntaxReader<BmmlLexer, BmmlParser> {

    // ---------------------- Creation ----------------------

    public BmmlReader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Implementation ----------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new BmmlLexer (stream);
        parser = new BmmlParser (new CommonTokenStream (lexer));
    }

    protected void doParse(int lineOffset) {
        BmmlParser.BmmModuleDefContext moduleDef = parser.bmmModuleDef() ;

        // don't bother with traversal if artefact not well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            BmmlParserBaseListener reader =  new BmmlParserBaseListener();
            walker.walk (reader, moduleDef);
        }
    }

}
