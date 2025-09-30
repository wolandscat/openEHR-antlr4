//
// description: Antlr4 grammar for cADL primitives, used within Cadl grammar, but also by
//              other languages that allow constraints on primitive objects. This has to include
//              other relevant Lexer grammars in the correct order, in order to generate a
//              correct total tokens file for use by the parser grammar.
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar Cadl2PrimitiveConstraintsLexer;
import OpenehrIdsLexer, PrimitiveValuesLexer;

// ---------- ISO8601-based date/time/duration constraint patterns

DATE_CONSTRAINT_PATTERN      : YEAR_PATTERN '-' MONTH_PATTERN '-' DAY_PATTERN ;
TIME_CONSTRAINT_PATTERN      : HOUR_PATTERN ':' MINUTE_PATTERN ':' SECOND_PATTERN TZ_PATTERN? ;
DATE_TIME_CONSTRAINT_PATTERN : DATE_CONSTRAINT_PATTERN 'T' TIME_CONSTRAINT_PATTERN ;

fragment YEAR_PATTERN   : 'yyyy' | 'YYYY' | 'yyy' | 'YYY' ;
fragment MONTH_PATTERN  : 'mm' | 'MM' | '??' | 'XX' | 'xx' ;
fragment DAY_PATTERN    : 'dd' | 'DD' | '??' | 'XX' | 'xx'  ;
fragment HOUR_PATTERN   : 'hh' | 'HH' | '??' | 'XX' | 'xx'  ;
fragment MINUTE_PATTERN : 'mm' | 'MM' | '??' | 'XX' | 'xx'  ;
fragment SECOND_PATTERN : 'ss' | 'SS' | '??' | 'XX' | 'xx'  ;
fragment TZ_PATTERN     : '±' ('hh' | 'HH') (':'? ('mm' | 'MM'))? | 'Z' ;

DURATION_CONSTRAINT_PATTERN  : 'P' [yY]?[mM]?[Ww]?[dD]? ( 'T' [hH]?[mM]?[sS]? )? ;

// ---------- Delimited Regex matcher ------------
// This matches a regex and performs a small trick by matching
// the surrounding {} as well, which is the only context in
// which regexes are allowed. It thus matches the combination
// of the '{' and either the '/' or '^', and similarly at the
// end, but in both cases returns only the '{' or '} tokens.
// Then it matches what's inside the '{/' or '{^' delimiters
// and adds back in the required '/' or '^' characters, to
// reproduce the slash- or caret-delimited regex string as
// expected by later processing. This trick enables regexes
// to be recognised only within {}, but handled by the parser
// as if they were matched separately from the {}.
REGEX_START_CARET: '{^' -> type (SYM_LCURLY), mode(REGEX_CARET);
REGEX_START_SLASH: '{/' -> type (SYM_LCURLY), mode(REGEX_SLASH);

mode REGEX_CARET;
REGEX_END_CARET: '^}' -> type (SYM_RCURLY), mode(DEFAULT_MODE);
REGEX_SEMI_CARET: '^;' -> type (SYM_SEMI_COLON), mode(DEFAULT_MODE);
DELIMITED_REGEX: CARET_REGEX_CHAR+ { setText ("^" + getText() + "^"); } ;
fragment CARET_REGEX_CHAR: ESCAPE_SEQ | '\\^' | ~[^\n\r] ;

mode REGEX_SLASH;
REGEX_END_SLASH: '/}' -> type (SYM_RCURLY), mode(DEFAULT_MODE);
REGEX_SEMI_SLASH: '/;' -> type (SYM_SEMI_COLON), mode(DEFAULT_MODE);
DELIMITED_REGEX_SLASH: SLASH_REGEX_CHAR+ { setText ("/" + getText() + "/"); } -> type (DELIMITED_REGEX) ;
fragment SLASH_REGEX_CHAR: ESCAPE_SEQ | '\\/' | ~[/\n\r] ;
