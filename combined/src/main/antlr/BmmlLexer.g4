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

lexer grammar BmmlLexer;
import ElLexer, BaseLexer, GeneralLexer;

channels {
    COMMENT
}

// ------------------ lines and comments ------------------
CMT_LINE : '--' .*? EOL -> channel(COMMENT) ;
EOL      : '\r'? '\n'   -> skip ;
WS       : [ \t\r]+     -> skip ;

// ----------------------- keywords -----------------------
SYM_CLASS     : 'class' ;
SYM_ABSTRACT  : 'abstract' ;
SYM_INHERIT   : 'is_a' ;
SYM_CONSTANT  : 'constant' ;
SYM_PROPERTY  : 'property' ;
SYM_FUNCTION  : 'func' ;
SYM_PROCEDURE : 'proc' ;
SYM_FEATURE_GROUP : 'feature_group' ;
SYM_INVARIANT: 'invariant';

// --------- symbols ----------
SYM_ZERO: '0' ;
SYM_ONE: '1' ;
SYM_NULLABLE_TYPE_DECL: ':?' ;

//SYM_ASSIGNMENT: ':=' ;
//SYM_COLON : ':' ;
//SYM_GT : '>' ;
//SYM_LT : '<' ;
//SYM_COMMA: ',' ;
