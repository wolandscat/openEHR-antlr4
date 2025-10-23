//
// description: Antlr4 grammar for cADL primitives, used within Cadl grammar, but also by
//              other languages that allow constraints on primitive objects.
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

parser grammar Cadl14PrimitiveConstraintsParser;
options { tokenVocab=Cadl14PrimitiveConstraintsLexer; }
import Cadl2PrimitiveConstraintsParser;

// ------------------------- C_TERMINOLOGY_CODE ---------------------------

cTerminologyCode:
      terminologyLocalCode
    | valueSetCode
    | cLocalTermCode
    | cExternalTermCode
    | QUALIFIED_TERM_CODE_REF
    ;

// match a single at-code
// e.g. [at0013]
terminologyLocalCode: '[' adl14_at_code ']' ;

// match a value-set ac-code with optional default
// e.g. [ac4] or [ac4; at0012]
valueSetCode: '[' adl14_ac_code termCodeDefault? ']' ;
termCodeDefault: ';' adl14_at_code ;

// match using an inline value-set matcher for the following structure
// 	[local::
//	    at0021, 	-- Active
//  	at0022, 	-- Stopped
//		at0023, 	-- Never active
//		at0024, 	-- Completed
//		at0025, 	-- Obsolete
//		at0026, 	-- Suspended
//		at0027]	-- Draft
cLocalTermCode: C_LOCAL_TERM_CODE_START ( localCodesList termCodeDefault? )? ']' ;
localCodesList: adl14_at_code termCodeItem+ ;
termCodeItem: ',' adl14_at_code ;

// Following is same as above, but with external terminology id and codes,
// e.g. openehr or SNOMED CT; have to allow for
cExternalTermCode: C_EXTERNAL_TERM_CODE_START ( externalCodesList externalTermCodeDefault? )? ']' ;
externalCodesList: C_EXTERNAL_TERM_CODE_STRING externalTermCodeItem+ ;
externalTermCodeItem: ',' C_EXTERNAL_TERM_CODE_STRING ;
externalTermCodeDefault: ';' C_EXTERNAL_TERM_CODE_STRING ;

// handle the ADL14 non-systematic codes like at0004 as well as at0.1
adl14_at_code: ADL14_AT_CODE | AT_CODE ;
adl14_ac_code: ADL14_AC_CODE | AC_CODE ;
