//
//  description:  ANTLR4 parser grammar for Archetype Query Language (AQL)
//  authors:      Thomas Beale, Ars Semantica UK, openEHR Foundation Management Board
//  contributors:
//  support:      openEHR Specifications PR tracker <https://specifications.openehr.org/releases/QUERY/open_issues>
//  copyright:    Copyright (c) 2021- openEHR Foundation
//  license:      Creative Commons CC-BY-SA <https://creativecommons.org/licenses/by-sa/3.0/>
//

parser grammar AqlParser;
import Cadl14Parser;
options { tokenVocab=AqlLexer; }

//
// --------------- top-level parts of query --------------
//

aqlQuery
    : selectClause fromClause whereClause? orderByClause? limitClause? SYM_DOUBLE_DASH? EOF
    ;

selectClause: SYM_SELECT SYM_DISTINCT? top? resultTable;

fromClause: SYM_FROM modelTypeConstraint ;

whereClause: SYM_WHERE whereExpr ;

orderByClause: SYM_ORDER SYM_BY orderByExpr ( ',' orderByExpr )* ;

limitClause: SYM_LIMIT limit=INTEGER ( SYM_OFFSET offset=INTEGER ) ? ;

//
// --------------------- SELECT sub-parts -----------------------
//

resultTable: columnSpec ( ',' columnSpec )* ;

columnSpec: columnValue ( SYM_AS columnAlias )? ;

columnAlias: LC_ID | UC_ID ;

columnValue:
      dataMatchPath
    | aggregateFunctionCall
    | functionCall
    | primitiveLiteral
    ;

orderByExpr: modelPath order=( SYM_DESCENDING | SYM_DESC | SYM_ASCENDING | SYM_ASC )? ;

//
// ------------------------ FROM sub-parts ------------------------
//

//
// Constraint on model type that defines the data against which the query is evaluated.
// In general this is a CONTAINS chain of type constraints, which are:
//      * a reference model type, e.g. 'EHR'
//      * an archetyped reference model type, e.g. COMPOSITION[openEHR-EHR-COMPOSITION.report.v1]
//      * a further CONTAINS chain
//      * a logical expression of any of the above
//
modelTypeConstraint:
      modelType
    | modelTypeChain
    ;

modelTypeChain: modelType SYM_NOT? SYM_CONTAINS modelTypeSubChain ;

modelTypeSubChain:
      modelTypeConstraint
    | '(' modelTypeExpr ')'
    ;

modelTypeExpr:
      SYM_NOT modelTypeExpr
    | modelTypeExpr SYM_AND modelTypeExpr
    | modelTypeExpr SYM_OR modelTypeExpr
    | modelTypeConstraint
    | '(' modelTypeExpr ')'
    ;

modelType: typeName=UC_ID variableName=LC_ID? ( '[' archetypeIdPredicate ']' )? ;

//
// --------------- WHERE sub-parts --------------
//

whereExpr:
      SYM_NOT whereExpr
    | whereExpr SYM_AND whereExpr
    | whereExpr SYM_OR whereExpr
    | '(' whereExpr ')'
    | whereBooleanLeaf
    ;

//
// Boolean-returning expressions with dataMatchPath as an operand
//
whereBooleanLeaf:
      SYM_EXISTS dataMatchPath
    | comparisonOperand SYM_MATCHES matchesOperand
    | dataMatchPath SYM_LIKE likeOperand
    | dataMatchPath comparisonOperator comparisonOperand
    | functionCall comparisonOperator comparisonOperand
    ;

comparisonOperand:
      value
    | arithmeticExpr
    ;

value:
      dataMatchPath
    | primitiveLiteral
    | functionCall
    | PARAMETER
    ;

likeOperand:
      STRING
    | PARAMETER
    ;

matchesOperand:
      '{' matchesConstraint '}'
    | terminologyFunctionCall
    ;

matchesConstraint:
      cObjectMatcher
    | AQL_URI
    | PARAMETER
    ;

//
// Expressions evaluating to arithmetic values, using standard precedence
//
arithmeticExpr:
      <assoc=right> arithmeticExpr '^' arithmeticExpr
    | arithmeticExpr ( '/' | '*' | '%' ) arithmeticExpr
    | arithmeticExpr ( '+' | '-' ) arithmeticExpr
    | arithmeticLeaf
    ;

arithmeticLeaf:
      arithmeticLiteral
    | value
    | '(' arithmeticExpr ')'
    ;

