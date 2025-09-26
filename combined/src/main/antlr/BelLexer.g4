//
//  description: Antlr4 grammar for 'old' openEHR Expression Language specified at
//               https://specifications.openehr.org/releases/BASE/Release-1.0.4/expression.html
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  contributors:Pieter Bos <pieter.bos@nedap.com>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2016- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar BelLexer;
import Cadl2PrimitiveValuesLexer, SymbolsLexer, GeneralIdsLexer;

channels {
    COMMENT
}

// ------------------ lines and comments ------------------
CMT_LINE : '--' .*? EOL -> channel(COMMENT) ;
EOL      : '\r'? '\n'   -> channel(HIDDEN) ;
WS       : [ \t\r]+     -> channel(HIDDEN) ;

// --------- symbols ----------
SYM_ASSIGNMENT: ':=' | '::=' ;

SYM_THEN     : 'then' | 'THEN' ;
SYM_AND      : 'and' | 'AND' | '∧' ;
SYM_OR       : 'or' | 'OR' | '∨' ;
SYM_XOR      : 'xor' | 'XOR' ;
SYM_NOT      : 'not' | 'NOT' | '!' | '~' | '¬' ;
SYM_IMPLIES  : 'implies' | 'IMPLIES' | '⇒' ;
SYM_FOR_ALL  : 'for_all' | '∀' ;
SYM_THERE_EXISTS: 'there_exists' | '∃' ;
SYM_EXISTS   : 'exists' ;
SYM_MATCHES  : 'matches' | 'is_in' | '∈' ;

// TODO: remove when [] path predicates supported
SYM_IN: 'in' ;

VARIABLE_ID: '$' LC_ID ;
