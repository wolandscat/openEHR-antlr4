//
//  General purpose patterns used in all openEHR parser and lexer tools
//  author:      Pieter Bos <pieter.bos@nedap.com>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2018- openEHR Foundation <http://www.openEHR.org>
//

lexer grammar PrimitiveTypesLexer;

// ------------- openEHR Augmented ISO8601 Date/Time patterns -----------

ISO8601_DATE_AUGMENTED : ISO8601_DATE_EXTENDED | YEAR '-' MONTH '-' UNKNOWN_DT | YEAR '-' UNKNOWN_DT '-' UNKNOWN_DT ;
ISO8601_TIME_AUGMENTED : ISO8601_TIME_EXTENDED | (( HOUR ':' MINUTE ':' UNKNOWN_DT | HOUR ':' UNKNOWN_DT ':' UNKNOWN_DT ) TIMEZONE? );
ISO8601_DATE_TIME_AUGMENTED : ISO8601_DATE_TIME_EXTENDED | (( YEAR '-' MONTH '-' DAY 'T' HOUR ':' MINUTE ':' UNKNOWN_DT | YEAR '-' MONTH '-' DAY 'T' HOUR ':' UNKNOWN_DT ':' UNKNOWN_DT ) TIMEZONE? ) ;
fragment UNKNOWN_DT  : '??' ;                    // any unknown date/time value, except years.

// -------------------- ISO8601 Date/Time patterns -------------------

fragment ISO8601_DATE_EXTENDED : YEAR '-' MONTH ( '-' DAY )? | YEAR '-' MONTH ;
fragment ISO8601_TIME_EXTENDED : HOUR ':' MINUTE ( ':' SECOND ( SECOND_DEC_SEP DIGIT+ )?)? TIMEZONE? ;
fragment ISO8601_DATE_TIME_EXTENDED : YEAR '-' MONTH '-' DAY 'T' HOUR (':' MINUTE (':' SECOND ( SECOND_DEC_SEP DIGIT+ )?)?)? TIMEZONE? ;
fragment ISO8601_DATE_COMPACT : YEAR MONTH DAY? ;
fragment ISO8601_TIME_COMPACT : HOUR MINUTE ( SECOND ( SECOND_DEC_SEP DIGIT+ )?)? TIMEZONE? ;
fragment ISO8601_DATE_TIME_COMPACT : YEAR MONTH DAY 'T' HOUR ( MINUTE (SECOND ( SECOND_DEC_SEP DIGIT+ )?)?)? TIMEZONE? ;
fragment TIMEZONE : 'Z' | ('+'|'-') HOUR_MIN ;   // hour offset, e.g. `+0930`, or else literal `Z` indicating +0000.
fragment YEAR     : [0-9][0-9][0-9][0-9] ;	     // Year in ISO8601:2004 is 4 digits with 0-filling as needed
fragment MONTH    : ( [0][1-9] | [1][0-2] ) ;    // month in year
fragment DAY      : ( [0][1-9] | [12][0-9] | [3][0-1] ) ;  // day in month
fragment HOUR     : ( [01]?[0-9] | [2][0-3] ) ;  // hour in 24 hour clock
fragment MINUTE   : [0-5][0-9] ;                 // minutes
fragment HOUR_MIN : ( [01]?[0-9] | [2][0-3] ) [0-5][0-9] ;  // hour / minutes quad digit pattern
fragment SECOND   : [0-5][0-9] ;                 // seconds
fragment SECOND_DEC_SEP : '.' | ',' ;

// ISO8601 DURATION PnYnMnWnDTnnHnnMnn.nnnS 
// here we allow a deviation from the standard to allow weeks to be // mixed in with the rest since this commonly occurs in medicine
// TODO: the following will incorrectly match just 'P'
ISO8601_DURATION : '-'?'P' (DIGIT+ [yY])? (DIGIT+ [mM])? (DIGIT+ [wW])? (DIGIT+[dD])? ('T' (DIGIT+[hH])? (DIGIT+[mM])? (DIGIT+ (SECOND_DEC_SEP DIGIT+)?[sS])?)? ;

// --------------------- URIs --------------------
// URI recogniser based on https://tools.ietf.org/html/rfc3986 and
// http://www.w3.org/Addressing/URL/5_URI_BNF.html
fragment URI : URI_SCHEME ':' URI_HIER_PART ( '?' URI_QUERY )? ('#' URI_FRAGMENT)? ;

fragment URI_HIER_PART :
      ( '//' URI_AUTHORITY ) URI_PATH_ABEMPTY
    | URI_PATH_ABSOLUTE
    | URI_PATH_ROOTLESS
    | URI_PATH_EMPTY
    ;

fragment URI_SCHEME : ALPHA_CHAR ( ALPHA_CHAR | DIGIT | '+' | '-' | '.')* ;

fragment URI_AUTHORITY : ( URI_USERINFO '@' )? URI_HOST ( ':' URI_PORT )? ;
fragment URI_USERINFO  : ( URI_UNRESERVED | URI_PCT_ENCODED | URI_SUB_DELIMS | ':' )* ;
fragment URI_HOST      : URI_IP_LITERAL | URI_IPV4_ADDRESS | URI_REG_NAME ; //TODO: ipv6
fragment URI_PORT      : DIGIT* ;

