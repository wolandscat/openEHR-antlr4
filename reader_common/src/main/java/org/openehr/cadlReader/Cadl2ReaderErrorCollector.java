package org.openehr.cadlReader;

import org.openehr.antlr.IANTLRParserErrors;
import org.openehr.antlr.MultiSyntaxErrorCollector;

public class Cadl2ReaderErrorCollector extends MultiSyntaxErrorCollector {

    // ------------------ Member Access ------------------

    public IANTLRParserErrors getCadlErrors() {
        return errorTable.get (Cadl2ReaderDefinitions.CADL_ARTEFACT_NAME);
    }

    public IANTLRParserErrors getDefaultBlockErrors() {
        return errorTable.get (Cadl2ReaderDefinitions.DEFAULT_BLOCK_NAME);
    }

    // ------------------ Modification ------------------

    public void setCadlErrors(IANTLRParserErrors cadlErrors) {
        errorTable.put (Cadl2ReaderDefinitions.CADL_ARTEFACT_NAME, cadlErrors);
    }

    public void setDefaultBlockErrors(IANTLRParserErrors defaultBlockErrors) {
        errorTable.put (Cadl2ReaderDefinitions.DEFAULT_BLOCK_NAME, defaultBlockErrors);
    }

}
