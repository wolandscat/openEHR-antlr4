//
// description: Antlr4 grammar for consuming Object Data Instance Notation (ODIN) text
//              for proper parsing later
// author:      Thomas Beale <thomas.beale@openehr.org>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2021- openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

grammar Odin;
import PrimitiveValues;

//
// -------------------------- Parse Rules --------------------------
//

odinObject :
      odinAttrVals
    | odinObjectValueBlock
    ;

odinAttrVals : ( odinAttrVal ';'? )+ ;

odinAttrVal : odinKey '=' odinObjectBlock ;

odinKey : ALPHA_UC_ID | ALPHA_UNDERSCORE_ID | rmAttributeId ;

odinObjectBlock :
      odinObjectValueBlock
    | odinObjectReferenceBlock
    ;

odinObjectValueBlock : ( '(' rmTypeId ')' )? '<' ( primitiveObject | odinAttrVals? | odinKeyedObject* ) '>' ;

odinKeyedObject : '[' primitiveValue ']' '=' odinObjectBlock ;

// ----------------- references ------------------

odinObjectReferenceBlock : '<' odinPathList '>' ;

odinPathList : path ( ( ',' path )+ | SYM_LIST_CONTINUE )? ;
path         : pathSegment? ( '/' pathSegment? )+ ;
pathSegment : ALPHA_LC_ID ('[' .*? ']')? ;

// ---------------- model references --------------
rmTypeId      : ALPHA_UC_ID ( '<' rmTypeId ( ',' rmTypeId )* '>' )? ;
rmAttributeId : ALPHA_LC_ID ;

// ------------------- leaf types -----------------

primitiveObject :
      primitiveValue
    | primitiveListValue
    | primitiveIntervalValue
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
    | uriValue
    ;

primitiveListValue :
      stringListValue
    | integerListValue
    | realListValue
    | booleanListValue
    | characterListValue
    | termCodeListValue
    | dateListValue
    | timeListValue
    | dateTimeListValue
    | durationListValue
    ;

primitiveIntervalValue :
      integerIntervalValue
    | realIntervalValue
    | dateIntervalValue
    | timeIntervalValue
    | dateTimeIntervalValue
    | durationIntervalValue
    ;

//
// -------------- lexer rules ---------------
//

// ---------- lines and comments ----------
CMT_LINE   : '--' .*? EOL -> skip ;             // increment line count
EOL        : '\r'? '\n'   -> channel(HIDDEN) ;  // increment line count
WS         : [ \t\r]+     -> channel(HIDDEN) ;