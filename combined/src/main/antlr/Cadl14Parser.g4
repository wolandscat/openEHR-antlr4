//
// description: Antlr4 grammar for cADL non-primitves sub-syntax of Archetype Definition Language (ADL2)
// author:      Thomas Beale <thomas.beale@openehr.org>
// contributors:Pieter Bos <pieter.bos@nedap.com>
// support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
// copyright:   Copyright (c) 2015 openEHR Foundation <http://www.openEHR.org>
// license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

parser grammar Cadl14Parser;
options { tokenVocab=Cadl14Lexer; }
import Cadl14PrimitiveConstraintsParser, AdlPathParser, OdinParser;

//
//  ======================= Top-level Objects ========================
//

cComplexObject: rmTypeId nodeId? cOccurrences? ( SYM_MATCHES '{' cComplexObjectDef '}' )? ;

cComplexObjectDef: cAttribute+ | '*' ;

nodeId: '[' adl14_at_code ']' ;

// ------------------- Complex constraint types ----------------------

cAttribute: rmAttributeId cExistence? cCardinality? ( SYM_MATCHES '{' ( cAttributeDef | cInlinePrimitiveObject ) '}' )? ;

cAttributeDef: cRegularObject+ ;

cRegularObject:
      cComplexObject
    | cArchetypeRoot
    | cComplexObjectProxy
    | archetypeSlot
    | cRegularPrimitiveObject
    | cOrdinal
    | domainSpecificExtension
    ;

cArchetypeRoot: SYM_USE_ARCHETYPE rmTypeId '[' adl14_at_code ',' ARCHETYPE_REF ']' cOccurrences? ;

cComplexObjectProxy: SYM_USE_NODE rmTypeId cOccurrences? adlPath ;

cRegularPrimitiveObject: rmTypeId nodeId cOccurrences? ( SYM_MATCHES '{' cInlinePrimitiveObject '}' )? ;

// Slot includes are modelled to support only the simple form of
// path matches {regex}, but this is probably safe. If not, the
// 'assertion' rule from EL is required, which causes the whole EL
// to be sucked in to CADL.
archetypeSlot: SYM_ALLOW_ARCHETYPE rmTypeId nodeId (( cOccurrences? ( SYM_MATCHES '{' cIncludes? cExcludes? '}' )? ) | SYM_CLOSED ) ;
cIncludes : SYM_INCLUDE archetypeIdConstraint+ ;
cExcludes : SYM_EXCLUDE archetypeIdConstraint+ ;
archetypeIdConstraint: archetypeIdPath SYM_MATCHES '{' DELIMITED_REGEX '}' ;

// have to allow for relative paths. Note the path here is not an adlPath
// (which is a path in the Cadl definition part); it is a path in the
// ARCHETYPE runtime instance
archetypeIdPath : '/'? LC_ID adlPath* ;

// ------------------- existence and cardinality -----------------------
cExistence   : SYM_EXISTENCE SYM_MATCHES '{' existence '}' ;
existence    : INTEGER | INTEGER '..' INTEGER ;

cCardinality : SYM_CARDINALITY SYM_MATCHES '{' cardinality '}' ;
cardinality  : multiplicity ( multiplicityMod multiplicityMod? )? ; // max of two

cOccurrences : SYM_OCCURRENCES SYM_MATCHES '{' multiplicity '}' ;

multiplicity : INTEGER | '*' | INTEGER '..' ( INTEGER | '*' ) ;
multiplicityMod : orderingMod | uniqueMod ;
orderingMod  : ';' ( SYM_ORDERED | SYM_UNORDERED ) ;
uniqueMod    : ';' SYM_UNIQUE ;

// ------------------------- ADL 1.4 C_ORDINAL ---------------------------

cOrdinal: ordinalTerm  ( ',' ordinalTerm )* ( ';' ordinalValue )?;

ordinalValue: integerValue | realValue ;

ordinalTerm: ordinalValue '|' cTerminologyCode ;

// ------------------- ADL 1.4 domain specific extensions ---------------------
// matches:
//      TYPE <
//          odin lines
//      >
//
domainSpecificExtension:  ODIN14_BLOCK_START ODIN14_BLOCK_LINE+ ;

// ------------------------- model references -------------------------
rmTypeId      : UC_ID ( '<' rmTypeId ( ',' rmTypeId )* '>' )? ;
rmAttributeId : LC_ID ;

// ==================== Query Matcher top-level object =====================

//
// this will match a flattened ADL-based structure, normally occurring
// within {} provided by the source context, e.g. an AQL query
//
cObjectMatcher: cComplexObjectMatcher | cInlinePrimitiveObject | domainSpecificExtension ;

cComplexObjectMatcher: rmTypeId nodeId? ( SYM_MATCHES '{' cComplexObjectMatcherDef '}' )? ;

cComplexObjectMatcherDef: cAttributeMatcher+ | '*' ;

cAttributeMatcher: rmAttributeId ( SYM_MATCHES '{' ( cAttributeMatcherDef | cInlinePrimitiveObject ) '}' )? ;

cAttributeMatcherDef: cRegularObjectMatcher+ ;

cRegularObjectMatcher:
      cComplexObjectMatcher
    | cRegularPrimitiveObject
    | cOrdinal
    | domainSpecificExtension
    ;
