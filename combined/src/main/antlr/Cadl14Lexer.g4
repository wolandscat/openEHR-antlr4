//
// description: Antlr4 grammar for cADL non-primitves sub-syntax of Archetype Definition Language (ADL2).
//              This has to include
//              other relevant Lexer grammars in the correct order, in order to generate a
//              correct total tokens file for use by the parser grammar.
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar Cadl14Lexer;
import OpenehrIdsLexer, Cadl14PrimitiveValuesLexer, OdinLexer, GeneralIdsLexer;

channels {
    COMMENT
}

// ------------------ lines and comments ------------------
CMT_LINE : '--' .*? EOL -> channel(COMMENT) ;
EOL      : '\r'? '\n'   -> channel(HIDDEN) ;
WS       : [ \t\r]+     -> channel(HIDDEN) ;

// ----------------------- keywords -----------------------
SYM_EXISTENCE   : 'existence' ;
SYM_OCCURRENCES : 'occurrences' ;
SYM_CARDINALITY : 'cardinality' ;
SYM_ORDERED     : 'ordered' ;
SYM_UNORDERED   : 'unordered' ;
SYM_UNIQUE      : 'unique' ;
SYM_USE_NODE    : 'use_node' ;
SYM_USE_ARCHETYPE : 'use_archetype' ;
SYM_ALLOW_ARCHETYPE : 'allow_archetype' ;
SYM_INCLUDE     : 'include' ;
SYM_EXCLUDE     : 'exclude' ;
SYM_CLOSED      : 'closed' ;

// --------------------- general symbols ------------------------
SYM_MATCHES  : 'matches' | 'is_in' | '∈' ;

// ----------------------- embedded ODIN blocks --------------------------
// ODIN_BLOCK_START matches the first line below, then the ODIN_BLOCK mode gets the rest
//      TYPE <
//          odin lines
//      >
//
// Below, we rewrite the archaic form 'TYPE <' to legal ODIN '(TYPE) <'
ODIN14_BLOCK_START : UC_ID WS? '<' WS? EOL
    {
        String origText = getText();
        String typeId = origText.substring (0, origText.indexOf("<")-1);
        typeId.trim();
        setText ("(" + typeId + ") <");
    }
    -> mode (ODIN14_BLOCK) ;

//
// The end of an ODIN block is a bit tricky - because '>' occurs numerous times
// -> have to spot either:
//      following '}', and return the usual token (SYM_RCURLY)
//          in this case, we rewrite the matched text to just the symbol.
//      following UC_ID Ws etc, which means a sibling cADL block
//          here, we return the UC_ID and return to normal parsing
//
mode ODIN14_BLOCK ;
ODIN14_BLOCK_POST  : WS '}' WS? EOL { setText ("}"); } -> mode (DEFAULT_MODE), type (SYM_RCURLY) ;
ODIN14_BLOCK_POST2 : WS UC_ID { setText (getText().trim()); } -> mode (DEFAULT_MODE), type (UC_ID) ;
ODIN14_BLOCK_LINE  : WS LC_ID WS NON_EOL+ EOL ;                             // ODIN lines commencing with 'attr_name'
ODIN14_BLOCK_LINE2 : WS [<[] WS? NON_EOL+ EOL -> type (ODIN14_BLOCK_LINE) ; // ODIN lines commencing with '<' or '['
ODIN14_BLOCK_LINE3 : WS '>' WS? EOL -> type (ODIN14_BLOCK_LINE) ;           // ODIN lines with only '>'
WS_ODIN: WS EOL  -> channel(HIDDEN) ;
fragment NON_EOL : ~'\n' ;
