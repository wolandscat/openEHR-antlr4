//
//  Path patterns lexer
//  author:      Thomas Beale <thomas.beale@openEHR.org>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2021- openEHR Foundation <http://www.openEHR.org>
//

parser grammar AdlPathParser;
options { tokenVocab=AdlPathLexer; }

//
// A path to a node in an archetype, which will potentially match
// one or more data items in runtime data
//
adlPath: ( '/' adlPathSegment )+ ;
adlPathSegment : LC_ID ( '[' adlPathPredicate ']' )? ;

adlPathPredicate:
      archetypeIdPredicate
    | idCode
    ;

archetypeIdPredicate: ARCHETYPE_REF ;

idCode:
      AT_CODE
    | ADL14_AT_CODE
    | ID_CODE
    ;

//
// A path to a node in an archetype with further model-based
// path, referring to structure not mentioned in the archetype
//
augmentedAdlPath: varName=LC_ID adlPath modelSubPath? ;

//
// A path within a type defined in the underlying reference model
//
modelPath: varName=LC_ID modelSubPath ;

modelSubPath: modelPathSegment+ ;

modelPathSegment: '/' attributeId=LC_ID ;
