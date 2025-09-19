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

bmmClass: SYM_ABSTRACT? SYM_CLASS (SYM_INHERIT typeId ( ',' typeId )* )? bmmFeature+ bmmInvariant* ;


// -------------------- constants, singletons, properties -------------------

bmmFeature: ( bmmInstantiableFeature | bmmRoutine ) ';' ;

bmmInstantiableFeature: bmmStatic | bmmProperty ;

bmmStatic: constantDeclaration | bmmSingleton ;

bmmSingleton: UC_ID ':' typeSpecifier SYM_EQ statementBlock ;

bmmProperty: SYM_PROPERTY typeSpecifier ;


// ------------------------------ routines -----------------------------------

bmmRoutine: bmmProcedure | bmmFunction ;

bmmProcedure: ;

bmmFunction: typeId ;

// ------------------------------ invariants -----------------------------------

bmmInvariant: ;

// ------------------------------ types -----------------------------------

typeSpecifier: typeId bmmMultiplicity? bmmNullableMarker? ;

bmmMultiplicity: '[' (( '0' | '1' ) '..' )? '*' ( multiplicityMod multiplicityMod? )? ']' ;
bmmNullableMarker: '?' ;

typeId: UC_ID ( '<' typeId ( ',' typeId )* '>' )? ;



