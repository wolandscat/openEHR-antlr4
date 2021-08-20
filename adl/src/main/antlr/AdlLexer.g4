//
//  description: Antlr4 lexer rules for Archetype Definition Language (ADL2), based on two-pass
//               approach used in associated AdlParser.
//  author:      Thomas Beale <thomas.beale@openehr.org>
//  contributors:Pieter Bos <pieter.bos@nedap.com>
//  support:     openEHR Specifications PR tracker <https://openehr.atlassian.net/projects/SPECPR/issues>
//  copyright:   Copyright (c) 2015- openEHR Foundation <http://www.openEHR.org>
//  license:     Apache 2.0 License <http://www.apache.org/licenses/LICENSE-2.0.html>
//

lexer grammar AdlLexer;
import OpenehrPatterns;

// ------------------- MODE: default --------------------
//  lines and comments
H_CMT_LINE : '--------' '-'*? EOL  ;            // long comment line for splitting ADL2 template overlays
CMT_LINE   : '--' .*? EOL -> skip ;             // increment line count
EOL        : '\r'? '\n'   -> channel(HIDDEN) ;  // throw out EOLs in default mode
WS         : [ \t\r]+     -> channel(HIDDEN) ;

// ADL keywords
SYM_ARCHETYPE            : [Aa][Rr][Cc][Hh][Ee][Tt][Yy][Pp][Ee] -> mode (HEADER) ;
SYM_TEMPLATE_OVERLAY     : [Tt][Ee][Mm][Pp][Ll][Aa][Tt][Ee]'_'[Oo][Vv][Ee][Rr][Ll][Aa][Yy] -> mode (HEADER) ;
SYM_TEMPLATE             : [Tt][Ee][Mm][Pp][Ll][Aa][Tt][Ee] -> mode (HEADER) ;
SYM_OPERATIONAL_TEMPLATE : [Oo][Pp][Ee][Rr][Aa][Tt][Ii][Oo][Nn][Aa][Ll]'_'[Tt][Ee][Mm][Pp][Ll][Aa][Tt][Ee] -> mode (HEADER) ;

// ------------------- MODE: header section --------------------
// Pick up meta-data keywords and symbols
mode HEADER;
WS_H: WS   -> channel(HIDDEN) ;

SPECIALIZE_SECTION      : EOL SYM_SPECIALIZE EOL -> mode (SPECIALIZE) ;
fragment SYM_SPECIALIZE : [Ss][Pp][Ee][Cc][Ii][Aa][Ll][Ii][SsZz][Ee] ;

LANGUAGE_SECTION      : EOL SYM_LANGUAGE EOL -> mode (LANGUAGE) ;
fragment SYM_LANGUAGE : [Ll][Aa][Nn][Gg][Uu][Aa][Gg][Ee] ;

// definition section occurs after header for template overlays
DEFINITION_SECTION      : EOL SYM_DEFINITION EOL -> mode (DEFINITION) ;
fragment SYM_DEFINITION : [Dd][Ee][Ff][Ii][Nn][Ii][Tt][Ii][Oo][Nn] ;

METADATA_START  : '(' ;
METADATA_END    : ')' EOL ;
METADATA_SEP    : ';' ;
SYM_EQ          : '=' ;

// include here any kind of id or other special string that can occur in meta-data
ARCHETYPE_HRID2 : ARCHETYPE_HRID -> type (ARCHETYPE_HRID) ;
GUID2           : GUID -> type (GUID) ;
VERSION_ID2     : VERSION_ID -> type (VERSION_ID) ;
ALPHANUM_ID     : [a-zA-Z0-9][a-zA-Z0-9_]* ;

EOL_H: EOL -> channel(HIDDEN) ;

// ------------------- MODE: specialise section --------------------
// look for 'language' section, otherwise grab complete lines
mode SPECIALIZE;
WS_S: WS   -> channel(HIDDEN) ;
LANGUAGE_SECTION2: EOL SYM_LANGUAGE EOL -> mode (LANGUAGE), type(LANGUAGE_SECTION) ;
ARCHETYPE_REF_2 : ARCHETYPE_REF -> type (ARCHETYPE_REF) ;
EOL_S: EOL -> channel(HIDDEN) ;

