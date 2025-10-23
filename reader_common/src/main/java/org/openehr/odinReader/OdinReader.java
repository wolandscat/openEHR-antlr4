package org.openehr.odinReader;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.openehr.reader_common.*;
import org.openehr.common.SyntaxReader;

public class OdinReader extends SyntaxReader<OdinLexer, OdinParser> {

    // -------------- Creation ------------------

    public OdinReader (boolean logging, boolean keepAntlrErrors) {
        super (logging, keepAntlrErrors);
    }

    // -------------- Implementation ------------------

    protected void createLexerParser (CharStream stream) {
        lexer = new OdinLexer(stream);
        parser = new OdinParser(new CommonTokenStream (lexer));
    }

    protected void doParse(int lineOffset) {
        OdinParser.OdinObjectContext odinObjectCtx = parser.odinObject();

        // don't bother with traversal if artefact not well-formed
        if (errors.hasNoErrors()) {
            ParseTreeWalker walker = new ParseTreeWalker();
            OdinParserBaseListener reader =  new OdinParserBaseListener();
            walker.walk (reader, odinObjectCtx);
        }
    }
}
