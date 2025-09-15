//
//  description: Antlr4 grammar for openEHR BMM Language based on BMM meta-model.
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2016- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

parser grammar BmmlParser;
options { tokenVocab=BmmlLexer; }
// import ElParser;


// ========================== BMML Classes ==========================

bmmClass: SYM_ABSTRACT? SYM_CLASS (SYM_INHERIT typeId ( ',' typeId )* )? '{'  '}' ; // bmmFeature+ bmmInvariant* '}' ;


// -------------------- constants, singletons, properties -------------------

bmmFeature: bmmInstantiableFeature | bmmRoutine ;

bmmInstantiableFeature: bmmStatic | bmmProperty ;

bmmStatic: SYM_CONSTANT ( bmmConstant | bmmSingleton ) ;

bmmConstant: bmmConstantId ':' typeId ( SYM_EQ elExpression )? ;

bmmConstantId: UC_ID ;

bmmSingleton: UC_ID;

bmmProperty: SYM_PROPERTY ( bmmUnitaryProperty | bmmContainerProperty | bmmIndexedContainerProperty ) ;

bmmUnitaryProperty: UC_ID;
bmmContainerProperty: UC_ID;
bmmIndexedContainerProperty: UC_ID;

// ------------------------------ routines -----------------------------------

bmmRoutine: bmmProcedure | bmmFunction ;

bmmProcedure: ;

bmmFunction: ;

// ------------------------------ invariants -----------------------------------

bmmInvariant: ;

// ------------------------------ types -----------------------------------

typeId: UC_ID ( '<' typeId ( ',' typeId )* '>' )? ;