// ------------------- MODE: language section --------------------
// look for 'description' section, otherwise grab complete lines
mode LANGUAGE;
DESCRIPTION_SECTION      : SYM_DESCRIPTION WS? EOL -> mode (DESCRIPTION) ;
ODIN_LINE                : NON_EOL* EOL ;
fragment SYM_DESCRIPTION : [Dd][Ee][Ss][Cc][Rr][Ii][Pp][Tt][Ii][Oo][Nn] ;
fragment NON_EOL         : ~'\n' ;

// ------------------- MODE: description section --------------------
// look for 'definition' section, otherwise grab complete lines
mode DESCRIPTION ;
DEFINITION_SECTION2: SYM_DEFINITION WS? EOL -> mode (DEFINITION), type(DEFINITION_SECTION);
ODIN_LINE_DESC     : NON_EOL* EOL -> type (ODIN_LINE);

// ------------------- MODE: definition section --------------------
// look for 'rules' and/or 'terminology' sections,
// otherwise grab complete lines
// comments are used in the definition section, so we throw them out.
// Remove the CMT_LINE2 rule to keep them for later processing
mode DEFINITION ;
CMT_LINE2   : CMT_LINE -> skip ;
RULES_SECTION           : SYM_RULES WS? EOL -> mode (RULES);
TERMINOLOGY_SECTION     : SYM_TERMINOLOGY WS? EOL -> mode (TERMINOLOGY);
CADL_LINE               : NON_EOL* EOL ;
fragment SYM_RULES      : [Rr][Uu][Ll][Ee][Ss] ;
fragment SYM_TERMINOLOGY: [Tt][Ee][Rr][Mm][Ii][Nn][Oo][Ll][Oo][Gg][Yy] ;

// ------------------- MODE: rules section --------------------
// look for 'terminology' section, otherwise grab complete lines
mode RULES ;
TERMINOLOGY_SECTION2 : SYM_TERMINOLOGY WS? EOL -> mode (TERMINOLOGY), type (TERMINOLOGY_SECTION);
EL_LINE              : NON_EOL* EOL ;

// ------------------- MODE: terminology section --------------------
// look for 'annotations' and/or 'component_terminologies' sections or end,
// otherwise grab complete lines; allow for final line with no EOL
mode TERMINOLOGY;
ANNOTATIONS_SECTION             : SYM_ANNOTATIONS WS? EOL -> mode (ANNOTATIONS);
COMPONENT_TERMINOLOGIES_SECTION : SYM_COMPONENT_TERMINOLOGIES WS? EOL+ -> mode (COMPONENT_TERMINOLOGIES);
TEMPLATE_DIVIDER                : H_CMT_LINE -> channel(HIDDEN), mode (DEFAULT_MODE) ;
ODIN_LINE_TERM                  : ( NON_EOL* EOL | NON_EOL+ ) -> type (ODIN_LINE) ;
fragment SYM_ANNOTATIONS        : [Aa][Nn][Nn][Oo][Tt][Aa][Tt][Ii][Oo][Nn][Ss] ;
fragment SYM_COMPONENT_TERMINOLOGIES : [Cc][Oo][Mm][Pp][Oo][Nn][Ee][Nn][Tt]'_'[Tt][Ee][Rr][Mm][Ii][Nn][Oo][Ll][Oo][Gg][Ii][Ee][Ss] ;

// ------------------- MODE: annotations section --------------------
// look for 'component_terminologies' section or end,
// otherwise grab complete lines; allow for final line with no EOL
mode ANNOTATIONS;
COMPONENT_TERMINOLOGIES_SECTION2 : SYM_COMPONENT_TERMINOLOGIES WS? EOL+ -> mode (COMPONENT_TERMINOLOGIES), type (COMPONENT_TERMINOLOGIES_SECTION);
TEMPLATE_DIVIDER2                : H_CMT_LINE -> channel(HIDDEN), mode (DEFAULT_MODE) ;
ODIN_LINE_ANNOT                  : ( NON_EOL* EOL | NON_EOL+ ) -> type (ODIN_LINE) ;

// ------------- MODE: component_terminologies section ---------------
// grab complete lines; allow for final line with no EOL
mode COMPONENT_TERMINOLOGIES;
ODIN_LINE_CT : ( NON_EOL* EOL | NON_EOL+ ) -> type (ODIN_LINE) ;

