//
//  description:  ANTLR4 lexer grammar for Archetype Query Language (AQL)
//                This version of the grammar is a complete rewrite of previously published antlr4 grammar
//  authors:      Thomas Beale, Ars Semantica UK, openEHR Foundation Management Board
//  contributors:
//  support:      openEHR Specifications PR tracker <https://specifications.openehr.org/releases/QUERY/open_issues>
//  copyright:    Copyright (c) 2021- openEHR Foundation
//  license:      Creative Commons CC-BY-SA <https://creativecommons.org/licenses/by-sa/3.0/>
//

lexer grammar AqlLexer;
import Cadl14Lexer, OpenehrIdsLexer, PrimitiveTypesLexer, AqlGeneral, GeneralIdsLexer;

channels {
    COMMENT
}

// SKIP
WS: [ \t\r\n]+ -> channel(HIDDEN);
UNICODE_BOM: (
      '\uEFBBBF' // UTF-8 BOM
    | '\uFEFF' // UTF16_BOM
    | '\u0000FEFF' // UTF32_BOM
    ) -> skip;
CMT_LINE   : '--' .*? EOL -> channel(COMMENT) ;
EOL        : '\r'? '\n'   -> channel(HIDDEN) ;

// Keywords
// Common Keywords
SYM_SELECT: 'SELECT' ;
SYM_AS: 'AS' | 'as' ;
SYM_FROM: 'FROM' ;
SYM_WHERE: 'WHERE' ;
SYM_ORDER: 'ORDER' ;
SYM_BY: 'BY' | 'by' ;
SYM_DESC: 'DESC' ;
SYM_DESCENDING: 'DESCENDING' ;
SYM_ASC: 'ASC' ;
SYM_ASCENDING: 'ASCENDING' ;
SYM_LIMIT: 'LIMIT' ;
SYM_OFFSET: 'OFFSET' ;

// other keywords
SYM_DISTINCT: 'DISTINCT' ;
SYM_VERSION : 'VERSION' ;
SYM_LATEST_VERSION : 'LATEST_VERSION' ;
SYM_ALL_VERSIONS : 'ALL_VERSIONS' ;
SYM_NULL: 'NULL' ;

// deprecated
SYM_TOP: 'TOP' ;
SYM_FORWARD: 'FORWARD' ;
SYM_BACKWARD: 'BACKWARD' ;

// Operators
// Containment operator
SYM_CONTAINS : 'CONTAINS' ;

// Logical operators
SYM_AND : 'AND' | 'and' ;
SYM_OR : 'OR' | 'or' ;
SYM_NOT : 'NOT' | 'not' ;
SYM_EXISTS: 'EXISTS' | 'exists' ;

// Comparison operators
SYM_LIKE: 'LIKE' | 'like' ;
SYM_MATCHES: 'matches' ;

// string functions
SYM_LENGTH: 'LENGTH' ;
SYM_POSITION: 'POSITION' ;
SYM_SUBSTRING: 'SUBSTRING' ;
SYM_CONCAT: 'CONCAT' ;
SYM_CONCAT_WS: 'CONCAT_WS' ;

// numeric functions
SYM_ABS: 'ABS' ;
SYM_MOD: 'MOD' ;
SYM_CEIL: 'CEIL' ;
SYM_FLOOR: 'FLOOR' ;
SYM_ROUND: 'ROUND' ;

// date and time functions
SYM_CURRENT_DATE: 'CURRENT_DATE' | 'current_date' ;
SYM_CURRENT_TIME: 'CURRENT_TIME' | 'current_time' ;
SYM_CURRENT_DATE_TIME: 'CURRENT_DATE_TIME'  | 'current_date_time' ;
SYM_NOW: 'NOW' ;
SYM_CURRENT_TIMEZONE: 'CURRENT_TIMEZONE' | 'current_timezone' ;

// aggregate function
SYM_COUNT: 'COUNT' | 'count' ;
SYM_MIN: 'MIN' | 'min' ;
SYM_MAX: 'MAX' | 'max' ;
SYM_SUM: 'SUM' | 'sum' ;
SYM_AVG: 'AVG' | 'avg' ;

// other functions
SYM_TERMINOLOGY: 'TERMINOLOGY' ;

//
//  ======================= Lexical rules ========================

// ---------- Delimited Regex matcher ------------

CONTAINED_REGEX: '{'WS* SLASH_REGEX WS* (';' WS* STRING)? WS* '}';
fragment SLASH_REGEX: '/' SLASH_REGEX_CHAR+ '/';
fragment SLASH_REGEX_CHAR: ~[/\n\r] | ESCAPE_SEQ | '\\/';

// --------------------- composed primitive types -------------------

AQL_URI: URI ;

// --------------------- atomic primitive types -------------------

BOOLEAN: SYM_TRUE | SYM_FALSE ;

DATE_STRING
    : '\'' DATE_VALUE '\''
    | '"' DATE_VALUE '"'
    ;
fragment DATE_VALUE: ISO8601_DATE_EXTENDED | ISO8601_DATE_COMPACT ;

TIME_STRING
    : '\'' TIME_VALUE '\''
    | '"' TIME_VALUE '"'
    ;
fragment TIME_VALUE: ISO8601_TIME_EXTENDED | ISO8601_TIME_COMPACT ;

DATE_TIME_STRING
    : '\'' DATE_TIME_VALUE '\''
    | '"' DATE_TIME_VALUE '"'
    ;
fragment DATE_TIME_VALUE: ISO8601_DATE_TIME_EXTENDED | ISO8601_DATE_TIME_COMPACT ;

STRING
    : '\'' ( ESCAPE_SEQ | UTF8CHAR | OCTAL_ESC | ~('\\'|'\'') )* '\''
    | '"' ( ESCAPE_SEQ | UTF8CHAR | OCTAL_ESC | ~('\\'|'"') )* '"'
    ;

QUALIFIED_TERM_CODE: COMPACT_QUALIFIED_TERM_CODE;

// ---------- symbols ----------

SYM_NE : '/=' | '!=' | '≠' ;
SYM_EQ : '=' ;

SYM_DOUBLE_DASH: '--';

fragment SYM_SINGLE_QUOTE: '\'';
fragment SYM_DOUBLE_QUOTE: '"';

// ------------------- Fragment letters ---------------------
fragment A: [aA];
fragment B: [bB];
fragment C: [cC];
fragment D: [dD];
fragment E: [eE];
fragment F: [fF];
fragment G: [gG];
fragment H: [hH];
fragment I: [iI];
fragment J: [jJ];
fragment K: [kK];
fragment L: [lL];
fragment M: [mM];
fragment N: [nN];
fragment O: [oO];
fragment P: [pP];
fragment Q: [qQ];
fragment R: [rR];
fragment S: [sS];
fragment T: [tT];
fragment U: [uU];
fragment V: [vV];
fragment W: [wW];
fragment X: [xX];
fragment Y: [yY];
fragment Z: [zZ];
