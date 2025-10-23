//
// description: Antlr4 grammar for cADL primitives, used within Cadl1.4 grammar, but also by
//              other languages that allow constraints on primitive objects. This has to include
//              other relevant Lexer grammars in the correct order, in order to generate a
//              correct total tokens file for use by the parser grammar.
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar Cadl14PrimitiveConstraintsLexer;
import Cadl2PrimitiveConstraintsLexer, OpenehrIdsLexer, GeneralIdsLexer;

channels {
    COMMENT
}

// -------------------- ADL14-specific constraint Patterns ------------------------

//
// Look for:
// internal terminology constrainer
// 		[local::
//		at0003, 	-- Date ordered/recommended
//		at0004, 	-- Date first prescription issued
//		at0005, 	-- Date last prescription issued
//		at0020]	-- Date changed
//
// An empty constrainer is allowed, e.g. '[local::]'
//
C_LOCAL_TERM_CODE_START: '[' WS? 'local' WS? '::' WS? EOL? -> mode (C_LOCAL_TERM_CODE);

//
// external terminology constrainer
// 		[openehr::
//		22,
//		34,
//		35]
//
// An empty constrainer is allowed, e.g. '[openehr::]'
//
C_EXTERNAL_TERM_CODE_START: '[' WS? TERM_CODE_STRING WS? '::' WS? EOL? -> mode (C_EXTERNAL_TERM_CODE);
fragment TERM_CODE_STRING: TERM_CODE_CHAR+ ;
EOL     : '\r'? '\n'   -> channel(HIDDEN) ;

mode C_LOCAL_TERM_CODE ;
C_TERM_CODE_END: SYM_RBRACKET -> mode (DEFAULT_MODE), type(SYM_RBRACKET) ;
ADL14_AT_CODE_L: ADL14_AT_CODE -> type (ADL14_AT_CODE) ;
AT_CODE_L: AT_CODE -> type (AT_CODE) ;
COMMA_L: SYM_COMMA  -> type (SYM_COMMA) ;
SEMI_COLON_L: SYM_SEMI_COLON -> type(SYM_SEMI_COLON) ;
CMT_LINE_L: '--' .*? EOL -> channel(COMMENT) ;
EOL_L     : EOL  -> channel(HIDDEN) ;
WS_L      : WS -> channel(HIDDEN) ;

mode C_EXTERNAL_TERM_CODE ;
C_TERM_CODE_END_X: SYM_RBRACKET -> mode (DEFAULT_MODE), type(SYM_RBRACKET) ;
C_EXTERNAL_TERM_CODE_STRING: TERM_CODE_STRING ;
COMMA_X: SYM_COMMA -> type (SYM_COMMA) ;
SEMI_COLON_X: SYM_SEMI_COLON -> type(SYM_SEMI_COLON) ;
CMT_LINE_X: WS? '--' .*? EOL -> channel(COMMENT) ;
EOL_X     : EOL -> channel(HIDDEN) ;
WS_X      : WS -> channel(HIDDEN) ;
