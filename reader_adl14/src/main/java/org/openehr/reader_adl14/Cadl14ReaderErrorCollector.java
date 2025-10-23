package org.openehr.reader_adl14;

import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr.MultiSyntaxErrorCollector;

public class Cadl14ReaderErrorCollector extends MultiSyntaxErrorCollector {

    // ------------------ Member Access ------------------

    public IANTLRParserErrors getCadlErrors() {
        return errorTable.get (Cadl14ReaderDefinitions.CADL_ARTEFACT_NAME);
    }

    public IANTLRParserErrors getDefaultBlockErrors() {
        return errorTable.get (Cadl14ReaderDefinitions.EMBEDDED_ODIN_BLOCK_NAME);
    }

    // ------------------ Modification ------------------

    public void setCadlErrors(IANTLRParserErrors cadlErrors) {
        errorTable.put (Cadl14ReaderDefinitions.CADL_ARTEFACT_NAME, cadlErrors);
    }

    public void setDefaultBlockErrors(IANTLRParserErrors defaultBlockErrors) {
        errorTable.put (Cadl14ReaderDefinitions.EMBEDDED_ODIN_BLOCK_NAME, defaultBlockErrors);
    }

}
