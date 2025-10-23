//
// Grammar defining compact terminal value types, including atoms, lists and intervals that
// may be used in ODIN but also other formalisms such as JSON (schema driven) and YAML.
// author:      Pieter Bos <pieter.bos@nedap.com>, Thomas Beale <thomas.beale@openEHR.org>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2018- openEHR Foundation <http://www.openEHR.org>
//

parser grammar PrimitiveValuesParser;
options { tokenVocab=PrimitiveValuesLexer; }

primitiveObject :
      primitiveList
    | primitiveArray
    | primitiveSet
    | primitiveInterval
    | primitiveValue
    ;

primitiveValue :
      stringValue
    | integerValue
    | realValue
    | booleanValue
    | characterValue
    | termCodeValue
    | dateValue
    | timeValue
    | dateTimeValue
    | durationValue
    ;

primitiveList: '(' primitiveValues ')' ;

primitiveArray: '[' primitiveValues ']' ;

primitiveSet: '{' primitiveValues '}' ;

primitiveValues :
      stringValues
    | integerValues
    | realValues
    | booleanValues
    | characterValues
    | termCodeListValue
    | dateValues
    | timeValues
    | dateTimeValues
    | durationValues
    ;

primitiveInterval:
      integerInterval
    | realInterval
    | dateInterval
    | timeInterval
    | dateTimeInterval
    | durationInterval
    ;

stringValue : STRING ;
stringValues : stringValue ( ',' stringValue )* ;

integerValue : ( SYM_PLUS | SYM_MINUS )? ( INTEGER | SCI_INTEGER ) ;
integerValues : integerValue ( ',' integerValue )* ;
integerInterval : '|' integerIntervalRange '|' ;
integerIntervalRange :
      SYM_GT? integerValue '..' SYM_LT? integerValue
    | relop? integerValue
    | integerValue SYM_PLUS_OR_MINUS integerValue
    ;
integerIntervals : integerInterval ( ',' integerInterval )* ;

realValue : ( SYM_PLUS | SYM_MINUS )? ( REAL | SCI_REAL | REAL_PERCENT ) ;
realValues : realValue ( ',' realValue )* ;
realInterval : '|' realIntervalRange '|' ;
realIntervalRange :
      SYM_GT? realValue '..' SYM_LT? realValue
    | relop? realValue
    | realValue SYM_PLUS_OR_MINUS realValue
    ;
realIntervals : realInterval ( ',' realInterval )* ;

booleanValue : SYM_TRUE | SYM_FALSE ;
booleanValues : booleanValue ( ',' booleanValue )* ;

characterValue : CHARACTER ;
characterValues : characterValue ( ',' characterValue )* ;

dateValue : ISO8601_DATE_AUGMENTED ;
dateValues : dateValue ( ',' dateValue )* ;
dateInterval : '|' dateIntervalRange '|' ;
dateIntervalRange :
      SYM_GT? dateValue '..' SYM_LT? dateValue
    | relop? dateValue
    | dateValue SYM_PLUS_OR_MINUS durationValue
    ;
dateIntervals : dateInterval ( ',' dateInterval )* ;

timeValue : ISO8601_TIME_AUGMENTED ;
timeValues : timeValue ( ',' timeValue )* ;
timeInterval : '|' timeIntervalRange '|' ;
timeIntervalRange :
      SYM_GT? timeValue '..' SYM_LT? timeValue
    | relop? timeValue
    | timeValue SYM_PLUS_OR_MINUS durationValue
    ;
timeIntervals : timeInterval ( ',' timeInterval )* ;

dateTimeValue : ISO8601_DATE_TIME_AUGMENTED ;
dateTimeValues : dateTimeValue ( ',' dateTimeValue )* ;
dateTimeInterval : '|' dateTimeIntervalRange '|' ;
dateTimeIntervalRange :
      SYM_GT? dateTimeValue '..' SYM_LT? dateTimeValue
    | relop? dateTimeValue
    | dateTimeValue SYM_PLUS_OR_MINUS durationValue
    ;
dateTimeIntervals : dateTimeInterval ( ',' dateTimeInterval )* ;

durationValue : ( SYM_PLUS | SYM_MINUS )? ISO8601_DURATION ;
durationValues : durationValue ( ',' durationValue )* ;
durationInterval : '|' durationIntervalRange '|' ;
durationIntervalRange :
      SYM_GT? durationValue '..' SYM_LT? durationValue
    | relop? durationValue
    | durationValue SYM_PLUS_OR_MINUS durationValue
    ;
durationIntervals : durationInterval ( ',' durationInterval )* ;

// new style term codes of form #xxxxx, #terminology_id::code
termCodeValue : QUALIFIED_TERM_CODE_ID | LOCAL_TERM_CODE_ID ;
termCodeListValue : termCodeValue ( ',' termCodeValue )* ;

relop : SYM_LE | SYM_GE | SYM_GT | SYM_LT ;

