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

bmmClass: SYM_ABSTRACT? SYM_CLASS typeDecl bmmClassInheritDecl? bmmFeatureGroupDecl+ bmmInvariantDecl? ;

bmmClassInheritDecl: SYM_INHERIT typeId ( ',' typeId )* ;

// -------------------- constants, singletons, properties -------------------

bmmFeatureGroupDecl: SYM_FEATURE_GROUP '(' LC_ID ')' bmmFeatureDecl+ ;

bmmFeatureDecl: ( bmmInstantiableFeatureDecl | bmmRoutineDecl ) ';' ;

bmmInstantiableFeatureDecl: bmmStaticDecl | bmmPropertyDecl ;

bmmStaticDecl: constantDecl | bmmSingletonDecl ;

bmmSingletonDecl: UC_ID ':' typeSpecifier SYM_EQ statementBlock ;

bmmPropertyDecl: SYM_PROPERTY LC_ID ( ':' | ':?' ) typeSpecifier ;


// ------------------------------ routines -----------------------------------

bmmRoutineDecl: bmmProcedureDecl | bmmFunctionDecl ;

bmmProcedureDecl: SYM_PROCEDURE LC_ID bmmArgsDecl? ;

bmmFunctionDecl: SYM_FUNCTION LC_ID bmmArgsDecl? ( ':' | ':?' ) typeSpecifier ;

// nullable args not allowed - use overloads
bmmArgsDecl: '(' bmmArgDecl ( ',' bmmArgDecl )* ')' ;
bmmArgDecl: UC_ID ':' typeSpecifier ;

// ------------------------------ invariants -----------------------------------

bmmInvariantDecl: SYM_INVARIANT assertion+ ;

// ------------------------------ types -----------------------------------

typeSpecifier: typeId bmmMultiplicity? ;

bmmMultiplicity: '[' (( '0' | '1' ) '..' )? '*' ( multiplicityMod multiplicityMod? )? ']' ;

typeDecl: UC_ID ( '<' typeConstrained ( ',' typeConstrained )* '>' )? ;
typeConstrained: UC_ID ( ':' typeId )? ;