//
// Note that we use string-quoted date/time literals here in AQL,
// not the bare literals used in the rest of openEHR
//
arithmeticLiteral:
      integerValue
    | realValue
    | aqlDateTimeLiteral
    | durationValue
    ;

//
// ----------------------- paths ------------------------
//

//
// A path to match an item in data, based on an archetype path with
// additional runtime constraint predicates. A degenerate form of
// a dataPath (no predicates) looks like a modelPath
//
dataMatchPath: variableName=LC_ID dataMatchPathSegment* ;
    
dataMatchPathSegment: '/' attributeId=LC_ID ( '[' dataMatchPathPredicate ']' )? ;

//
// Predicates on a data path node, which are of the general form
//  * archetypeId or nodeId (identifying where we are in the archetype), and optionally
//  further value constraints, linked by Boolean operators, e.g.
//  * name/value=$nameValue
//  * name/defining_code/code_string='F60.1' and name/defining_code/terminology_id/value='icd10AM'
//
// The value constraints may have model-specific shortcuts of the form:
//  * ", value"
// which means 'AND /some/path = value', where the '/some/path' is a path specific to the
// reference model, which is assumed (typically a long, commonly used path)
//
dataMatchPathPredicate: adlPathPredicate ( SYM_AND dataMatchPathValuePredicate | ',' modelSpecificPredicateShortcut )? ;

//
// Node-level Boolean-returning predicates based on value
//
dataMatchPathValuePredicate:
      modelPath SYM_MATCHES CONTAINED_REGEX
    | modelPath comparisonOperator modelPathComparatorValue
    | dataMatchPathValuePredicate SYM_AND dataMatchPathValuePredicate
    | dataMatchPathValuePredicate SYM_OR dataMatchPathValuePredicate
    | '(' dataMatchPathValuePredicate ')'
    ;

modelPathComparatorValue:
      primitiveLiteral
    | modelPath
    | PARAMETER
    ;

versionPredicate
    : SYM_LATEST_VERSION
    | SYM_ALL_VERSIONS
    ;


//
// --------------------- function calls ---------------------
//

//
// A function call is either one of various fixed types of function calls,
// including terminology(), and the usual count(), max() and similar 
// aggregate functions, or else a generic function call.
//
functionCall:
      terminologyFunctionCall
    | builtInFunction functionArgs
    | LC_ID functionArgs
    ;

functionArgs: '(' ( value ( ',' value )* )? ')' ;

aggregateFunctionCall
    : name=SYM_COUNT '(' ( SYM_DISTINCT? augmentedAdlPath | '*' ) ')'
    | aggregateMathFunction '(' augmentedAdlPath ')'
    ;

aggregateMathFunction:
      SYM_MIN
    | SYM_MAX
    | SYM_SUM
    | SYM_AVG
    ;

terminologyFunctionCall: SYM_TERMINOLOGY '(' operation=STRING ',' source=STRING ',' ( stringFunction functionArgs | STRING ) ')' ;

// built-in functions
builtInFunction: stringFunction | numericFunction | dateTimeFunction ;
stringFunction: SYM_LENGTH | SYM_CONTAINS | SYM_POSITION | SYM_SUBSTRING | SYM_CONCAT_WS | SYM_CONCAT ;
numericFunction: SYM_ABS | SYM_MOD | SYM_CEIL | SYM_FLOOR | SYM_ROUND ;
dateTimeFunction: SYM_NOW | SYM_CURRENT_DATE_TIME | SYM_CURRENT_DATE | SYM_CURRENT_TIMEZONE | SYM_CURRENT_TIME ;

//
// ------------------------ operators --------------------
//

comparisonOperator:
      SYM_EQ
    | SYM_NE
    | SYM_GT
    | SYM_GE
    | SYM_LT
    | SYM_LE
    ;

//
// --------------------- literal values ------------------
//
primitiveLiteral:
      STRING
    | numericLiteral
    | aqlDateTimeLiteral
    | BOOLEAN
    | SYM_NULL
    ;

numericLiteral:
      INTEGER
    | REAL
    | SCI_INTEGER
    | SCI_REAL
    | SYM_MINUS numericLiteral
    ;

//
// AQL uses string-quoted date/time literals
//
aqlDateTimeLiteral:
      DATE_STRING
    | TIME_STRING
    | DATE_TIME_STRING
    ;


//
// =================== openEHR specific syntax ======================
//
modelSpecificPredicateShortcut: STRING | idCode | QUALIFIED_TERM_CODE ;


//
// =================== deprecated ======================
//
top: SYM_TOP INTEGER direction=( SYM_FORWARD | SYM_BACKWARD )? ;
