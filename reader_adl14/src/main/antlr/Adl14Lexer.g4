//
//  description: Antlr4 lexer rules for Archetype Definition Language (ADL2), based on two-pass
//               approach used in associated AdlParser.
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  contributors:Pieter Bos <pieter.bos@nedap.com>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2015- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar Adl14Lexer;
import OpenehrIdsLexer;

channels {
    COMMENT
}

// ------------------- MODE: default --------------------
//  lines and comments
CMT_LINE   : '--' .*? EOL -> channel(COMMENT) ;
EOL        : '\r'? '\n'   -> channel(HIDDEN) ;  // throw out EOLs in default mode
WS         : [ \t\r]+     -> channel(HIDDEN) ;

// ADL keywords
SYM_ARCHETYPE            : 'archetype' -> mode (HEADER) ;

// ------------------- MODE: header section --------------------
// Pick up meta-data keywords and symbols
mode HEADER;
WS_H: WS -> channel(HIDDEN) ;

SPECIALIZE_HEADER : SYM_SPECIALIZE EOL -> mode (SPECIALIZE) ;
fragment SYM_SPECIALIZE: 'specialise' | 'specialize' ;

CONCEPT_HEADER  : SYM_CONCEPT EOL -> mode (CONCEPT) ;
fragment SYM_CONCEPT : 'concept' ;

METADATA_START : '(' ;
METADATA_END   : ')' EOL ;
SYM_EQ         : '=' ;
SYM_SEMI_COLON : ';' ;

// include here any kind of id or other special string that can occur in meta-data
ARCHETYPE_REF2 : ARCHETYPE_REF -> type (ARCHETYPE_REF) ;
GUID2          : GUID -> type (GUID) ;
VERSION_ID2    : VERSION_ID -> type (VERSION_ID) ;
ALPHANUM_ID    : [a-zA-Z0-9][a-zA-Z0-9_]* ;
// we define a rule for matching OIDs here because they are only
// needed in the archetype header; if we add them to the PrimitiveTypesLexer
// the rule may match real numbers, version ids etc.
OID: INTEGER ( '.' INTEGER )+ ;

EOL_H: EOL -> channel(HIDDEN) ;

// ------------------- MODE: specialise section --------------------
// look for 'language' section, otherwise grab complete lines
mode SPECIALIZE;
WS_S             : WS   -> channel(HIDDEN) ;
CONCEPT_HEADER_2 : SYM_CONCEPT EOL -> mode (CONCEPT), type (CONCEPT_HEADER) ;
ARCHETYPE_REF_3  : ARCHETYPE_REF -> type (ARCHETYPE_REF) ;
EOL_S            : EOL -> channel(HIDDEN) ;

// ------------------- MODE: concept section --------------------
// look for 'language' section, otherwise grab complete lines
mode CONCEPT;
CMT_LINE_C    : CMT_LINE -> channel(COMMENT), type (CMT_LINE) ;
LANGUAGE_HEADER : SYM_LANGUAGE EOL -> mode (LANGUAGE) ;
fragment SYM_LANGUAGE: 'language' ;
CONCEPT_START : WS? SYM_LBRACKET -> type (SYM_LBRACKET);
CONCEPT_END   : SYM_RBRACKET WS? -> type (SYM_RBRACKET);
CONCEPT_TERM  : ADL14_AT_CODE -> type (ADL14_AT_CODE);
EOL_C         : EOL -> channel(HIDDEN) ;

SYM_LBRACKET : '[' ;
SYM_RBRACKET : ']' ;

// ------------------- MODE: language section --------------------
// look for 'description' section, otherwise grab complete lines
mode LANGUAGE;
DESCRIPTION_HEADER       : SYM_DESCRIPTION WS? EOL -> mode (DESCRIPTION) ;
ODIN_LINE                : NON_EOL* EOL ;
fragment SYM_DESCRIPTION : 'description' ;
fragment NON_EOL         : ~'\n' ;

// ------------------- MODE: description section --------------------
// look for 'definition' section, otherwise grab complete lines
mode DESCRIPTION ;
DEFINITION_HEADER      : EOL SYM_DEFINITION EOL -> mode (DEFINITION) ;
fragment SYM_DEFINITION : 'definition' ;
ODIN_LINE_DESC    : NON_EOL* EOL -> type (ODIN_LINE);

// ------------------- MODE: definition section --------------------
// look for 'rules' and/or 'terminology' sections,
// otherwise grab complete lines
// comments are used in the definition section, so we throw them out.
// Remove the CMT_LINE2 rule to keep them for later processing
mode DEFINITION ;
CMT_LINE2               : CMT_LINE -> channel(COMMENT), type (CMT_LINE) ;
RULES_HEADER            : SYM_RULES WS? EOL -> mode (RULES);
TERMINOLOGY_HEADER      : SYM_TERMINOLOGY WS? EOL -> mode (TERMINOLOGY);
CADL_LINE               : NON_EOL* EOL ;
fragment SYM_RULES      : 'invariant' ;
fragment SYM_TERMINOLOGY: 'ontology' ;
fragment SLASH_REGEX_CHAR: ~[/\n\r] | ESCAPE_SEQ | '\\/';


// ------------------- MODE: rules section --------------------
// look for 'terminology' section, otherwise grab complete lines
mode RULES ;
TERMINOLOGY_HEADER2 : SYM_TERMINOLOGY WS? EOL -> mode (TERMINOLOGY), type (TERMINOLOGY_HEADER);
EL_LINE             : NON_EOL* EOL ;

// ------------------- MODE: terminology section --------------------
// look for 'annotations' and/or 'component_terminologies' sections or end,
// otherwise grab complete lines; allow for final line with no EOL
mode TERMINOLOGY;
ANNOTATIONS_HEADER             : SYM_ANNOTATIONS WS? EOL -> mode (ANNOTATIONS);
ODIN_LINE_TERM                 : ( NON_EOL* EOL | NON_EOL+ ) -> type (ODIN_LINE) ;
fragment SYM_ANNOTATIONS       : 'annotations' ;

// ------------------- MODE: annotations section --------------------
// look for 'component_terminologies' section or end,
// otherwise grab complete lines; allow for final line with no EOL
mode ANNOTATIONS;
ODIN_LINE_ANNOT                 : ( NON_EOL* EOL | NON_EOL+ ) -> type (ODIN_LINE) ;
