//
//  description: Antlr4 grammar for openEHR BMM Language based on BMM meta-model.
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2016- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

parser grammar BmmlParser;
options { tokenVocab=BmmlLexer; }
import ElParser;


// ========================== BMML Classes ==========================

bmmModuleDef: bmmModuleImport* ( bmmClassDecl | bmmEnumDecl ) SYM_END EOF ;

bmmModuleImport: SYM_IMPORT bmmNamespaceId ';' ;

bmmNamespaceId: bmmNamespaceSegmentId ( '.' bmmNamespaceSegmentId )+ ;

bmmNamespaceSegmentId: LC_ID | UC_ID | WEB_ID ;

bmmClassDecl: SYM_ABSTRACT? SYM_CLASS typeDecl bmmClassInheritDecl? bmmFeatureGroup* bmmInvariantDecl? ;

bmmClassInheritDecl: SYM_INHERIT typeId ( ',' typeId )* ;

bmmEnumDecl: SYM_ENUMERATION typeDecl bmmEnumBaseDecl bmmEnumFeatureGroup ;

bmmEnumBaseDecl: SYM_BASE_TYPE typeId ;

// -------------------- enumerations -----------------------

bmmEnumFeatureGroup: bmmFeatureGroupDecl bmmEnumFeatureDecl+ ;

bmmEnumFeatureDecl: ( bmmIntegerDecl | bmmStringEnumDecl ) ';' ;

bmmIntegerDecl: bmmEnumId '(' INTEGER ')' ;

bmmStringEnumDecl: bmmEnumId '(' STRING ')' ;

bmmEnumId: LC_ID ;

// -------------------- constants, singletons, properties -------------------

bmmFeatureGroup: bmmFeatureGroupDecl bmmFeatureDecl+ ;

bmmFeatureGroupDecl: SYM_FEATURE_GROUP '(' STRING ')' ;

bmmFeatureDecl: ( bmmInstantiableFeatureDecl | bmmRoutineDecl ) ';' ;

bmmInstantiableFeatureDecl: bmmStaticDecl | bmmPropertyDecl ;

bmmStaticDecl: constantDecl | bmmSingletonDecl ;

bmmSingletonDecl: UC_ID ':' typeSpecifier SYM_EQ statementBlock ;

bmmPropertyDecl: SYM_PROPERTY LC_ID ( ':' | ':?' ) typeSpecifier ;


// ------------------------------ routines -----------------------------------

bmmRoutineDecl: SYM_ABSTRACT? ( bmmProcedureDecl | bmmFunctionDecl ) bmmPrecondBlock? bmmStatementBlock? bmmPostcondBlock? ;

bmmProcedureDecl: SYM_PROCEDURE LC_ID bmmArgsDecl? ;

bmmFunctionDecl: SYM_FUNCTION LC_ID bmmArgsDecl? ( ':' | ':?' ) typeSpecifier ;

// nullable args not allowed - use overloads
bmmArgsDecl: '(' bmmArgDecl ( ',' bmmArgDecl )* ')' ;
bmmArgDecl: LC_ID ':' typeSpecifier ;

bmmPrecondBlock: SYM_PRECOND ( elBooleanExpr ';' )+ ;
bmmPostcondBlock: SYM_POSTCOND ( elBooleanExpr ';' )+ ;

bmmStatementBlock: SYM_DO statement+;

// ------------------------------ invariants -----------------------------------

bmmInvariantDecl: SYM_INVARIANT ( assertion ';' ) + ;

// ------------------------------ types -----------------------------------

typeSpecifier: ( typeValueConstrained | typePlusMultiplicity ) ;
typeValueConstrained: typeId bmmValueConstraint? ;
typePlusMultiplicity: typePlusMultiplicitySingle | typePlusMultiplicityMap ;

typePlusMultiplicitySingle: ( SYM_MULTIPLICITY_SET | SYM_MULTIPLICITY_ARRAY | SYM_MULTIPLICITY_LIST ) typeValueConstrained '>' ;
typePlusMultiplicityMap: SYM_MULTIPLICITY_MAP typeValueConstrained ',' typeValueConstrained '>' ;

bmmValueConstraint: SYM_LEFT_GUILLEMET bmmNamespaceId SYM_RIGHT_GUILLEMET ;

typeDecl: UC_ID ( '<' typeConstrained ( ',' typeConstrained )* '>' )? ;
typeConstrained: UC_ID ( ':' typeId )? ;



