package org.openehr.belReader;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.reader_common.BelLexer;
import org.openehr.reader_common.BelParser;
import org.openehr.reader_common.BelParserBaseListener;
import org.openehr.common.SyntaxReader;

public class BelReader extends SyntaxReader<BelLexer, BelParser> {

    // ---------------------- Creation ----------------------

    public BelReader(boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // ---------------------- Implementation ----------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new BelLexer (stream);
        parser = new BelParser (new CommonTokenStream (lexer));
    }

    protected void doParse(int lineOffset) {
        BelParser.StatementBlockContext stmtBlock = parser.statementBlock();

        // don't bother with traversal if artefact not well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            BelParserBaseListener reader =  new BelParserBaseListener();
            walker.walk (reader, stmtBlock);
        }
    }

}
