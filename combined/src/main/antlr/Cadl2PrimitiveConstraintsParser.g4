//
// description: Antlr4 grammar for cADL primitives, used within Cadl grammar, but also by
//              other languages that allow constraints on primitive objects.
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

parser grammar Cadl2PrimitiveConstraintsParser;
options { tokenVocab=Cadl2PrimitiveConstraintsLexer; }
import PrimitiveValuesParser;

cInlinePrimitiveObject:
      cInlineOrderedObject
    | cString
    | cTerminologyCode
    | cBoolean
    ;

cInlineOrderedObject:
      cInteger
    | cReal
    | cInlineDTemporalObject
    ;

cInlineDTemporalObject:
      cDate
    | cTime
    | cDateTime
    | cDuration
    ;

// ------------ Primitive type constraints -------------

cBoolean: ( booleanValue | booleanValues ) assumedBooleanValue? ;
assumedBooleanValue: ';' booleanValue ;

cInteger: ( integerValue | integerValues | integerInterval | integerIntervals ) assumedIntegerValue? ;
assumedIntegerValue: ';' integerValue ;

cReal: ( realValue | realValues | realInterval | realIntervals ) assumedRealValue? ;
assumedRealValue: ';' realValue ;

cDateTime: ( DATE_TIME_CONSTRAINT_PATTERN | dateTimeValue | dateTimeValues | dateTimeInterval | dateTimeIntervals ) assumedDateTimeValue? ;
assumedDateTimeValue: ';' dateTimeValue ;

cDate: ( DATE_CONSTRAINT_PATTERN | dateValue | dateValues | dateInterval | dateIntervals ) assumedDateValue? ;
assumedDateValue: ';' dateValue ;

cTime: ( TIME_CONSTRAINT_PATTERN | timeValue | timeValues | timeInterval | timeIntervals ) assumedTimeValue? ;
assumedTimeValue: ';' timeValue ;

cDuration: ( DURATION_CONSTRAINT_PATTERN ( '/' ( durationInterval | durationValue ))?
    | durationValue | durationValues | durationInterval | durationIntervals ) assumedDurationValue?
    ;
assumedDurationValue: ';' durationValue ;

cString: ( stringValue | stringValues | DELIMITED_REGEX ) assumedStringValue? ;
assumedStringValue: ';' stringValue ;

// ADL2 term types: [ac3], [ac3; at5], [at5]
// NOTE: an assumed at-code (the ';' AT_CODE pattern) can only occur after an ac-code not after the single at-code
// TPFP: the 3rd branch using IDs should be removed; the first two patterns are correct
cTerminologyCode:
      '[' ( AC_CODE ( ';' AT_CODE )? | AT_CODE ) ']'
    | LOCAL_TERM_CODE_ID ( ';' LOCAL_TERM_CODE_ID )?
    | LOCAL_TERM_CODE_ID (',' LOCAL_TERM_CODE_ID)+
    ;