fragment URI_IP_LITERAL   : '[' URI_IPV6_LITERAL ']'; //TODO, if needed: IPvFuture
fragment URI_IPV4_ADDRESS : URI_DEC_OCTET '.' URI_DEC_OCTET '.' URI_DEC_OCTET '.' URI_DEC_OCTET ;
fragment URI_IPV6_LITERAL : HEX_QUAD (':' HEX_QUAD )* '::' HEX_QUAD (':' HEX_QUAD )* ;

fragment URI_DEC_OCTET : DIGIT | [1-9] DIGIT | '1' DIGIT DIGIT | '2' [0-4] DIGIT | '25' [0-5] ;
fragment URI_REG_NAME  : ( URI_UNRESERVED | URI_PCT_ENCODED | URI_SUB_DELIMS )* ;
fragment HEX_QUAD      : HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT ;

fragment URI_PATH_ABEMPTY  : ('/' URI_SEGMENT )* ;
fragment URI_PATH_ABSOLUTE : '/' ( URI_SEGMENT_NZ ( '/' URI_SEGMENT )* )? ;
fragment URI_PATH_NOSCHEME : URI_SEGMENT_NZ_NC ( '/' URI_SEGMENT )* ;
fragment URI_PATH_ROOTLESS : URI_SEGMENT_NZ ( '/' URI_SEGMENT )* ;
fragment URI_PATH_EMPTY    : ;

fragment URI_SEGMENT       : URI_PCHAR* ;
fragment URI_SEGMENT_NZ    : URI_PCHAR+ ;
fragment URI_SEGMENT_NZ_NC : ( URI_UNRESERVED | URI_PCT_ENCODED | URI_SUB_DELIMS | '@' )+ ; //non-zero-length segment without any colon ":"

fragment URI_PCHAR    : URI_UNRESERVED | URI_PCT_ENCODED | URI_SUB_DELIMS | ':' | '@' ;

//fragment URI_PATH   : '/' | ( '/' URI_XPALPHA+ )+ ('/')?;
fragment URI_QUERY    : ( URI_PCHAR | '/' | '?' )* ;
fragment URI_FRAGMENT : ( URI_PCHAR | '/' | '?' )* ;

fragment URI_PCT_ENCODED : '%' HEX_DIGIT HEX_DIGIT ;

fragment URI_UNRESERVED : ALPHA_CHAR | DIGIT | '-' | '.' | '_' | '~' ;
fragment URI_RESERVED   : URI_GEN_DELIMS | URI_SUB_DELIMS ;
fragment URI_GEN_DELIMS : [:/?#[\]@] ;
fragment URI_SUB_DELIMS : [!$&'()*+,;=] ;

// ------------------ special values --------------

SYM_TRUE  : [Tt][Rr][Uu][Ee] ;
SYM_FALSE : [Ff][Aa][Ll][Ss][Ee] ;

// ---------------------- machine identifiers --------------------------

GUID : HEX_DIGIT+ '-' HEX_DIGIT+ '-' HEX_DIGIT+ '-' HEX_DIGIT+ '-' HEX_DIGIT+ ;
UUID: GUID ;

// --------------------- atomic primitive types ----------------------

fragment NUMBER : '0' | [1-9][0-9]* ;

INTEGER     : DIGIT+ ; // TODO: allow leading zeros? Most langs don't...
REAL        : DIGIT+ '.' DIGIT+ ;
REAL_PERCENT: DIGIT+ ( '.' DIGIT+ )? '%' ;
SCI_INTEGER : INTEGER ( E_SUFFIX | P10_SUFFIX ) ;
SCI_REAL    : REAL ( E_SUFFIX | P10_SUFFIX ) ;
fragment E_SUFFIX : [eE][+-]? DIGIT+ ;
fragment P10_SUFFIX : [ ]* 'x' [ ]* '10' [ ]* '^' [ ]* DIGIT+ ;

STRING : '"' STRING_CHAR*? '"' ;
fragment STRING_CHAR : ~["\\] | ESCAPE_SEQ | UTF8CHAR ; // strings can be multi-line

CHARACTER : '\'' CHAR '\'' ;
fragment CHAR : ~['\\\r\n] | ESCAPE_SEQ | UTF8CHAR  ;

fragment ESCAPE_SEQ: '\\' ['"?abfnrtv\\] ;

// ------------------- character fragments ------------------

fragment ALPHANUM_US_HYP_CHAR : ALPHANUM_US_CHAR | '-' ;
fragment ALPHANUM_US_CHAR : ALPHANUM_CHAR | '_' ;
fragment ALPHANUM_CHAR : ALPHA_CHAR | DIGIT ;

fragment ALPHA_CHAR  : [a-zA-Z] ;
fragment ALPHA_UCHAR : [A-Z] ;
fragment ALPHA_LCHAR : [a-z] ;
fragment UTF8CHAR    : '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT ;

fragment DIGIT     : [0-9] ;
fragment HEX_DIGIT : [0-9a-fA-F] ;

fragment OCTAL_ESC: '\\' [0-3] OCTAL_DIGIT OCTAL_DIGIT | '\\' OCTAL_DIGIT OCTAL_DIGIT | '\\' OCTAL_DIGIT;
fragment OCTAL_DIGIT: [0-7];

