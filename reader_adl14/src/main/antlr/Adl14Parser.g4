//
//  description: Antlr4 grammar for Archetype Definition Language (ADL2). This is a line-oriented
//               grammar designed to extract the verious sub-parts of an archetype and parse them
//               in a second pass, using the appropriate sub-language parser, ie. Cadl, EL, ODIN etc.
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  contributors:Pieter Bos <pieter.bos@nedap.com>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2015- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

//
// This grammar is separated to allow modes in the lexical part.
// Combined grammars can't have modes.
//
parser grammar Adl14Parser;
options { tokenVocab=Adl14Lexer; }

//
//  ======================= Top-level Objects ========================
//

adlObject: authoredArchetype EOF ;

//
// ------------------ Archetypes -------------------
//
authoredArchetype:
    SYM_ARCHETYPE header
    specializeSection?
    conceptSection
    languageSection
    descriptionSection
    definitionSection
    rulesSection?
    terminologySection
    annotationsSection?
    ;

//
// ------------------- header section --------------------
//

// Header: meta-data items in parentheses followed by archetype ID
header: metaData? ARCHETYPE_REF ;

metaData: '(' metaDataItem ( ';' metaDataItem )* METADATA_END ;

metaDataItem:
      metaDataValueItem
    | metaDataFlag
    ;

metaDataValueItem : ALPHANUM_ID '=' metaDataItemValue ;
metaDataFlag : ALPHANUM_ID ;

metaDataItemValue : ARCHETYPE_REF | GUID | VERSION_ID | ALPHANUM_ID | OID ;

// ------------------- specialise section --------------------
specializeSection : SPECIALIZE_HEADER ARCHETYPE_REF ;

//
// Archetype content sections follow the pattern
//   SectionId Lines*
// The lines (i.e. text block) of each section is passed to the appropriate kind of
// specific parser.
//
conceptSection     : CONCEPT_HEADER SYM_LBRACKET ADL14_AT_CODE SYM_RBRACKET ;
languageSection    : LANGUAGE_HEADER odinText ;
descriptionSection : DESCRIPTION_HEADER odinText ;
definitionSection  : DEFINITION_HEADER cadlText ;
rulesSection       : RULES_HEADER elText ;
terminologySection : TERMINOLOGY_HEADER odinText ;
annotationsSection : ANNOTATIONS_HEADER odinText ;

odinText : ODIN_LINE+ ;
cadlText : CADL_LINE+ ;
elText   : EL_LINE+ ;
