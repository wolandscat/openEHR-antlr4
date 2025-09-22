
//
// Grammar defining compact terminal value types, including atoms, lists and intervals that
// may be used in ODIN but also other formalisms such as JSON (schema driven) and YAML.
// author:      Pieter Bos <pieter.bos@nedap.com>, Thomas Beale <thomas.beale@openEHR.org>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2018- openEHR Foundation <http://www.openEHR.org>
//

lexer grammar OdinValuesLexer;
import OpenehrPatterns;

// ------ get rid of whitespace inside lists and intervals ------
WS : [ \t\r]+     -> channel(HIDDEN) ;

// -------------------- general symbols ------------------------
SYM_NAMESPACE_SEP: '::' ;

// -------------------- symbols for lists ------------------------
SYM_LIST_CONTINUE : '...' ;
SYM_COMMA : ',' ;

// ------------------ symbols for intervals ----------------------

SYM_LE : '<=' | '≤' ;
SYM_GE : '>=' | '≥' ;
SYM_GT : '>' ;
SYM_LT : '<' ;
SYM_PLUS_OR_MINUS : '+/-' | '±' ;
SYM_PLUS    : '+' ;
SYM_MINUS   : '-' ;
SYM_PERCENT : '%' ;
SYM_CARET   : '^' ;

SYM_IVL_DELIM : '|' ;
SYM_IVL_SEP   : '..' ;
