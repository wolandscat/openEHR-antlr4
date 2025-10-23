package org.openehr.reader_adl14;

import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr.MultiSyntaxErrorCollector;

public class Adl14ReaderErrorCollector extends MultiSyntaxErrorCollector {

    // ------------------ Member Access ------------------

    public IANTLRParserErrors getAdlErrors() {
        return errorTable.get(Adl14ReaderDefinitions.ADL_ARTEFACT_NAME);
    }

    public IANTLRParserErrors getLanguageErrors() {
        return errorTable.get(Adl14ReaderDefinitions.LANGUAGE_SECTION_NAME);
    }

    public IANTLRParserErrors getDescriptionErrors() {
        return errorTable.get (Adl14ReaderDefinitions.DESCRIPTION_SECTION_NAME);
    }

    public IANTLRParserErrors getDefinitionErrors() {
        return errorTable.get(Adl14ReaderDefinitions.DEFINITION_SECTION_NAME);
    }

    public IANTLRParserErrors getRulesErrors() {
        return errorTable.get(Adl14ReaderDefinitions.RULES_SECTION_NAME);
    }

    public IANTLRParserErrors getRmOverlayErrors() {
        return errorTable.get(Adl14ReaderDefinitions.RM_OVERLAY_SECTION_NAME);
    }

    public IANTLRParserErrors getTerminologyErrors() {
        return errorTable.get(Adl14ReaderDefinitions.TERMINOLOGY_SECTION_NAME);
    }

    public IANTLRParserErrors getAnnotationsErrors() {
        return errorTable.get(Adl14ReaderDefinitions.ANNOTATIONS_SECTION_NAME);
    }

    public IANTLRParserErrors getComponentsTerminologiesErrors() {
        return errorTable.get(Adl14ReaderDefinitions.COMPONENT_TERMINOLOGIES_SECTION_NAME);
    }


    // ------------------ Modification ------------------

    public void setAdlErrors(IANTLRParserErrors adlErrors) {
        errorTable.put(Adl14ReaderDefinitions.ADL_ARTEFACT_NAME, adlErrors);
    }

    public void setLanguageErrors(IANTLRParserErrors languageErrors) {
        errorTable.put(Adl14ReaderDefinitions.LANGUAGE_SECTION_NAME, languageErrors);
    }

    public void setDescriptionErrors(IANTLRParserErrors descriptionErrors) {
        errorTable.put(Adl14ReaderDefinitions.DESCRIPTION_SECTION_NAME, descriptionErrors);
    }

    public void setDefinitionErrors(IANTLRParserErrors definitionErrors) {
        errorTable.put(Adl14ReaderDefinitions.DEFINITION_SECTION_NAME, definitionErrors);
    }

    public void setRulesErrors(IANTLRParserErrors rulesErrors) {
        errorTable.put(Adl14ReaderDefinitions.RULES_SECTION_NAME, rulesErrors);
    }

    public void setRmOverlayErrors(IANTLRParserErrors rmOverlayErrors) {
        errorTable.put(Adl14ReaderDefinitions.RM_OVERLAY_SECTION_NAME, rmOverlayErrors);
    }

    public void setTerminologyErrors(IANTLRParserErrors terminologyErrors) {
        errorTable.put(Adl14ReaderDefinitions.TERMINOLOGY_SECTION_NAME, terminologyErrors);
    }

    public void setAnnotationsErrors(IANTLRParserErrors annotationsErrors) {
        errorTable.put(Adl14ReaderDefinitions.ANNOTATIONS_SECTION_NAME, annotationsErrors);
    }

    public void setComponentsTerminologiesErrors(IANTLRParserErrors componentsTerminologiesErrors) {
        errorTable.put(Adl14ReaderDefinitions.COMPONENT_TERMINOLOGIES_SECTION_NAME, componentsTerminologiesErrors);
    }
}
