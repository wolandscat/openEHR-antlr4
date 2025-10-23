//
//  description:  ANTLR4 lexer grammar for Archetype Query Language (AQL) general identifiers
//  authors:      Thomas Beale, Ars Semantica UK, openEHR Foundation Management Board
//  support:      openEHR Specifications PR tracker <https://specifications.openehr.org/releases/QUERY/open_issues>
//  copyright:    Copyright (c) 2021- openEHR Foundation
//  license:      Creative Commons CC-BY-SA <https://creativecommons.org/licenses/by-sa/3.0/>
//

lexer grammar AqlGeneral;
import GeneralIdsLexer;

// general identifiers
PARAMETER: '$' ALPHA_CHAR ALPHANUM_US_CHAR*;
